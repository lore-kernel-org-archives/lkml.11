Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87002C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 12:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbiCGMYJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiCGMXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:23:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E6B63EF;
        Mon,  7 Mar 2022 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646655771; x=1678191771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gzw1D/JK60kkQYznO1thNdtqez4K8mTIcbsKDe1Y0kg=;
  b=C2O1t9hXSs0KmpK9fWyjEek07ju5k1p+/+jmVUA8GRfz2yOM8gVMRfT2
   mt5DpNWus11A0WClu9CfYqYAT/Oy8fgzATBEeVc7I0TZBXmnTs3hhctpG
   RdqlBPhI+jX9eXJSI8igQneoYrEmzkrgfLouKhl/bqVIweKqR13i8WoMJ
   0MQjH0Z2ORouNs05qgsRyKsMlPCejh46EE0Z2+VH4zaFAPsBAKV5Iwv0y
   YcYQPKWZCYCNxWopA63bYRobAsqKxpa+T/i+F7QrpynCYgSzoqKQ1WMEm
   zhlyVwDNMvx5EIhD6w9pOyQfFyRvszpkVpVj5ZuUERawHN6M/rblaxgaZ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155942216"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 05:22:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 05:22:44 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 05:22:42 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v3 1/6] ASoC: dmaengine: do not use a NULL prepare_slave_config() callback
Date:   Mon, 7 Mar 2022 14:21:57 +0200
Message-ID: <20220307122202.2251639-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if struct snd_dmaengine_pcm_config is used, prepare_slave_config()
callback might not be set. Check if this callback is set before using it.

Fixes: fa654e085300 ("ASoC: dmaengine-pcm: Provide default config")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2,v3:
 - none

 sound/soc/soc-generic-dmaengine-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 285441d6aeed..2ab2ddc1294d 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -86,10 +86,10 @@ static int dmaengine_pcm_hw_params(struct snd_soc_component *component,
 
 	memset(&slave_config, 0, sizeof(slave_config));
 
-	if (!pcm->config)
-		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
-	else
+	if (pcm->config && pcm->config->prepare_slave_config)
 		prepare_slave_config = pcm->config->prepare_slave_config;
+	else
+		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
 
 	if (prepare_slave_config) {
 		int ret = prepare_slave_config(substream, params, &slave_config);
-- 
2.32.0

