Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F8C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 11:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiF2L3t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 07:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiF2L3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:29:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55433C4B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502180; x=1688038180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJ7/0NMQ+bhhK7LrA8d3+wDuEzwTVfD+Czxxn93mcY0=;
  b=gMA/xVPGoRyHG0GhH1UiTAC9v3obhnlaLMNNAh3v/8WM0ltTQGTP2mDn
   DF4t+sIKM3PZ2T5Jzrt+mERckD2z65/BcfqdDtUvuvk80jJ8Zskq868H0
   JojuMONs9yEZfCDTywpegqSDiM53ViONherZolYSiI4RccxHSCXJhVHyw
   OWmZbVwzd1X79IOqCbv01ZzFYjzNhr6YGkoayoIrG4LeFK8fuYeTLqeIS
   Q2QRcprvM5Jv3LCiQOSSGmnRphNVZh8A62wXMj3JyOJv/LYVeKX1TlXq0
   2dvAzI0Np821VQzghZRk6DpGyutWy/w4wCFVpeJtFRxE47CGuT+gQZXiZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368319236"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="368319236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:29:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647353073"
Received: from sannilnx.jer.intel.com ([10.12.26.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:29:37 -0700
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
Subject: [PATCH v4 04/14] drm/i915/gsc: add slow_fw flag to the gsc device definition
Date:   Wed, 29 Jun 2022 14:29:03 +0300
Message-Id: <20220629112913.1210933-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629112913.1210933-1-alexander.usyskin@intel.com>
References: <20220629112913.1210933-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slow_fw flag to the gsc device definition
and pass it to mei auxiliary device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index e0236ff1d072..f963c220bbff 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -41,6 +41,7 @@ struct gsc_def {
 	unsigned long bar;
 	size_t bar_size;
 	bool use_polling;
+	bool slow_fw;
 };
 
 /* gsc resources and definitions (HECI1 and HECI2) */
@@ -145,6 +146,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
 	adev->bar.end = adev->bar.start + def->bar_size - 1;
 	adev->bar.flags = IORESOURCE_MEM;
 	adev->bar.desc = IORES_DESC_NONE;
+	adev->slow_fw = def->slow_fw;
 
 	aux_dev = &adev->aux_dev;
 	aux_dev->name = def->name;
-- 
2.34.1

