Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DD9C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 20:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiCZU1B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiCZU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:26:55 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2E1E3EC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rAl9xafuDgeMtqKjng+jIOA2xEyxA42IxfNsimCsIDI=; b=Vo8tAL4pJcCNKs1Apoo48Qq7TW
        Lz/9bVDEpiBFRcGttZ3lanIvkl5cgvmQufrXvPSV6l/L2TqFB9haMJEfhxYER34H/CdHbedtz7Gp8
        mOPPURwwSE8tEH9g2TKxtXj55c84KjVCx44h9yRPYiPVFfmNGgu1hJ+orKJYAKM8M2YtsB4WT/JsJ
        wtnsFWJ5tzhey+q/delDFtIiacoGnTpOU4yLWBNULSltmoOHTWS4imdsfkLxQqflG4zFjZWDzTirn
        h4Mvs+0Sw/VtA4Ue6rMO3JCStnIzWJ8iQ8Wcbxgd/bEBXDZhucS4tFWqjuGdc8RDmCmL96AHAqEZn
        LVTv+U2A==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nYCyG-0007e9-Sy; Sat, 26 Mar 2022 21:25:13 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: detach fpu operations from dcn10_validate_bandwidth in calcs
Date:   Sat, 26 Mar 2022 19:24:47 -0100
Message-Id: <20220326202448.2046077-2-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326202448.2046077-1-mwen@igalia.com>
References: <20220326202448.2046077-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dcn10_validate_bandwidth is only used on dcn10 files, but is declared in
dcn_calcs files. Rename dcn10_* to dcn_* in calcs, remove DC_FP_* wrapper
inside DML folder and create an specific dcn10_validate_bandwidth in
dcn10_resources that calls dcn_validate_bandwidth and properly wraps that
FPU function with DC_FP_* macro.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  | 14 ++++++++++++++
 .../gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c   |  5 +----
 drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h     |  2 +-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 4048908dd265..1587a060b55a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1141,6 +1141,20 @@ static void dcn10_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
+static bool dcn10_validate_bandwidth(
+		struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate)
+{
+	bool voltage_supported;
+
+	DC_FP_START();
+	voltage_supported = dcn_validate_bandwidth(dc, context, fast_validate);
+	DC_FP_END();
+
+	return voltage_supported;
+}
+
 static enum dc_status dcn10_validate_plane(const struct dc_plane_state *plane_state, struct dc_caps *caps)
 {
 	if (plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index e447c74be713..c25023f7d604 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -764,7 +764,7 @@ static unsigned int get_highest_allowed_voltage_level(uint32_t chip_family,
 	return 4;
 }
 
-bool dcn10_validate_bandwidth(
+bool dcn_validate_bandwidth(
 		struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -790,7 +790,6 @@ bool dcn10_validate_bandwidth(
 		dcn_bw_sync_calcs_and_dml(dc);
 
 	memset(v, 0, sizeof(*v));
-	DC_FP_START();
 
 	v->sr_exit_time = dc->dcn_soc->sr_exit_time;
 	v->sr_enter_plus_exit_time = dc->dcn_soc->sr_enter_plus_exit_time;
@@ -1323,8 +1322,6 @@ bool dcn10_validate_bandwidth(
 	bw_limit = dc->dcn_soc->percent_disp_bw_limit * v->fabric_and_dram_bandwidth_vmax0p9;
 	bw_limit_pass = (v->total_data_read_bandwidth / 1000.0) < bw_limit;
 
-	DC_FP_END();
-
 	PERFORMANCE_TRACE_END();
 	BW_VAL_TRACE_FINISH();
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h b/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
index 337c0161e72d..806f3041db14 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
@@ -619,7 +619,7 @@ struct dcn_ip_params {
 };
 extern const struct dcn_ip_params dcn10_ip_defaults;
 
-bool dcn10_validate_bandwidth(
+bool dcn_validate_bandwidth(
 		struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate);
-- 
2.35.1

