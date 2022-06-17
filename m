Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1DCCA47C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 07:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380706AbiFQH7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFQH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:59:18 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672315A2D8;
        Fri, 17 Jun 2022 00:59:17 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B77E1201FAA;
        Fri, 17 Jun 2022 09:59:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E2B2201FAC;
        Fri, 17 Jun 2022 09:59:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7FDD61820F45;
        Fri, 17 Jun 2022 15:59:13 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Add PDM/DSD/dataline configuration support
Date:   Fri, 17 Jun 2022 15:44:30 +0800
Message-Id: <1655451877-16382-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support PDM format and DSD format.
Add new dts property to configure dataline. The SAI has multiple
successive FIFO registers, but in some use
case the required dataline/FIFOs are not successive.

Changes in v2:
- refine the commit subject of patch 5/7

Shengjiu Wang (7):
  ASoC: fsl_sai: Add PDM daifmt support
  ASoC: fsl_sai: Add DSD bit format support
  ASoC: fsl_sai: Add support for more sample rates
  ASoc: fsl_sai: Add pinctrl operation for PDM and DSD
  ASoC: fsl_sai: Make res a member of struct fsl_sai
  ASoC: dt-bindings: fsl-sai: Add new property to configure dataline
  ASoC: fsl_sai: Configure dataline/FIFO information from dts property

 .../devicetree/bindings/sound/fsl-sai.txt     |   8 +
 sound/soc/fsl/fsl_sai.c                       | 260 ++++++++++++++++--
 sound/soc/fsl/fsl_sai.h                       |  26 +-
 3 files changed, 272 insertions(+), 22 deletions(-)

-- 
2.17.1

