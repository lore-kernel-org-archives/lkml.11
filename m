Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4252C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 17:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbiDGRM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiDGRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:12:31 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA41E9637
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:10:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649351427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RKada/syRdNLHr4WO/ASA7jzsH+BuRSFKa7ozmTSlP8=;
        b=Z4SrfJi1IGw71HQV0HTQYn56ug6Z0kofWnjvTZo2iPvxqU64LoNhJVplJ5jFu+qEAbkYmk
        N3DtZ2QlQGuJZ2Suddbcc68RzATXbn5Kvs9psFJWBnnTmlr0P5HMnFK7ffrD0YvmCS7AqZ
        6RgTwrxuq3IFOaz3KM8s/pAoHSHFs6M=
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
Subject: [PATCH] kasan: mark KASAN_VMALLOC flags as kasan_vmalloc_flags_t
Date:   Thu,  7 Apr 2022 19:08:37 +0200
Message-Id: <52d8fccdd3a48d4bdfd0ff522553bac2a13f1579.1649351254.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Fix sparse warning:

mm/kasan/shadow.c:496:15: warning: restricted kasan_vmalloc_flags_t degrades to integer

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index ceebcb9de7bf..b092277bf48d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -23,10 +23,10 @@ struct task_struct;
 
 typedef unsigned int __bitwise kasan_vmalloc_flags_t;
 
-#define KASAN_VMALLOC_NONE		0x00u
-#define KASAN_VMALLOC_INIT		0x01u
-#define KASAN_VMALLOC_VM_ALLOC		0x02u
-#define KASAN_VMALLOC_PROT_NORMAL	0x04u
+#define KASAN_VMALLOC_NONE		((__force kasan_vmalloc_flags_t)0x00u)
+#define KASAN_VMALLOC_INIT		((__force kasan_vmalloc_flags_t)0x01u)
+#define KASAN_VMALLOC_VM_ALLOC		((__force kasan_vmalloc_flags_t)0x02u)
+#define KASAN_VMALLOC_PROT_NORMAL	((__force kasan_vmalloc_flags_t)0x04u)
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
-- 
2.25.1

