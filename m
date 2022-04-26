Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D09C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 23:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356269AbiDZX7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356258AbiDZX7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:59:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD134924D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651017400; x=1682553400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6orb7xMJrGLhUt7lGhLbHJI6NNpt/GIKG7ukF/7V64=;
  b=dzbBfBPvl73DJ17Wb+QITy5Mc35KL2GGdSvR7hGz/aNi0QExNwPRXeXo
   4IIxdsOpJrJzkG8n9urtNjWcTky+jggtEGR1qW0DHsxrLV4aowKMBkQt/
   uijbBwyGq+uGWBpF4uXkEp7JveqYYvIY8T7Q5/eUmk9VW22T9bkvoR5+5
   LDPnIdYTUUFwT2ro9moox8qpB6zbaeYp6IVSkqILyPbK02c+kG+r9Syxs
   AJNe+shWxTJlB5ERCGAHTbI6nIsYGSufoW5K3QQknF0HAz5deh/OjpL3+
   8Li3WRSuMi+UYExuJk5LJIhl/YXk6zpP8OWcpqiU5REu1eY2ja4pJU+6/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245682884"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245682884"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730515044"
Received: from htamura-mobl2.gar.corp.intel.com (HELO bard-pc.domain.name) ([10.252.185.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:56:38 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/5] soundwire: intel: use pm_runtime_resume_and_get()
Date:   Wed, 27 Apr 2022 07:56:22 +0800
Message-Id: <20220426235623.4253-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
References: <20220426235623.4253-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use pm_runtime_resume_and_get() to replace the pm_runtime_get_sync() and
pm_runtime_put_noidle() pattern.

No functional changes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 63101f1ba271..ad41b50f2ef1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -799,12 +799,11 @@ static int intel_startup(struct snd_pcm_substream *substream,
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
-	ret = pm_runtime_get_sync(cdns->dev);
+	ret = pm_runtime_resume_and_get(cdns->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(cdns->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(cdns->dev);
 		return ret;
 	}
 	return 0;
-- 
2.25.1

