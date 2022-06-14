Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52EEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 09:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354185AbiFNJZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356124AbiFNJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:24:40 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A6FF45AF9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:24:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 94B911E80D8F;
        Tue, 14 Jun 2022 17:22:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iIj6q3QRWcQD; Tue, 14 Jun 2022 17:22:43 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 185C01E80D5E;
        Tue, 14 Jun 2022 17:22:43 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        qixu@nfschina.com, hukun@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: [PATCH v2] mm, slab: check the function kmalloc_slab return value
Date:   Tue, 14 Jun 2022 17:23:12 +0800
Message-Id: <20220614092312.14006-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220613102438.27723-1-renyu@nfschina.com>
References: <20220613102438.27723-1-renyu@nfschina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the kmalloc_slab,
it should be better to check it.

Signed-off-by: Ren Yu <renyu@nfschina.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v2:
- change return value of error path to '-ENOMEM'
- not check for zero
---
 mm/slab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index f8cd00f4ba13..eb3fb042f4f4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2064,6 +2064,8 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 	if (OFF_SLAB(cachep)) {
 		cachep->freelist_cache =
 			kmalloc_slab(cachep->freelist_size, 0u);
+		if (!cachep->freelist_cache)
+			return -ENOMEM;
 	}
 
 	err = setup_cpu_cache(cachep, gfp);
-- 
2.11.0

