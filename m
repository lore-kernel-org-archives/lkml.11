Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC5EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 10:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiCVKTl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiCVKTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:19:40 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67B2459D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:18:11 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 22 Mar
 2022 18:18:09 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 22 Mar
 2022 18:18:09 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <akpm@linux-foundation.org>, <vvs@virtuozzo.com>,
        <shakeelb@google.com>, <brauner@kernel.org>, <mkoutny@suse.com>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] kernel: pid_namespace: use NULL instead of using plain integer as pointer
Date:   Tue, 22 Mar 2022 18:18:08 +0800
Message-ID: <1647944288-2806-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse warnings:
kernel/pid_namespace.c:55:77: warning: Using plain integer as NULL pointer

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 kernel/pid_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a46a372..f4f8cb0 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -52,7 +52,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 	/* Name collision forces to do allocation under mutex. */
 	if (!*pkc)
 		*pkc = kmem_cache_create(name, len, 0,
-					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
+					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, NULL);
 	mutex_unlock(&pid_caches_mutex);
 	/* current can fail, but someone else can succeed. */
 	return READ_ONCE(*pkc);
-- 
2.7.4

