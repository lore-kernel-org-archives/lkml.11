Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA82CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 08:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiF0I7A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiF0I65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:58:57 -0400
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7886252
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:58:50 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 5D3541C4329
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:58:48 +0100 (IST)
Received: (qmail 23735 invoked from network); 27 Jun 2022 08:58:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Jun 2022 08:58:48 -0000
Date:   Mon, 27 Jun 2022 09:46:45 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [PATCH] mm/page_alloc: Replace local_lock with normal spinlock -fix
Message-ID: <20220627084645.GA27531@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
 <20220624125423.6126-8-mgorman@techsingularity.net>
 <CAOUHufba2KQLbFMoHusTpvEBHS_EWQ1NnOfm3Wczmykk0A1pTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOUHufba2KQLbFMoHusTpvEBHS_EWQ1NnOfm3Wczmykk0A1pTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Yu Zhao, use pcp_spin_trylock_irqsave instead of
pcpu_spin_trylock_irqsave. This is a fix to the mm-unstable patch
mm-page_alloc-replace-local_lock-with-normal-spinlock.patch

Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 71065b01827b..934d1b5a5449 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3493,7 +3493,7 @@ void free_unref_page(struct page *page, unsigned int order)
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
 	if (pcp) {
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
 		pcp_spin_unlock_irqrestore(pcp, flags);
