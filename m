Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C56FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 03:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiDBDKj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 23:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348321AbiDBDKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:10:23 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFACBCC4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:08:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V8xeb44_1648868903;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V8xeb44_1648868903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 11:08:24 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        NeilBrown <neilb@suse.de>,
        Vasily Averin <vasily.averin@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sched: avoid unnecessary atomic_read when sync_core_before_usermode() is empty
Date:   Sat,  2 Apr 2022 11:08:22 +0800
Message-Id: <20220402030822.11441-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On archs except x86, CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE is not
defined. We found membarrier_mm_sync_core_before_usermode() looks like
this when compiled by gcc10:

	if (current->mm != mm)
		return;
	atomic_read(&mm->membarrier_state);

This memory access is unnecessary. Remove it to improve performance.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 include/linux/sched/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index a80356e9dc69..3ded68d9f913 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -401,6 +401,7 @@ enum {
 #include <asm/membarrier.h>
 #endif
 
+#ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
 	if (current->mm != mm)
@@ -410,6 +411,11 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 		return;
 	sync_core_before_usermode();
 }
+#else
+static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
+{
+}
+#endif
 
 extern void membarrier_exec_mmap(struct mm_struct *mm);
 
-- 
2.33.0

