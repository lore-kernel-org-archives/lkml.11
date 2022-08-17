Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF92C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 07:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiHQHpk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiHQHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:45:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9144979EE2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:30 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M70M06Rz8zXdn9;
        Wed, 17 Aug 2022 15:41:16 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 15:45:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4 -next] fault-injection: skip stacktrace filtering by default
Date:   Wed, 17 Aug 2022 08:03:30 +0000
Message-ID: <20220817080332.1052710-3-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080332.1052710-1-weiyongjun1@huawei.com>
References: <20220817080332.1052710-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If FAULT_INJECTION_STACKTRACE_FILTER is enabled, the depth is default
to 32. This means fail_stacktrace() will iter each entry's stacktrace,
even if filter is not configured.

This patch change to quick return from fail_stacktrace() if stacktrace
filter is not set.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/fault-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 423784d9c058..515fc5aaf032 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -74,7 +74,7 @@ static bool fail_stacktrace(struct fault_attr *attr)
 	int n, nr_entries;
 	bool found = (attr->require_start == 0 && attr->require_end == ULONG_MAX);
 
-	if (depth == 0)
+	if (depth == 0 || (found && !attr->reject_start && !attr->reject_end))
 		return found;
 
 	nr_entries = stack_trace_save(entries, depth, 1);
-- 
2.34.1

