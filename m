Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B2C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 16:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiHJQPY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiHJQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:15:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A12B02228B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:15:21 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3DC10210CB11;
        Wed, 10 Aug 2022 09:15:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DC10210CB11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660148121;
        bh=eLRZ89FweLs3mKAejSXm82Lf0LVTVfp7vtGx4U+EfJU=;
        h=From:To:Subject:Date:From;
        b=Z9/23526H5J2DCQyiuaAje86oqJurj1QE/YiTbxkOGuSD7cNwlk3UhqpmvctkgX7/
         qEucWvbO9PAysXAjSUrnfDBnF3j49XZw6ArD/5Tn2UnioYsj8fZ86r8/PP3nOPlBCB
         D4itizPTf9F6XUJTMcmLV9crXvKGg0RzU6yRhQiU=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, mikelley@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        tim.c.chen@linux.intel.com, will@kernel.org,
        song.bao.hua@hisilicon.com, suravee.suthikulpanit@amd.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cacheinfo: Don't use cpu_llc_shared_map for !CONFIG_SMP
Date:   Wed, 10 Aug 2022 09:15:15 -0700
Message-Id: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_llc_shared_map is always declared and defined, but populated in
arch/x86/kernel/smpboot.c which only builds for CONFIG_SMP=y. For
UniProcessor builds this mask is never populated and hence invalid.
Current code doesn't handle the case of AMD UniProcessor correctly,
which results "shared_cpu_map" and "shared_cpu_list" files missing from
sysfs entries for l3 cache. This patch fixes this issue.
This code used to work because of a another bug in 'cpumask_next',
where in the CONFIG_SMP=n case the cpumask_next() ignores empty mask
that results as if CPU 0 was set. This bug in 'cpumask_next' was fixed by
following commit, which exposes the cpu_llc_shared_map bug.

b81dce77ced ("cpumask: Fix invalid uniprocessor mask assumption")

Fixes: 2b83809a5e ("x86/cpu/amd: Derive L3 shared_cpu_map from cpu_llc_shared_mask")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 66556833d7af..8753bf33fec4 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -889,10 +889,12 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 	int i, sibling;
 
 	/*
-	 * For L3, always use the pre-calculated cpu_llc_shared_mask
-	 * to derive shared_cpu_map.
+	 * For L3, in case of SMP systems use the pre-calculated
+	 * cpu_llc_shared_mask to derive shared_cpu_map. In case
+	 * of UP simply set the only cpu in mask.
 	 */
 	if (index == 3) {
+#ifdef CONFIG_SMP
 		for_each_cpu(i, cpu_llc_shared_mask(cpu)) {
 			this_cpu_ci = get_cpu_cacheinfo(i);
 			if (!this_cpu_ci->info_list)
@@ -905,6 +907,14 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 						&this_leaf->shared_cpu_map);
 			}
 		}
+#else
+		this_cpu_ci = get_cpu_cacheinfo(cpu);
+		WARN_ON(!this_cpu_ci->info_list);
+		if (!this_cpu_ci->info_list)
+			return 0;
+		this_leaf = this_cpu_ci->info_list + index;
+		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
+#endif
 	} else if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		unsigned int apicid, nshared, first, last;
 
-- 
2.25.1

