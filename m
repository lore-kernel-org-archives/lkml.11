Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D0CC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 02:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbiFJCfv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiFJCft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:35:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FE4F44E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 19:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654828549; x=1686364549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p7WLU+IK69OBzOtjzZZocvi403jXX7hShBwzlKgpaEc=;
  b=Cd5uGfIqALFoTOx43l2iuVYix3QXPN8QG8QlyxtB8BcQQqMxNG0cM53F
   ChosdFK5pq9UQYkVfpqgq1BJVVBwVUHXXzqQFNDWaOq9CelWES2Luj1Lb
   5iBrxSf2GbfDxocOY7giCHPt29hQVwRdnwBgJXqvXcnZtBxmEpodmm3YN
   7+kuy+iJ/k9coS/7tPV1f/1BMN5TQdQXdyzdDUbLuV93ueVKMW2a0bBw1
   vHKYEsvo0op6sK7PpOQCvqsJmwt7p+byC6Jnjv2ZIfNDgKo4izoj6oGV3
   TLgnlKnOnFTYSjDy4jME4aUiJQleZChmAfVT3Aa9Ozkc8TxN43tcm23If
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341555031"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341555031"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:35:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637874939"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:35:45 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: Intel: add trigger callback
Date:   Fri, 10 Jun 2022 10:35:35 +0800
Message-Id: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .trigger callback will be used in ASoC.
Hi Vinod, Could you provied a tag so that Mark can take the tag to
his tree?

Bard Liao (1):
  soundwire: Intel: add trigger callback

Pierre-Louis Bossart (1):
  soundwire: intel: uniquify debug message

 drivers/soundwire/intel.c           | 36 ++++++++++++++++++-----------
 include/linux/soundwire/sdw_intel.h |  1 +
 2 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.17.1

