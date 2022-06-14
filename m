Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A530BC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 02:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351672AbiFNCJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 22:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352420AbiFNCIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C810C35DD1;
        Mon, 13 Jun 2022 19:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A37D60B78;
        Tue, 14 Jun 2022 02:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC72C3411B;
        Tue, 14 Jun 2022 02:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655172371;
        bh=/MVMVifA0yL1pxv5yJnNl8Fq3u5w5hZsm4kWk3zvpio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Khw2TLfyjrgCZX59GbJw6t5w5NqpLzoEG0dOoehtCEEB7fONvzjTTuOfeQoVtGWPQ
         ClaLdlrBFQPc7ljQlA5RXrnmpI/h1etW5IAC5B8HiF2I6PZfnw0pF0OYjmILDFexTZ
         Ri0RubEcipVTv7FF8y40PiYMt1TM+Kv0GDsCl4bA6tBdTjA48zvwCoQbSdoUjnHR8a
         83Svn8h0Kw0kRzSsG1JbueRJ7f+LU3NYOKpZxnvH3DzGMtBJnqX27n8K3c9aTLzTNV
         /nCIzONRaJDxdiGW5BjThmnAZX/OQfBXUsBQIQ+YOTWkTppm/IKVRoJs/5CnZ02+lU
         2wPmrKIHhEkmA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, oded.gabbay@gmail.com,
        christian.koenig@amd.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.17 05/43] drm/amdkfd: Use mmget_not_zero in MMU notifier
Date:   Mon, 13 Jun 2022 22:05:24 -0400
Message-Id: <20220614020602.1098943-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614020602.1098943-1-sashal@kernel.org>
References: <20220614020602.1098943-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit fa582c6f3684ac0098a9d02ddf0ed52a02b37127 ]

MMU notifier callback may pass in mm with mm->mm_users==0 when process
is exiting, use mmget_no_zero to avoid accessing invalid mm in deferred
list work after mm is gone.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ffec25e642e2..ace8f84918b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2281,6 +2281,8 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 
 	if (range->event == MMU_NOTIFY_RELEASE)
 		return true;
+	if (!mmget_not_zero(mni->mm))
+		return true;
 
 	start = mni->interval_tree.start;
 	last = mni->interval_tree.last;
@@ -2307,6 +2309,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 	}
 
 	svm_range_unlock(prange);
+	mmput(mni->mm);
 
 	return true;
 }
-- 
2.35.1

