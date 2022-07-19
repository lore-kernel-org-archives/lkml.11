Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BECC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 00:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiGSAKm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 20:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiGSAKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:10:39 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320EF646C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:10:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sonD4+6h/lo8DkbhcKGrk86DBB0a/jVHQ/3znGtvMfA=;
        b=u99oHTV4VK/O3TDCdr5cCAEgrJ0jSsoO5ddoGvb111Gk6pLjAVWDvqrVzYNb7Wb/JyF6z6
        HAZwpFa7j7U8ObOXHgsxkEZpgJ8X6wiOd0lmPxRowWlTEfUSAiRqIEO+4NVcziy0BwUP3O
        Sw7eRvUMkT3fiiNsPZFOuWOY/PN858I=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v2 01/33] kasan: check KASAN_NO_FREE_META in __kasan_metadata_size
Date:   Tue, 19 Jul 2022 02:09:41 +0200
Message-Id: <e4a075c43dc6793253976780311543fefd82cba3.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

__kasan_metadata_size() calculates the size of the redzone for objects
in a slab cache.

When accounting for presence of kasan_free_meta in the redzone, this
function only compares free_meta_offset with 0. But free_meta_offset could
also be equal to KASAN_NO_FREE_META, which indicates that kasan_free_meta
is not present at all.

Add a comparison with KASAN_NO_FREE_META into __kasan_metadata_size().

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This is a minor fix that only affects slub_debug runs, so it is probably
not worth backporting.
---
 mm/kasan/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 707c3a527fcb..b7351b860abf 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -223,8 +223,9 @@ size_t __kasan_metadata_size(struct kmem_cache *cache)
 		return 0;
 	return (cache->kasan_info.alloc_meta_offset ?
 		sizeof(struct kasan_alloc_meta) : 0) +
-		(cache->kasan_info.free_meta_offset ?
-		sizeof(struct kasan_free_meta) : 0);
+		((cache->kasan_info.free_meta_offset &&
+		  cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
+		 sizeof(struct kasan_free_meta) : 0);
 }
 
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
-- 
2.25.1

