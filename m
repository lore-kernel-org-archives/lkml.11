Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A17C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 03:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbiETDFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 23:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbiETDFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:05:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2BBCB;
        Thu, 19 May 2022 20:05:45 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L4BKt3K7CzCstc;
        Fri, 20 May 2022 11:00:18 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 11:05:15 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 11:05:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <elver@google.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/2] arm64: kcsan: Support detecting more missing memory barriers
Date:   Fri, 20 May 2022 11:15:48 +0800
Message-ID: <20220520031548.175582-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220520031548.175582-1-wangkefeng.wang@huawei.com>
References: <20220520031548.175582-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As "kcsan: Support detecting a subset of missing memory barriers"[1]
introduced KCSAN_STRICT/KCSAN_WEAK_MEMORY which make kcsan detects
more missing memory barrier, but arm64 don't have KCSAN instrumentation
for barriers, so the new selftest test_barrier() and test cases for
memory barrier instrumentation in kcsan_test module will fail, even
panic on selftest.

Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
defined the final instrumented version of these barriers, which will
fix the above issues.

Note, barrier instrumentation that can be disabled via __no_kcsan with
appropriate compiler-support (and not just with objtool help), see
commit bd3d5bd1a0ad ("kcsan: Support WEAK_MEMORY with Clang where no
objtool support exists"), it adds disable_sanitizer_instrumentation to
__no_kcsan attribute which will remove all sanitizer instrumentation fully
(with Clang 14.0). Meanwhile, GCC does the same thing with no_sanitize.

[1] https://lore.kernel.org/linux-mm/20211130114433.2580590-1-elver@google.com/
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/barrier.h | 12 ++++++------
 include/asm-generic/barrier.h    |  4 ++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9f3e2c3d2ca0..2cfc4245d2e2 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -50,13 +50,13 @@
 #define pmr_sync()	do {} while (0)
 #endif
 
-#define mb()		dsb(sy)
-#define rmb()		dsb(ld)
-#define wmb()		dsb(st)
+#define __mb()		dsb(sy)
+#define __rmb()		dsb(ld)
+#define __wmb()		dsb(st)
 
-#define dma_mb()	dmb(osh)
-#define dma_rmb()	dmb(oshld)
-#define dma_wmb()	dmb(oshst)
+#define __dma_mb()	dmb(osh)
+#define __dma_rmb()	dmb(oshld)
+#define __dma_wmb()	dmb(oshst)
 
 #define io_stop_wc()	dgh()
 
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fd7e8fbaeef1..18863c50e9ce 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -38,6 +38,10 @@
 #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
 #endif
 
+#ifdef __dma_mb
+#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
+#endif
+
 #ifdef __dma_rmb
 #define dma_rmb()	do { kcsan_rmb(); __dma_rmb(); } while (0)
 #endif
-- 
2.35.3

