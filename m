Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32511C41535
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587549AbiDFAJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353857AbiDEKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:09:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA19C3363;
        Tue,  5 Apr 2022 02:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06757B818F6;
        Tue,  5 Apr 2022 09:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C497C385A2;
        Tue,  5 Apr 2022 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152536;
        bh=v0e+GbbN1cfqPskZ/ICNmADN7c4vz8YjGJCkhl99+Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krdnuWD7CZAhG/LIvPrdlEvv4R0U7KMMgKC8hUc3PAEMoTy+JnDk051U460ywjylL
         7s4Qs/TfnoirvsJtdLRbM/8ABvJLt53LE383Z7JPl2H2swkMBLrDKSNdfG72A34LaN
         jZRjIY2QBEdrS3+csCbhrsLzx3SDAyZPjsML5KWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 5.15 785/913] drm/i915: Fix PSF GV point mask when SAGV is not possible
Date:   Tue,  5 Apr 2022 09:30:47 +0200
Message-Id: <20220405070403.364989962@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 3ef8b5e19ead5a79600ea55f9549658281415893 upstream.

Don't just mask off all the PSF GV points when SAGV gets disabled.
This should in fact cause the Pcode to reject the request since
at least one PSF point must remain enabled at all times.

Cc: stable@vger.kernel.org
Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Fixes: 192fbfb76744 ("drm/i915: Implement PSF GV point support")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220309164948.10671-7-ville.syrjala@linux.intel.com
Reviewed-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
(cherry picked from commit 0fed4ddd18f064d2359b430c6e83ee60dd1f49b1)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_bw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -819,7 +819,8 @@ int intel_bw_atomic_check(struct intel_a
 	 * cause.
 	 */
 	if (!intel_can_enable_sagv(dev_priv, new_bw_state)) {
-		allowed_points = BIT(max_bw_point);
+		allowed_points &= ADLS_PSF_PT_MASK;
+		allowed_points |= BIT(max_bw_point);
 		drm_dbg_kms(&dev_priv->drm, "No SAGV, using single QGV point %d\n",
 			    max_bw_point);
 	}


