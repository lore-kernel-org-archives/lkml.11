Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCF8C25B06
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 18:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344685AbiHISzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343575AbiHISyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:54:52 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF354666
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:25:08 -0700 (PDT)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <riel@shelob.surriel.com>)
        id 1oLTuT-0004fH-Iw;
        Tue, 09 Aug 2022 14:24:57 -0400
Date:   Tue, 9 Aug 2022 14:24:57 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
Message-ID: <20220809142457.4751229f@imladris.surriel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align larger anonymous memory mappings on THP boundaries by
going through thp_get_unmapped_area if THPs are enabled for
the current process.

With this patch, larger anonymous mappings are now THP aligned.
When a malloc library allocates a 2MB or larger arena, that
arena can now be mapped with THPs right from the start, which
can result in better TLB hit rates and execution time.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
v2: avoid the chicken & egg issue with MMF_VM_HUGEPAGE (Yang Shi)

 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index c035020d0c89..1d859893436d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2229,6 +2229,9 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		 */
 		pgoff = 0;
 		get_area = shmem_get_unmapped_area;
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		/* Ensures that larger anonymous mappings are THP aligned. */
+		get_area = thp_get_unmapped_area;
 	}
 
 	addr = get_area(file, addr, len, pgoff, flags);
-- 
2.37.1


