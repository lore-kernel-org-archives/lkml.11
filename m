Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37489C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 04:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiFIEBr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiFIEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:01:45 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB021F9C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:01:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VFqMZZr_1654747293;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VFqMZZr_1654747293)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 12:01:39 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm, slab: fix bad alignments
Date:   Thu,  9 Jun 2022 12:01:32 +0800
Message-Id: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by coccicheck:

./mm/slab.c:3253:2-59: code aligned with following code on line 3255.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/slab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 47151fb2b2d2..c359c0f2c897 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3223,7 +3223,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 	}
 	/* ___cache_alloc_node can fall back to other nodes */
 	ptr = ____cache_alloc_node(cachep, flags, nodeid);
-  out:
+out:
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
 	init = slab_want_init_on_alloc(flags, cachep);
@@ -3252,7 +3252,7 @@ __do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
 	if (!objp)
 		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
 
-  out:
+out:
 	return objp;
 }
 #else
-- 
2.20.1.7.g153144c

