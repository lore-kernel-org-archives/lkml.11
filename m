Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC0C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiGKU01 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGKUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679184D171;
        Mon, 11 Jul 2022 13:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E3D6164D;
        Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949C5C36AE7;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=bR0yhGu5WvC7zefrnQ6yqqocI0KUntnxFR+VGDvW1MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIJyFe6bX+w5HSUPB9kfik8rd9yokK3GhkwVdd4MVvBErWyOZKryj87k6q1jkhz7R
         MvJ4Cy5eL1SbY9xIgj7SFgAMQoCGxkxZg5Uq/hH7Im/3hmYcj+VOsQMsF7Eko3+mKt
         I2lck27qFxFaEmfaIGrJAVDZ3EjPG86t5ip8IE6HaHlUvNyFZOGnSQBM7lQZVs9yAZ
         RyDdSQa+VjGG/SkonLfDgY7I4DiUwY/2WqjRzsNDBCsBrVSWFLS7iCvy88G4TrBed6
         0nyXtn8695SN6G/tqD4VmsgbwC/42/JMS8w2wXXWufxjFTPYgi3uq7qZWBti5txmVj
         Xk+BjRZ8b7ZzQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e9G-UN;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/32] docs: gpu: i915.rst: PM: add more kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:15 +0100
Message-Id: <e00781a424ff91c62b11e2595bfaab5bfd3ae564.1657565224.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657565224.git.mchehab@kernel.org>
References: <cover.1657565224.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both intel_runtime_pm.h and intel_pm.c contains kAPI for
runtime PM. So, add them to the documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 3ee121a0ea62..c32409c03d32 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -25,6 +25,10 @@ Runtime Power Management
 .. kernel-doc:: drivers/gpu/drm/i915/intel_uncore.c
    :internal:
 
+.. kernel-doc:: drivers/gpu/drm/i915/intel_runtime_pm.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_pm.c
+
 Interrupt Handling
 ------------------
 
-- 
2.36.1

