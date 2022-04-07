Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC52C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiDGMEl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiDGMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:04:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808648BF01
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:02:34 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZ0Nr4gB4zdZZX;
        Thu,  7 Apr 2022 20:02:04 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:25 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:32 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>,
        <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>
Subject: [RFC PATCH v3 03/13] tools: bug: Remove duplicate definition
Date:   Thu, 7 Apr 2022 20:01:31 +0800
Message-ID: <20220407120141.43801-4-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407120141.43801-1-chenzhongjin@huawei.com>
References: <20220407120141.43801-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <jthierry@redhat.com>

Under tools, bug.h only defines BUILD_BUG_ON_ZERO() which is already
defined in build_bug.h. This prevents a file to include both headers at
the same time.

Have bug.h include build_bug.h instead.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/linux/bug.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/include/linux/bug.h b/tools/include/linux/bug.h
index 85f80258a15f..548be7cffa8e 100644
--- a/tools/include/linux/bug.h
+++ b/tools/include/linux/bug.h
@@ -2,10 +2,6 @@
 #ifndef _TOOLS_PERF_LINUX_BUG_H
 #define _TOOLS_PERF_LINUX_BUG_H
 
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#include <linux/build_bug.h>
 
 #endif	/* _TOOLS_PERF_LINUX_BUG_H */
-- 
2.17.1

