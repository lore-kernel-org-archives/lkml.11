Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A194C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiB1SFk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiB1R7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:59:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66855AECA;
        Mon, 28 Feb 2022 09:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AA57B815C6;
        Mon, 28 Feb 2022 17:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF1BC36AE5;
        Mon, 28 Feb 2022 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646070303;
        bh=eHN+QxCJDsMYcD1W3M1wJxnaC7XsIYiU4h+rIJhtuLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRNxOOFzQZzd1Q+SjiydPqobqF+TMPf2fso0Gns8zGrIeNud3p1sZH9Xk1pTllsLi
         HpUSlMD4tJ6a84OumMoITQvHDBK4ZxV4Z3y30+Fmb8YpB6WR0Up1h8qvcmUbBMMtFU
         1HMX/wJCeIzGhBMFuI/H6BOlSNgceva7i9vDXfaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 5.16 023/164] drm/i915: Widen the QGV point mask
Date:   Mon, 28 Feb 2022 18:23:05 +0100
Message-Id: <20220228172402.189168558@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172359.567256961@linuxfoundation.org>
References: <20220228172359.567256961@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 3f33364836aacc28cd430d22cf22379e3b5ecd77 upstream.

adlp+ adds some extra bits to the QGV point mask. The code attempts
to handle that but forgot to actually make sure we can store those
bits in the bw state. Fix it.

Cc: stable@vger.kernel.org
Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Fixes: 192fbfb76744 ("drm/i915: Implement PSF GV point support")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220214091811.13725-4-ville.syrjala@linux.intel.com
Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
(cherry picked from commit c0299cc9840b3805205173cc77782f317b78ea0e)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_bw.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_bw.h
+++ b/drivers/gpu/drm/i915/display/intel_bw.h
@@ -30,19 +30,19 @@ struct intel_bw_state {
 	 */
 	u8 pipe_sagv_reject;
 
+	/* bitmask of active pipes */
+	u8 active_pipes;
+
 	/*
 	 * Current QGV points mask, which restricts
 	 * some particular SAGV states, not to confuse
 	 * with pipe_sagv_mask.
 	 */
-	u8 qgv_points_mask;
+	u16 qgv_points_mask;
 
 	unsigned int data_rate[I915_MAX_PIPES];
 	u8 num_active_planes[I915_MAX_PIPES];
 
-	/* bitmask of active pipes */
-	u8 active_pipes;
-
 	int min_cdclk;
 };
 


