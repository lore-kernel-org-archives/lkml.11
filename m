Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D4C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 16:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbiCBQim (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbiCBQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:38:38 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CD201AC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:37:54 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6CSCTWOxlFTjCUaDQCg92iZqD/oJAA5cp+h5CudQM0=;
        b=IEetNTQJKp8rSFcLOgVkVj+JLPu8/d9JDYmmx9tBOAw5O8yADVRymYyXX7dCZVZTfdDojh
        t7OQUZtYSynSIzMGT6pcoEY7lpO5HnGdUxrvS6Sc4MVKQ4lko8XLsusJLla0BXr/MKdyAj
        KML1RT69q8S4HTyr7ZbSuaFLKu19EZ0=
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
Subject: [PATCH mm 08/22] kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT
Date:   Wed,  2 Mar 2022 17:36:28 +0100
Message-Id: <223592d38d2a601a160a3b2b3d5a9f9090350e62.1646237226.git.andreyknvl@google.com>
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

Check the more specific CONFIG_KASAN_KUNIT_TEST config option when
defining things related to KUnit-compatible KASAN tests instead of
CONFIG_KUNIT.

Also put the kunit_kasan_status definition next to the definitons of
other KASAN-related structs.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  | 18 ++++++++----------
 mm/kasan/report.c |  2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 4447df0d7343..cc7162a9f304 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -7,16 +7,6 @@
 #include <linux/kfence.h>
 #include <linux/stackdepot.h>
 
-#if IS_ENABLED(CONFIG_KUNIT)
-
-/* Used in KUnit-compatible KASAN tests. */
-struct kunit_kasan_status {
-	bool report_found;
-	bool sync_fault;
-};
-
-#endif
-
 #ifdef CONFIG_KASAN_HW_TAGS
 
 #include <linux/static_key.h>
@@ -224,6 +214,14 @@ struct kasan_free_meta {
 #endif
 };
 
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
+/* Used in KUnit-compatible KASAN tests. */
+struct kunit_kasan_status {
+	bool report_found;
+	bool sync_fault;
+};
+#endif
+
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 						const void *object);
 #ifdef CONFIG_KASAN_GENERIC
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 59db81211b8a..93543157d3e1 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -356,7 +356,7 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
-#if IS_ENABLED(CONFIG_KUNIT)
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 static void update_kunit_status(bool sync)
 {
 	struct kunit *test;
-- 
2.25.1

