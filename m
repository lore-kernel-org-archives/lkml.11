Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A00FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 02:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358971AbiDTCfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358958AbiDTCfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:35:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF91839A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650421983; x=1681957983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=de3CW2NHaO3Zlt6dACJu87GE5nxvTHKkn6BThHigbYQ=;
  b=T/1lS1+bH68M2wP2G94GaHWPTrMhij04n2dSECHT4fz4q2ANdnuhyZOC
   Sxd7UEbQOf8ygxyzq7nY6eHiOPG1+qTvjraidS8F6rmBW8FR/ckYfecgC
   qOOzyluiz0jd/qDRPSuSYQdJrOyJHK44jSvfQHIKlpz2cVQzy1JMDv2WW
   IdCjNRaLdPdFbk16j/chp6bm0qKqkZ1yHoLpxtQIJ0l5WXyhT5c4fDdZQ
   vavox2nDDpoCN3iOuaXQNzWyheXCIyKvtVXfZafC4pDwi1xriJQOzCsR6
   i0B3kv22LbfO7k5bxJt65M9hsRAqWamw/Pqr66EBbCUyl1SCCyREciZkE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261522446"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="261522446"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:33:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529554573"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:33:00 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/3] soundwire: intel: disable WAKEEN in pm_runtime resume
Date:   Wed, 20 Apr 2022 10:32:40 +0800
Message-Id: <20220420023241.14335-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
References: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When the manager device is pm_runtime resumed, we see a series of
spurious wakes and attempts to resume the same device:

soundwire_intel.link.0: intel_resume_runtime: start
soundwire_intel.link.0: intel_link_power_up: powering up all links
soundwire_intel.link.0: intel_link_power_up: first link up, programming SYNCPRD
soundwire_intel.link.0: intel_shim_wake: WAKEEN disabled for link 0
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume start
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume done
soundwire_intel.link.0: intel_shim_wake: WAKEEN disabled for link 0
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume start
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume done

This sequence does not break anything but is totally unnecessary.

Currently the wakes are only disabled after the peripheral generates a
wake, e.g. for jack detection.

If the resume is initiated by the host drivers as a result of
userspace actions (play/record typically), we need to disable wake
detection as well. Doing so prevents the spurious wakes and calls to
pm_request_resume().

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 32e5fdb823c4..4b458e5e7336 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1831,6 +1831,9 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		return 0;
 	}
 
+	/* unconditionally disable WAKEEN interrupt */
+	intel_shim_wake(sdw, false);
+
 	link_flags = md_flags >> (bus->link_id * 8);
 	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
 
-- 
2.17.1

