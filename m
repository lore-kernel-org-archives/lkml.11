Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D333EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiCBQhf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiCBQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:37:32 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6ADCEA00
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:36:48 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCGVn7r00QMuSI8V6gqxIK+E2Lf9e3kHr+j6afAS6Vw=;
        b=Pw56LxQwUnnzUUyfCn+zD5iB/Yufs+PrCWRQWBChTqj0u6vbtBk7Wc9jO7UAE4YBh8z0eS
        HfHWdWM4GHiM0xaVGb4TNNniiNsPmCmhkLMtubL6WsogGoHsPqlpRc8dVNQ+Cts8WtGSAZ
        hOte/7TwHHWIjycI/tHU9kP6pOdlcPA=
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
Subject: [PATCH mm 01/22] kasan: drop addr check from describe_object_addr
Date:   Wed,  2 Mar 2022 17:36:21 +0100
Message-Id: <761f8e5a6ee040d665934d916a90afe9f322f745.1646237226.git.andreyknvl@google.com>
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

describe_object_addr() used to be called with NULL addr in the early
days of KASAN. This no longer happens, so drop the check.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index f64352008bb8..607a8c2e4674 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -162,9 +162,6 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 	       " which belongs to the cache %s of size %d\n",
 		object, cache->name, cache->object_size);
 
-	if (!addr)
-		return;
-
 	if (access_addr < object_addr) {
 		rel_type = "to the left";
 		rel_bytes = object_addr - access_addr;
-- 
2.25.1

