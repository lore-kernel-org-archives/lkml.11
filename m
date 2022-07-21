Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B268C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 02:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiGUCJc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 22:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGUCJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:09:31 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A476E90;
        Wed, 20 Jul 2022 19:09:30 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DE081A32F4;
        Thu, 21 Jul 2022 04:09:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 021E51A32F6;
        Thu, 21 Jul 2022 04:09:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B44BF180222A;
        Thu, 21 Jul 2022 10:09:26 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
Cc:     shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: dsp: fsl: Add SOF compatile string for i.MX8ULP
Date:   Thu, 21 Jul 2022 09:53:43 +0800
Message-Id: <1658368424-28247-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SOF compatile string "fsl,imx8ulp-dsp" for supporting DSP
device on i.MX8ULP platform.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in v2
- add acked-by Rob

 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index e66ef2da7879..9af40da5688e 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -20,6 +20,7 @@ properties:
       - fsl,imx8qxp-dsp
       - fsl,imx8qm-dsp
       - fsl,imx8mp-dsp
+      - fsl,imx8ulp-dsp
       - fsl,imx8qxp-hifi4
       - fsl,imx8qm-hifi4
       - fsl,imx8mp-hifi4
-- 
2.34.1

