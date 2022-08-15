Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8653C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbiHOScO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243545AbiHOSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E0A32EC2;
        Mon, 15 Aug 2022 11:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDFE60F18;
        Mon, 15 Aug 2022 18:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17830C433B5;
        Mon, 15 Aug 2022 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660587669;
        bh=H9BOwCrBvhJ2D/pmVP5DNxKN0ES8c7NcKffve4+d2QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZcv8hqfgDmaewGrfF2tGih9nVzgPttP15iILozV9yiP6IzFfpasR5x60naWz5Qy0
         KUp+nFgKVxGkLKlmvtvCGMpz3Sz8mlZDwNvVtaQ/BsChUeHmUPb9FpK25MnDKzed79
         o34dyJprl3ZFRw/m8xaDJa0PYdnciEIcn866H+wU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 126/779] ARM: dts: imx6ul: fix keypad compatible
Date:   Mon, 15 Aug 2022 19:56:10 +0200
Message-Id: <20220815180342.675018411@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180337.130757997@linuxfoundation.org>
References: <20220815180337.130757997@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 7d15e0c9a515494af2e3199741cdac7002928a0e ]

According to binding, the compatible shall only contain imx6ul and imx21
compatibles. Fixes the dt_binding_check warning:
keypad@20b8000: compatible: 'oneOf' conditional failed, one must be fixed:
['fsl,imx6ul-kpp', 'fsl,imx6q-kpp', 'fsl,imx21-kpp'] is too long
Additional items are not allowed ('fsl,imx6q-kpp', 'fsl,imx21-kpp' were
unexpected)
Additional items are not allowed ('fsl,imx21-kpp' was unexpected)
'fsl,imx21-kpp' was expected

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 2fcbd9d91521..df8b4ad62418 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -544,7 +544,7 @@ fec2: ethernet@20b4000 {
 			};
 
 			kpp: keypad@20b8000 {
-				compatible = "fsl,imx6ul-kpp", "fsl,imx6q-kpp", "fsl,imx21-kpp";
+				compatible = "fsl,imx6ul-kpp", "fsl,imx21-kpp";
 				reg = <0x020b8000 0x4000>;
 				interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_KPP>;
-- 
2.35.1



