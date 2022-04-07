Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD3C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbiDGNEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbiDGNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:02:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3D01B9323
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649336439; x=1680872439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lq/fxTcfzik3Gbxv4g6RIwLKGG6lLXnNVzN+4ZV73Q=;
  b=HcrGOBBmO10e60nWEKbeWA80NkGi8CMqDzTTNtJ/yOBAq1VTS2uCyhGB
   JUFHqnUo0l0lCYPruZOJwUSTYLY2++3rkUJ8nYIDjvzllohSsYu2zq/m/
   91YAPsuhhJkSNWlBwAXZwTQzD7WYsc1dSZDv1johkyQOeDcPuG+d161Uk
   7af5ZHgq+HrvUA6lVbA0h069Ip8UhTFE1WMvt+oVxP/yBc7Q3O5HFdeBK
   nOgJYvSLhbxwhrN9FaroJcRjh2PLhTLyjUfiROgKk1N0anADnvmFtZ7cm
   Drwegse14s5XL2ixeAJ9bmtB3R54OEYqN7b/1j7MzFADvroP6he1HIYzi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="286293693"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="286293693"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571041312"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 06:00:33 -0700
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
Subject: [PATCH 18/20] mei: gsc: add transition to PXP mode in resume flow
Date:   Thu,  7 Apr 2022 15:58:37 +0300
Message-Id: <20220407125839.1479249-19-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407125839.1479249-1-alexander.usyskin@intel.com>
References: <20220407125839.1479249-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Added transition to PXP mode in resume flow.

CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/gsc-me.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index fc9419054290..d75fce49e4f7 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -182,11 +182,22 @@ static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
 static int __maybe_unused mei_gsc_pm_resume(struct device *device)
 {
 	struct mei_device *dev = dev_get_drvdata(device);
+	struct auxiliary_device *aux_dev;
+	struct mei_aux_device *adev;
 	int err;
+	struct mei_me_hw *hw;
 
 	if (!dev)
 		return -ENODEV;
 
+	hw = to_me_hw(dev);
+	aux_dev = to_auxiliary_dev(device);
+	adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
+	if (adev->ext_op_mem.start) {
+		mei_gsc_set_ext_op_mem(hw, &adev->ext_op_mem);
+		dev->pxp_mode = MEI_DEV_PXP_INIT;
+	}
+
 	err = mei_restart(dev);
 	if (err)
 		return err;
-- 
2.32.0

