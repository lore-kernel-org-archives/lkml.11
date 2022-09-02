Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677FCC38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 14:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiIBOk0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiIBOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:39:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DFFA6C0F;
        Fri,  2 Sep 2022 07:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E392B82ACB;
        Fri,  2 Sep 2022 12:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE90C4314C;
        Fri,  2 Sep 2022 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662122136;
        bh=K07g13l32rClJcNoxbLcDmonK4zHo/OsvyUnY5GNgG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/8N6ZDJnbbSITTj8U0O8qTSAzu2+CY2PZPNGFx24w9esp6bs3T6ozvn7BEH8kBnS
         5QZx+kck0AFChUHUYElP/HGDCMICFi7jFsLH16WLiRWvaF4fu6FV47KXEcef3kr3ed
         A5H9zopVAK0K4/V1taXytQR91SIlv1g8zeMRjZvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.19 04/72] crypto: lib - remove unneeded selection of XOR_BLOCKS
Date:   Fri,  2 Sep 2022 14:18:40 +0200
Message-Id: <20220902121404.919335468@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902121404.772492078@linuxfoundation.org>
References: <20220902121404.772492078@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 874b301985ef2f89b8b592ad255e03fb6fbfe605 upstream.

CRYPTO_LIB_CHACHA_GENERIC doesn't need to select XOR_BLOCKS.  It perhaps
was thought that it's needed for __crypto_xor, but that's not the case.

Enabling XOR_BLOCKS is problematic because the XOR_BLOCKS code runs a
benchmark when it is initialized.  That causes a boot time regression on
systems that didn't have it enabled before.

Therefore, remove this unnecessary and problematic selection.

Fixes: e56e18985596 ("lib/crypto: add prompts back to crypto libraries")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/crypto/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -33,7 +33,6 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
-	select XOR_BLOCKS
 	help
 	  This symbol can be depended upon by arch implementations of the
 	  ChaCha library interface that require the generic code as a


