Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6900EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 07:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiDHH02 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiDHH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:26:25 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219E365037;
        Fri,  8 Apr 2022 00:24:18 -0700 (PDT)
Received: from droid04.amlogic.com (10.18.11.246) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 8 Apr 2022
 15:09:11 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH] arm64: dts: remove cpu compatible "arm,armv8" for s4
Date:   Fri, 8 Apr 2022 15:09:01 +0800
Message-ID: <20220408070901.26446-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.246]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic s4 device is already applied, but cpu compatible 'arm,armv8'
is only valid for software models, so we remove it.

Fixes: ac4dfd0d1d35 ("arm64: dts: add support for S4 based Amlogic AQ222")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index bf9ae1e1016b..480afa2cc61f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -13,28 +13,28 @@ cpus {
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35","arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 		};
 
 		cpu1: cpu@1 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35","arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 		};
 
 		cpu2: cpu@2 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35","arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 		};
 
 		cpu3: cpu@3 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35","arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 		};

base-commit: fd86d85401c2049f652293877c0f7e6e5afc3bbc
-- 
2.30.2

