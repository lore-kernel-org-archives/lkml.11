Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4163EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842009AbiDFB0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354085AbiDEKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A374CD4B;
        Tue,  5 Apr 2022 02:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A20C616E7;
        Tue,  5 Apr 2022 09:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A318C385A1;
        Tue,  5 Apr 2022 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152627;
        bh=WEzZA7KphCwxsPg16crtXDZyTJfB5qhlsaeZdSfVPQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIIiU1yRaONXvbLdOX2AqMMjjBqmygcXC9mRIsEycejPEEnjztoz5XAkDgOu7mkwG
         mFQ7RU18/UgnbfEaUGhBuxhgtXv8/0BbkhyCXblxG+QPJSmGsFdInV5bI6jBw5e3ez
         wWDc0oxabKuMx1fLkdb11BJ63RzQqPYv44HkwCLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.15 845/913] crypto: arm/aes-neonbs-cbc - Select generic cbc and aes
Date:   Tue,  5 Apr 2022 09:31:47 +0200
Message-Id: <20220405070405.157449708@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit c8bd296cca3434b13b28b074eaeb78a23284de77 upstream.

The algorithm __cbc-aes-neonbs requires a fallback so we need
to select the config options for them or otherwise it will fail
to register on boot-up.

Fixes: 00b99ad2bac2 ("crypto: arm/aes-neonbs - Use generic cbc...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/crypto/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -102,6 +102,8 @@ config CRYPTO_AES_ARM_BS
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
+	select CRYPTO_AES
+	select CRYPTO_CBC
 	select CRYPTO_SIMD
 	help
 	  Use a faster and more secure NEON based implementation of AES in CBC,


