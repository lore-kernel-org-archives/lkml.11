Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6381CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 20:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiGKUZx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiGKUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46E3C8C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80904B81201
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158BEC341C8;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=tkUHbDINZrB0LRuB/0As+bBah7qgv1F4QlCF0lnzznE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTaMqZwKwqcX1M2IOeieAncdbq7kSg1GjA1X84MJt7BXrblKHd40AM+itVbtD0f7r
         mBvEKOa3Z+QLB7orbFKGXVjzqzZW1suVxGcnTz6n0G3DpcRfQBo9RwVNmDqKn3s71c
         uU5vjORZU9psQNKRtImYJ3PZBN+dc98PIMJ/sv1gP9zQcKadrP6e8cMINYxV4NiV/V
         KmsnWZ05XMVRmXFD/Q9+Gsu3asgrnez6UlGVz3Koh4vfO58SAQ+VZNbAGcmEsA4SlV
         wdMdAwG809NQYuiIIIpBt4OgckKd3av0uM8qH6XL9nOIgGSOTovWVIIQlB4/XIOO71
         dAdhQJcVeqaAQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e7v-GQ;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/32] drm/i915: i915_gpu_error.c: document dump_flags
Date:   Mon, 11 Jul 2022 21:24:55 +0100
Message-Id: <2e4749facda5c1761b9b5d6956d9eb937ea05573.1657565224.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657565224.git.mchehab@kernel.org>
References: <cover.1657565224.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc dump_flags parameter is missing at i915_capture_error_state().
Document it.

Fixes: a6f0f9cf330a ("drm/i915/guc: Plumb GuC-capture into gpu_coredump")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_gpu_error.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 32e92651ef7c..faec4aebbc3d 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -2096,7 +2096,8 @@ void i915_error_state_store(struct i915_gpu_coredump *error)
  * i915_capture_error_state - capture an error record for later analysis
  * @gt: intel_gt which originated the hang
  * @engine_mask: hung engines
- *
+ * @dump_flags: bitmap flags. When %CORE_DUMP_FLAG_IS_GUC_CAPTURE is used,
+ * 	dump engine record registers and execlists.
  *
  * Should be called when an error is detected (either a hang or an error
  * interrupt) to capture error state from the time of the error.  Fills
-- 
2.36.1

