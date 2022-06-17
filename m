Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A1C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 07:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380772AbiFQH7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380748AbiFQH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:59:25 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE167D03;
        Fri, 17 Jun 2022 00:59:24 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E81A21A30BC;
        Fri, 17 Jun 2022 09:59:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C0B81A2A06;
        Fri, 17 Jun 2022 09:59:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B1A691820F57;
        Fri, 17 Jun 2022 15:59:20 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] ASoC: dt-bindings: fsl-sai: Add new property to configure dataline
Date:   Fri, 17 Jun 2022 15:44:36 +0800
Message-Id: <1655451877-16382-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,dataline" is added to configure the dataline of SAI.
It has 3 value for each configuration, first one means the type:
I2S(1) or PDM(2), second one is dataline mask for 'rx', third one is
dataline mask for 'tx'. for example:

fsl,dataline = <1 0xff 0xff 2 0xff 0x11>,

it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
rx mask is 0xff, tx mask is 0x11 (dataline 1 and 4 enabled).

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index c71c5861d787..4c66e6a1a533 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -49,6 +49,14 @@ Required properties:
 			  receive data by following their own bit clocks and
 			  frame sync clocks separately.
 
+  - fsl,dataline        : configure the dataline. it has 3 value for each configuration
+                          first one means the type: I2S(1) or PDM(2)
+                          second one is dataline mask for 'rx'
+                          third one is dataline mask for 'tx'.
+                          for example: fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
+                          it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
+                          rx mask is 0xff, tx mask is 0x11 (dataline 1 and 4 enabled).
+
 Optional properties:
 
   - big-endian		: Boolean property, required if all the SAI
-- 
2.17.1

