Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E1C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiDEIBz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiDEHvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:51:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E49969D;
        Tue,  5 Apr 2022 00:48:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5FD2B81B18;
        Tue,  5 Apr 2022 07:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F557C36AE2;
        Tue,  5 Apr 2022 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144882;
        bh=YVnSKNnjayLb8hoRVjMbVITJ4lRqKM31ZFX/8E9iugU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=md2ITFAiLVJWka3IUkbTlqcvvhOujqf9sWJWjsRUSSXI1Q47ta/ddcDBWUExnbMoX
         z5idVJ3NdpVXtkGwb+F4moj4m8nnmaPdFt8LoyWnAkogviViojtKj02So41wFjlgNr
         qSsT67nPreFAENODtrgyRFtBI5TfzLugrXP0lHbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0205/1126] crypto: kdf - Select hmac in addition to sha256
Date:   Tue,  5 Apr 2022 09:15:52 +0200
Message-Id: <20220405070413.626250268@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit a88592cc27efd4ed0ceba79016eb4a3ddb90e05e ]

In addition to sha256 we must also enable hmac for the kdf self-test
to work.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 304b4acee2f0 ("crypto: kdf - select SHA-256 required...")
Fixes: 026a733e6659 ("crypto: kdf - add SP800-108 counter key...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 442765219c37..2cca54c59fec 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1847,6 +1847,7 @@ config CRYPTO_JITTERENTROPY
 
 config CRYPTO_KDF800108_CTR
 	tristate
+	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 
 config CRYPTO_USER_API
-- 
2.34.1



