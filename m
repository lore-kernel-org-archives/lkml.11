Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 02:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358964AbiDTCfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358945AbiDTCfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:35:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266932995
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650421986; x=1681957986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NhcIVk7RjAY/MIh/KHzpjrCZoNRYNyCEFEr4+HwwHNI=;
  b=JxKLnr8/BmAtwN1RDUsh53zy1q1dGnojInRKRN3i6tdnjh3/APNFQM/P
   YpFB+NOtB/jroWTZ7x+lB7/sx3Nz4pp7L0GpQYQiCWU+KT6gNKQSaGbJB
   gGmtlxyyFDH9kjTIZ8E9lKvLqoX3syz4mb43YYOaWYM6EXxIqJfVQGGmd
   4SDVQ6wr03rgWbJdOPNsjBKkId/FQSWLLIHT5sCptbRdmL2DAeq4V7sz4
   cB3pqzjSYbhb8bIfqbictIpO54ASCslqFHbhBewbbxw48e7F7hE1/4Rx7
   fTG7sEKB4Iog+JAkz+LSgHftHnryAs0iJkUWyBxCmyNTJBUMlM737MJ2k
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261522464"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="261522464"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:33:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529554582"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 19:33:03 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/3] soundwire: bus: pm_runtime_request_resume on peripheral attachment
Date:   Wed, 20 Apr 2022 10:32:41 +0800
Message-Id: <20220420023241.14335-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
References: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In typical use cases, the peripheral becomes pm_runtime active as a
result of the ALSA/ASoC framework starting up a DAI. The parent/child
hierarchy guarantees that the manager device will be fully resumed
beforehand.

There is however a corner case where the manager device may become
pm_runtime active, but without ALSA/ASoC requesting any functionality
from the peripherals. In this case, the hardware peripheral device
will report as ATTACHED and its initialization routine will be
executed. If this initialization routine initiates any sort of
deferred processing, there is a possibility that the manager could
suspend without the peripheral suspend sequence being invoked: from
the pm_runtime framework perspective, the peripheral is *already*
suspended.

To avoid such disconnects between hardware state and pm_runtime state,
this patch adds an asynchronous pm_request_resume() upon successful
attach/initialization which will result in the proper resume/suspend
sequence to be followed on the peripheral side.

BugLink: https://github.com/thesofproject/linux/issues/3459
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 354d3f89366f..8b7a680f388e 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1838,6 +1838,18 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 				__func__, slave->dev_num);
 
 			complete(&slave->initialization_complete);
+
+			/*
+			 * If the manager became pm_runtime active, the peripherals will be
+			 * restarted and attach, but their pm_runtime status may remain
+			 * suspended. If the 'update_slave_status' callback initiates
+			 * any sort of deferred processing, this processing would not be
+			 * cancelled on pm_runtime suspend.
+			 * To avoid such zombie states, we queue a request to resume.
+			 * This would be a no-op in case the peripheral was being resumed
+			 * by e.g. the ALSA/ASoC framework.
+			 */
+			pm_request_resume(&slave->dev);
 		}
 	}
 
-- 
2.17.1

