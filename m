Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E5BC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378185AbiDELbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbiDEIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:51:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F7CD3AFB;
        Tue,  5 Apr 2022 01:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 967ECB81BC0;
        Tue,  5 Apr 2022 08:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5405C385A1;
        Tue,  5 Apr 2022 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148019;
        bh=2z/35VQaKfwE4Ga7lWQQm5DUTaQ+l2Wpg+scRG9enwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dczkMtcqYpMp8DWujeXpR56Vjwb8PNhlMAEFFCgycnmprVw3kEgcTpezaTgxa9zBb
         sPje/Knunz5TnxtNc0CAWZJicwjNz1UlrxAN5eEq+F2r4N3oHNmgK9zgYz0Owz9Rtc
         No4irjLCQjWgi56NbKGlOXRrcoSgEN1QIp4PDESI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0205/1017] hwrng: cavium - HW_RANDOM_CAVIUM should depend on ARCH_THUNDER
Date:   Tue,  5 Apr 2022 09:18:38 +0200
Message-Id: <20220405070400.335890696@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit ab7d88549e2f7ae116afd303f32e1950cb790a1d ]

The Cavium ThunderX Random Number Generator is only present on Cavium
ThunderX SoCs, and not available as an independent PCIe endpoint.  Hence
add a dependency on ARCH_THUNDER, to prevent asking the user about this
driver when configuring a kernel without Cavium Thunder SoC  support.

Fixes: cc2f1908c6b8f625 ("hwrng: cavium - Add Cavium HWRNG driver for ThunderX SoC.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 1da64771ee2e..372859b43f89 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -414,7 +414,7 @@ config HW_RANDOM_MESON
 
 config HW_RANDOM_CAVIUM
 	tristate "Cavium ThunderX Random Number Generator support"
-	depends on HW_RANDOM && PCI && ARM64
+	depends on HW_RANDOM && PCI && ARCH_THUNDER
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
-- 
2.34.1



