Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F014CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 13:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiB1NUX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiB1NUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:20:19 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C5922502;
        Mon, 28 Feb 2022 05:19:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4F6DEDFE24;
        Mon, 28 Feb 2022 05:12:52 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xdcGnh66sa7n; Mon, 28 Feb 2022 05:12:51 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, krzysztof.kozlowski@canonical.com,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, kernel@puri.sm, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 4/5] arm64: dts: imx8mq-librem5: add a RO firmware partition
Date:   Mon, 28 Feb 2022 14:12:21 +0100
Message-Id: <20220228131222.917137-5-martin.kepplinger@puri.sm>
In-Reply-To: <20220228131222.917137-1-martin.kepplinger@puri.sm>
References: <20220228131222.917137-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie <angus@akkea.ca>

This partition will hold a squashfs firmware jail. Only one read-only
partition is needed.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index a0c8191bd33c..587e55aaa57b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -325,15 +325,10 @@ partition@0 {
 		};
 
 		partition@30000 {
-			label = "protected1";
-			reg = <0x30000 0x10000>;
+			label = "firmware";
+			reg = <0x30000 0x1d0000>;
 			read-only;
 		};
-
-		partition@40000 {
-			label = "rw";
-			reg = <0x40000 0x1C0000>;
-		};
 	};
 };
 
-- 
2.30.2

