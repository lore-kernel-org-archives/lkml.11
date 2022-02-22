Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E4CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 18:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiBVS1F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiBVS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:27:02 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4794E0D7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:26:34 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645554393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lb/QQb5DmP2LHrXtHDNMk4U8p312LQBN/82u4kQO66g=;
        b=l7Bx2GUkm3Dq5StqRmciyqB+5cGjfC3M+543snV01fvLP9JXoAN2fRqX4tMOUJ6OxvkRec
        tZ8EDfLFptIHP30shsd5HMLexP/s1MF7F3/neYZyZsZ4OuyQ3K/1o6qF9Sv3BeH8czNEcZ
        9niRTJULEML6baoeydk560SQ4PRbwLU=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH mm v2] another fix for "kasan: improve vmalloc tests"
Date:   Tue, 22 Feb 2022 19:26:28 +0100
Message-Id: <019ac41602e0c4a7dfe96dc8158a95097c2b2ebd.1645554036.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

set_memory_rw/ro() are not exported to be used in modules and thus
cannot be used in KUnit-compatible KASAN tests.

Do the checks that rely on these functions only when the tests are
built-in.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Hide checks under #if instead of dropping.
---
 lib/test_kasan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ef99d81fe8b3..c4b7eb2bad77 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -1083,11 +1083,13 @@ static void vmalloc_helpers_tags(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
 
+#if !IS_MODULE(CONFIG_KASAN_KUNIT_TEST)
 	/* Make sure vmalloc'ed memory permissions can be changed. */
 	rv = set_memory_ro((unsigned long)ptr, 1);
 	KUNIT_ASSERT_GE(test, rv, 0);
 	rv = set_memory_rw((unsigned long)ptr, 1);
 	KUNIT_ASSERT_GE(test, rv, 0);
+#endif
 
 	vfree(ptr);
 }
-- 
2.25.1

