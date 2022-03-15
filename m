Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348595AbiCONOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348563AbiCONOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:14:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBBD21BD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647349975; x=1678885975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bw9X21ncjxkGpypbqQM5Z7Pm+qsQfuMYlU0yKF9tJPE=;
  b=XkF5+SiCKrvMarZvrK8eNIi2aiwmVOEJT/jTwpDiEwBvLHxthNZghIKB
   9jeUDTYPjLuzLtxrXer/D1fzvK26ddc4gMnYpz2w4JoJgJcg1h0Jd0rQm
   6GF0Y9Ss6vxCMD5h9y3SCBO430MLRN4+PcE3msz7j4LbsshS8JCnhYnYv
   oBhRx8Q8ciqafS4249Lb13j5wm4FlL4S+zuCWEw8WtMrDe5cUMSs3JBu7
   3FrNXWYwW02w/uJNbS8UkQ/0avdlLQaKhZdnjCalWYzWIUu/IK+sy3iir
   TJZOBKJAsP7WeyaNmtWlaKj5SBjygsRZrRov2ClrltMwfAMJCY1GH4yF2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253853043"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="253853043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:12:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="556920066"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:12:51 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v11 3/5] mei: gsc: setup char driver alive in spite of firmware handshake failure
Date:   Tue, 15 Mar 2022 15:11:55 +0200
Message-Id: <20220315131157.3972238-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315131157.3972238-1-alexander.usyskin@intel.com>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup char device in spite of firmware handshake failure.
In order to provide host access to the firmware status registers and other
information required for the manufacturing process.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
V5: Rebase
V6: Rebase
V7: add Greg KH Reviewed-by
V8: Rebase
V9: Rebase
V11: Rebase
---
 drivers/misc/mei/gsc-me.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 64b02adf3149..58e39c00f150 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -79,11 +79,12 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 	pm_runtime_set_active(device);
 	pm_runtime_enable(device);
 
-	if (mei_start(dev)) {
-		dev_err(device, "init hw failure.\n");
-		ret = -ENODEV;
-		goto irq_err;
-	}
+	/* Continue to char device setup in spite of firmware handshake failure.
+	 * In order to provide access to the firmware status registers to the user
+	 * space via sysfs.
+	 */
+	if (mei_start(dev))
+		dev_warn(device, "init hw failure.\n");
 
 	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(device);
@@ -97,7 +98,6 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 
 register_err:
 	mei_stop(dev);
-irq_err:
 	devm_free_irq(device, hw->irq, dev);
 
 err:
-- 
2.32.0

