Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D09FC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 08:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiFXIEE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiFXIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:03:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88FE6DB00
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656057829; x=1687593829;
  h=from:to:cc:subject:date:message-id;
  bh=0hT/ssdR7iFYpnxu1iuIJWWRJQTQkWcXgBa84EnUVKg=;
  b=jASmZlupMfM5FKmY0zCjsMppT7kr3y70Sz7w9sLLOO9ZE3OfM9KvHqsV
   0UXUXKnEFslBMc78XvttvK1g3XZlYApbXTOh1IMnh97PTPbOa8UjVJsBq
   fBb59/ZpIWOBzKhOU/7Q4ALt1iKB1kr6msyQF4Rmj/AftRbLnP16NT4MS
   ZTmzObODIYPEt/VHCJmvWPPhjh6D8FviKAFgTiJR9gyqnXHbxR8btkPGn
   FZjfWjP2h8EN7SAs6HKLXhD1Yhi4VPdMeIy35IjYgx/Olo/mPpH/A2ZcP
   pMCocEApLFxWmJHy47dy1CZjZyro2IaD0S+uHgDiAAdCPq2Tz3gOERvqB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306415877"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="306415877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 01:03:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="621643169"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 01:03:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v3 0/2] ASoC/SoundWire: Intel: add sdw BE dai trigger
Date:   Fri, 24 Jun 2022 16:03:24 +0800
Message-Id: <20220624080326.29139-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SOF IPC4, we need to set pipeline state in BE DAI trigger.
@Vinod, Could you ack if the soundwire patch looks good to you?
And we can go through the ASoC tree since the change is mainly on ASoC.

v2:
 - Change "#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)" to
   "if (IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE))"

v3:
 - Change the multi-line comment style in "soundwire: Intel: add trigger
   callback" patch and take Vinod's Ack.

Bard Liao (2):
  soundwire: Intel: add trigger callback
  ASoC: SOF: Intel: add trigger callback into sdw_callback

 drivers/soundwire/intel.c           |  9 +++++++++
 include/linux/soundwire/sdw_intel.h |  1 +
 sound/soc/sof/intel/hda-dai.c       | 14 +++++++++++---
 sound/soc/sof/intel/hda.c           |  2 +-
 sound/soc/sof/intel/hda.h           |  1 +
 5 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.17.1

