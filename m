Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63422CCA480
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 12:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiGNMHP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 08:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiGNMGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460D5C9F4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 494D261E4E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94854C385A2;
        Thu, 14 Jul 2022 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657800390;
        bh=KmwQhAp2pgXmoeQjAEhRrYG+yeaU1ynMiyTTT8lqOhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rc0bejjRde75fUievF3i6KeoII+rq2IK8JueQLGuNSxmIWSj+ThTQWnffYbAHqcqE
         vqkmFtG8W24I1igZpuIN5Y9AB2h8XLwsYKcOPsdalvL4AiaEfJq+Twkqd5XLVlNWWK
         doamjH9ox9xcY71PnKPJ5xPJ8KA/esWJhrScKIV6GGp3/6HotYqBOSZcfu0nVK2a/J
         egRjnwDZ1rdPwR8hSnhRRJpyqVAq3SbriNk8h1A8/T7jlGTB1S0LAMS6PC4w6PnffZ
         7Nz5kx6mtm6jssRxW+VeqSg/1CYLZZ4h8tcL59o+leNZD9AeRRpCFLAzhxW5fDq8v7
         akKnuE5XzybKw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBxbw-0059tB-3C;
        Thu, 14 Jul 2022 13:06:28 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/21] drm/i915: document tlb field at struct drm_i915_gem_object
Date:   Thu, 14 Jul 2022 13:06:19 +0100
Message-Id: <2a90d7f13b6895ed06fffd5e58628d611b3d447e.1657800199.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657800199.git.mchehab@kernel.org>
References: <cover.1657800199.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to the TLB field inside
struct drm_i915_gem_object.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/21] at: https://lore.kernel.org/all/cover.1657800199.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_object_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index 3c1d0b750a67..6f5b9e34a4d7 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -618,6 +618,7 @@ struct drm_i915_gem_object {
 		 */
 		bool dirty:1;
 
+		/** @mm.tlb: array with TLB invalidate IDs */
 		u32 tlb[I915_MAX_GT];
 	} mm;
 
-- 
2.36.1

