Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C6C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 22:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378832AbiFPWFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378792AbiFPWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:04:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDB061632
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655417092; x=1686953092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=96P6uvGDTDGFtAFSYZWWSlbmSlPk/R9jOmty2SHjkCU=;
  b=EPsSF2OxuRc65tG07xK9FAmLB3CTPKNZG/FEbMaHkhMxKojKsd/W0nOK
   SB28GKU9egX9mhfvnMzl5xQaR7tl8WQiWC+aJMiMjIllv8+rW9yurLpRq
   uyThqZDo0KGKYaDsYr1k2Y3sM8SGcV5Zt3s/wQT4YdO6d1VEWG6dhKj3V
   pPqti4toNKz0hOKZ3MoWE3Lb6Dz3Lr8IBxG6Zty8JkkjzrzYy7288e9gs
   ZvkfgxUqcpS1TicJ1z2Ox8xOn8+L5pFWj09HHPJLwV+sn//qQk/udaYss
   QF1cVumrzhNNp04YtCS7Z4l2+ad5LS67FhM3YUrWz8Hs49Ynb9MVuQw0D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276936449"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="276936449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728085035"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.52.70])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:51 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/11] ASoC: tas2552: use pm_runtime_resume_and_get()
Date:   Thu, 16 Jun 2022 17:04:26 -0500
Message-Id: <20220616220427.136036-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of pm_runtime_get_sync() is buggy with no use of put_noidle() on
error.

Use pm_runtime_resume_and_get() instead.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/codecs/tas2552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index c98a9332dcc0e..da744cfae611c 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -581,7 +581,7 @@ static int tas2552_component_probe(struct snd_soc_component *component)
 
 	gpiod_set_value(tas2552->enable_gpio, 1);
 
-	ret = pm_runtime_get_sync(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0) {
 		dev_err(component->dev, "Enabling device failed: %d\n",
 			ret);
-- 
2.34.1

