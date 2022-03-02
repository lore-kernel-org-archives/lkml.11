Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C855C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 16:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiCBQju (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiCBQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:39:43 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5431369
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:38:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M062mhOVYVf9bJIp01ZOeX3qpFJNVUV/wAEZA8I272E=;
        b=lH9wtAh7UDSWF/e9AczfTV9enN4uq/JJvUnkvS3JD5lO39CTU8KgFlOa8XuaMRO5OBz/Rk
        +Gte5syiG2TrYhFZ5NuL2BGI/f9VgTmWVR+r0hvmFWvNp9TqUusWNQXJrSNdKo9w9VVizH
        pDmUp3Zb0WD+KB7MoptfkaUEEtwc450=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 14/22] kasan: merge __kasan_report into kasan_report
Date:   Wed,  2 Mar 2022 17:36:34 +0100
Message-Id: <c8a125497ef82f7042b3795918dffb81a85a878e.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Merge __kasan_report() into kasan_report(). The code is simple enough
to be readable without the __kasan_report() helper.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 41c7966451e3..56d5ba235542 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -435,37 +435,31 @@ static void print_report(struct kasan_access_info *info)
 	}
 }
 
-static void __kasan_report(void *addr, size_t size, bool is_write,
-				unsigned long ip)
-{
-	struct kasan_access_info info;
-	unsigned long flags;
-
-	start_report(&flags, true);
-
-	info.access_addr = addr;
-	info.first_bad_addr = kasan_find_first_bad_addr(addr, size);
-	info.access_size = size;
-	info.is_write = is_write;
-	info.ip = ip;
-
-	print_report(&info);
-
-	end_report(&flags, addr);
-}
-
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
 			unsigned long ip)
 {
-	unsigned long ua_flags = user_access_save();
 	bool ret = true;
+	void *ptr = (void *)addr;
+	unsigned long ua_flags = user_access_save();
+	unsigned long irq_flags;
+	struct kasan_access_info info;
 
 	if (unlikely(!report_enabled())) {
 		ret = false;
 		goto out;
 	}
 
-	__kasan_report((void *)addr, size, is_write, ip);
+	start_report(&irq_flags, true);
+
+	info.access_addr = ptr;
+	info.first_bad_addr = kasan_find_first_bad_addr(ptr, size);
+	info.access_size = size;
+	info.is_write = is_write;
+	info.ip = ip;
+
+	print_report(&info);
+
+	end_report(&irq_flags, ptr);
 
 out:
 	user_access_restore(ua_flags);
-- 
2.25.1

