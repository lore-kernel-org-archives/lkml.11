Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 15:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiBQPYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:24:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242411AbiBQPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:23:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0302B0B0D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645111418; x=1676647418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=htybxP09qQASUqb89JmT/mp1fs3sQZxp+DoGbzh6xfU=;
  b=mpREKCaUTXPhwffe7cBwe9zjU76kqcosq0jwwZ0/1L/L5deMTjsLqwh0
   B5fjCn3veXS4JbKISF1hd6sZwLxmCqgZPpjVrM500teBIJymTDW7PqZdn
   i2I4miQuUozTjC4+eIZwGZPmXbXZFrBB2t5GlEI19MCDRAOGQvU6YAaxc
   OW/r8/Hta84BnjqgFf02sqUVigyu400lwwHfv6XkuNhgCOViN3Ogj5mfy
   pK2F0x29NHLEATUAwNf1Vv4OG+r2vTZd6KzKj5E/4hyHS9b30NBuzxQJs
   qr/B6+mMaKuAqXkZxniBBqVxnbTE1yC5kMh1TsCX172FH9kCdiUdnGCEU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="238300071"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238300071"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:23:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="545659051"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:23:34 -0800
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
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/5] mei: gsc: setup char driver alive in spite of firmware handshake failure
Date:   Thu, 17 Feb 2022 17:22:46 +0200
Message-Id: <20220217152248.1016134-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220217152248.1016134-1-alexander.usyskin@intel.com>
References: <20220217152248.1016134-1-alexander.usyskin@intel.com>
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
---
V5: Rebase
V6: Rebase
V7: add Greg KH Reviewed-by
V8: Rebase
V9: Rebase
---
 drivers/misc/mei/gsc-me.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 0afae70e0609..cf427f6fdec9 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -79,11 +79,12 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 	pm_runtime_set_active(device);
 	pm_runtime_enable(device);
 
-	if (mei_start(dev)) {
-		dev_err(device, "init hw failure.\n");
-		ret = -ENODEV;
-		goto err;
-	}
+	/* Continue to char device setup in spite of firmware handshake failure.
+	 * In order to provide access to the firmware status registers to the user
+	 * space via sysfs.
+	 */
+	if (mei_start(dev))
+		dev_warn(device, "init hw failure.\n");
 
 	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(device);
-- 
2.32.0

