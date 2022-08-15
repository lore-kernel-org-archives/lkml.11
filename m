Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6C2C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 22:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352014AbiHOWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352098AbiHOWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:50:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185B137298;
        Mon, 15 Aug 2022 12:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5D7B61178;
        Mon, 15 Aug 2022 19:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938ABC433C1;
        Mon, 15 Aug 2022 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660593237;
        bh=VYfBlipzcVbhm4a67MWNtWYnwO8/NK7weJw/0ZKExAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZPz4bNHcDrQEP5G9Nz70TdU5X+0dsPnMfLB1JfhjbZs/2QVzrCRSbMG1D6xEi+1s
         VKsKBYOcGYJegchTy23/blHI5v2Z1TEMO8scVM4iAxpXmGLHvfLdRJ4ic2EKAiO//I
         IT8E/egsyOmNI+eYOT4vnOjPfdC/+LBPC2ZPo/lY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 0212/1157] Revert "ARM: dts: imx6qdl-apalis: Avoid underscore in node name"
Date:   Mon, 15 Aug 2022 19:52:48 +0200
Message-Id: <20220815180448.097208042@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

[ Upstream commit 9c0919acb3fa7c1a24e384ff912f2d88f060c373 ]

The STMPE MFD device binding requires the child node to have a fixed
name, i.e. with '_', not '-'. Otherwise the stmpe_adc, stmpe_touchscreen
drivers will not be probed.

Fixes: 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index bd763bae596b..da919d0544a8 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -315,7 +315,7 @@ stmpe811@41 {
 		/* ADC conversion time: 80 clocks */
 		st,sample-time = <4>;
 
-		stmpe_touchscreen: stmpe-touchscreen {
+		stmpe_touchscreen: stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
@@ -332,7 +332,7 @@ stmpe_touchscreen: stmpe-touchscreen {
 			st,touch-det-delay = <5>;
 		};
 
-		stmpe_adc: stmpe-adc {
+		stmpe_adc: stmpe_adc {
 			compatible = "st,stmpe-adc";
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
-- 
2.35.1



