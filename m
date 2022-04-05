Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0FC352A1
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiDEImm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiDEH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:56:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5067C4160C;
        Tue,  5 Apr 2022 00:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB93AB81B90;
        Tue,  5 Apr 2022 07:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057C5C3410F;
        Tue,  5 Apr 2022 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145047;
        bh=YFr4/nojKaAOU/ZZjc5sHloKXZS8yH7kQ2huS/c3kYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaM7U76lD3USeLJl+aE8SkOefRAFZSOS4dVnXSBusAVAUqefzg5cz16NBNxaxN6rj
         tCYoVKEJQVQ/nlwivRKGbX9pt2W+fhYM0W/XOLVcIT3eeWJgoCL20fw8/vowRacC12
         D2x/yNEpVb/stz7YbD6B3dEhNbcSXP7ghDTd6rfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianglei Nie <niejianglei2021@163.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0258/1126] crypto: ccree - Fix use after free in cc_cipher_exit()
Date:   Tue,  5 Apr 2022 09:16:45 +0200
Message-Id: <20220405070415.183638436@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit 3d950c34074ed74d2713c3856ba01264523289e6 ]

kfree_sensitive(ctx_p->user.key) will free the ctx_p->user.key. But
ctx_p->user.key is still used in the next line, which will lead to a
use after free.

We can call kfree_sensitive() after dev_dbg() to avoid the uaf.

Fixes: 63ee04c8b491 ("crypto: ccree - add skcipher support")
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccree/cc_cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 78833491f534..309da6334a0a 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -257,8 +257,8 @@ static void cc_cipher_exit(struct crypto_tfm *tfm)
 		&ctx_p->user.key_dma_addr);
 
 	/* Free key buffer in context */
-	kfree_sensitive(ctx_p->user.key);
 	dev_dbg(dev, "Free key buffer in context. key=@%p\n", ctx_p->user.key);
+	kfree_sensitive(ctx_p->user.key);
 }
 
 struct tdes_keys {
-- 
2.34.1



