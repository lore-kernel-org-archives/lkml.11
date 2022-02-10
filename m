Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 10:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbiBJKze (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 05:55:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiBJKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:55:27 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BCBFD3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644490529; x=1676026529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+resf7s8/0bfeptpaysoY6mJLYoPAYzroKommF5fV40=;
  b=PYUKx+f/DhkE96JS6Up5SP5Df7ZIVIBbvngSADtWUzIOvFjDWR+ZjcQE
   I7VEVRUkAyZpDx1O10fvDma7+aI9On0bqC2uI+etw7b08Zp5g1fGP4cJP
   OAPQqrY708lc1S7PTVjD5DtqWPQjfi40FH8zeUCqQwOs+lkCmxHvNjLz7
   9guLiiBKyfj/rOOrvrkS0vKdVRTCQN6m8i4rMaWZq0Trbocr6UNTbO7Is
   uPssj+S8WR5p1aMKPwutzBy4cpfHbRoLtqpfDOYz8zvNy5T5NOejNcVnI
   k7X4D56AO+xzpWA29CbDD+UUiFtGququDst4NsQEEtkkMfhT+Isz+7vQY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310202840"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="310202840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="679106848"
Received: from barabano-mobl.ccr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.41.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:26 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH 2/9] ASoC: SOF: Move the definition of enum sof_dsp_power_states to global header
Date:   Thu, 10 Feb 2022 12:55:12 +0200
Message-Id: <20220210105519.19795-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enum sof_dsp_power_states to include/sound/sof.h
to be accessible outside of the core SOF stack.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/sof.h      | 8 ++++++++
 sound/soc/sof/sof-priv.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 813680ab9aad..7cdfc954df12 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -39,6 +39,14 @@ enum sof_fw_state {
 	SOF_FW_CRASHED,
 };
 
+/* DSP power states */
+enum sof_dsp_power_states {
+	SOF_DSP_PM_D0,
+	SOF_DSP_PM_D1,
+	SOF_DSP_PM_D2,
+	SOF_DSP_PM_D3,
+};
+
 /*
  * SOF Platform data.
  */
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 6358f8c84cce..2e474048d708 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -79,14 +79,6 @@ bool sof_debug_check_flag(int mask);
 /* max number of DSP cores */
 #define SOF_MAX_DSP_NUM_CORES 8
 
-/* DSP power state */
-enum sof_dsp_power_states {
-	SOF_DSP_PM_D0,
-	SOF_DSP_PM_D1,
-	SOF_DSP_PM_D2,
-	SOF_DSP_PM_D3,
-};
-
 struct sof_dsp_power_state {
 	u32 state;
 	u32 substate; /* platform-specific */
-- 
2.35.1

