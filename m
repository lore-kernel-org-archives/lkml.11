Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A72C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 15:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbiDEPIn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345545AbiDEJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:43:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F8B237ED;
        Tue,  5 Apr 2022 02:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E8B4B81CA4;
        Tue,  5 Apr 2022 09:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E85C385A2;
        Tue,  5 Apr 2022 09:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649150949;
        bh=YFr4/nojKaAOU/ZZjc5sHloKXZS8yH7kQ2huS/c3kYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I95BWDWkLihO4K/T/1wQh5dHyFkYj3BKdOIMPYQ0xsXd+UzM7ORuqPK0UWw1YYjht
         cR+Rk85HFUX9zj3Bdn7lnauX0WCBLwL85hsykz8hJ6eXK5fQtHaZwN3wmD/66jFlVS
         3ekLmWHjG3Rpckb8cTItuHEbvfo+IAYcnc6QkIBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianglei Nie <niejianglei2021@163.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 238/913] crypto: ccree - Fix use after free in cc_cipher_exit()
Date:   Tue,  5 Apr 2022 09:21:40 +0200
Message-Id: <20220405070346.989696538@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
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



