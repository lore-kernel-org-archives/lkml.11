Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDFFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiBVRKs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiBVRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:10:45 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BDD1082
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:10:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645549816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WtAp4AiQx2cFjDZg+kQhLqiCnjHbJYbWSztFNAebJV0=;
        b=xlYQqe087ezV+XM7I/ABgA88EuEsv37JtzM7yYXaZZjF4VPd8bMVFm520holvBULzpTQKZ
        NkeBoBwoNSpuIx9d6QofDAZ8PjTvilEBTK0k0yS3I7O4Xs9LaI7ndLeiGzhLg+ycfDs2lY
        JNPjBQBx5ueUdsUcBU8UNPQhj+h2PUY=
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
Subject: [PATCH mm] another fix for "kasan: improve vmalloc tests"
Date:   Tue, 22 Feb 2022 18:10:14 +0100
Message-Id: <2d44632c4067be35491b58b147a4d1329fdfcf16.1645549750.git.andreyknvl@google.com>
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

Drop the checks that rely on these functions.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ef99d81fe8b3..448194bbc41d 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -1083,12 +1083,6 @@ static void vmalloc_helpers_tags(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
 
-	/* Make sure vmalloc'ed memory permissions can be changed. */
-	rv = set_memory_ro((unsigned long)ptr, 1);
-	KUNIT_ASSERT_GE(test, rv, 0);
-	rv = set_memory_rw((unsigned long)ptr, 1);
-	KUNIT_ASSERT_GE(test, rv, 0);
-
 	vfree(ptr);
 }
 
-- 
2.25.1

