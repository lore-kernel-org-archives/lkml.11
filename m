Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EF3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 11:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbiEQL1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiEQL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:26:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F231930;
        Tue, 17 May 2022 04:26:55 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2YfR5nbFzGp2r;
        Tue, 17 May 2022 19:23:59 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 19:26:53 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup: Make cgroup_debug static
Date:   Tue, 17 May 2022 19:25:23 +0800
Message-ID: <20220517112523.243386-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make cgroup_debug static since it's only used in cgroup.c

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cgroup-internal.h | 1 -
 kernel/cgroup/cgroup.c          | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 6e36e854b512..5da09c74228d 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -12,7 +12,6 @@
 #define TRACE_CGROUP_PATH_LEN 1024
 extern spinlock_t trace_cgroup_path_lock;
 extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
-extern bool cgroup_debug;
 extern void __init enable_debug_cgroup(void);
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..a97fd051430b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -96,7 +96,7 @@ EXPORT_SYMBOL_GPL(css_set_lock);
 
 DEFINE_SPINLOCK(trace_cgroup_path_lock);
 char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
-bool cgroup_debug __read_mostly;
+static bool cgroup_debug __read_mostly;
 
 /*
  * Protects cgroup_idr and css_idr so that IDs can be released without
-- 
2.17.1

