Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41D3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 12:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiGSMYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGSMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:23:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714C5459BF;
        Tue, 19 Jul 2022 05:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE12AB81B32;
        Tue, 19 Jul 2022 12:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCB5C341C6;
        Tue, 19 Jul 2022 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658232452;
        bh=BW7QugPo/U4BFCKsncxdj6Z9MSA7mKrewE1Qx/iAFco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5fPvh2uS8E9tT62lpIm7Ewq6blZH5WjXDRgAyc5qJRtA6FTm0Rm7HkHBT1qyhAkm
         HKGFIixnWFgyVrEIhhAHt9tnLoDdiqhMGnLX4LiMq+dsZ3oMXVk3VflcTfQUtJgZQi
         VQ3FMJEl7G3nDPQJtjj/fQuisc313xm/PPMmhJ8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kris Bahnsen <kris@embeddedTS.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 025/112] ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count
Date:   Tue, 19 Jul 2022 13:53:18 +0200
Message-Id: <20220719114628.457068530@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114626.156073229@linuxfoundation.org>
References: <20220719114626.156073229@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kris Bahnsen <kris@embeddedTS.com>

[ Upstream commit e95ea0f687e679fcb0a3a67d0755b81ee7d60db0 ]

Device-tree incorrectly used "ngpio" which caused the driver to
fallback to 32 ngpios.

This platform has 62 GPIO registers.

Fixes: 9ff8e9fccef9 ("ARM: dts: TS-7970: add basic device tree")
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
index e6aa0c33754d..966038ecc5bf 100644
--- a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
@@ -226,7 +226,7 @@ gpio8: gpio@28 {
 		reg = <0x28>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		ngpio = <32>;
+		ngpios = <62>;
 	};
 
 	sgtl5000: codec@a {
-- 
2.35.1



