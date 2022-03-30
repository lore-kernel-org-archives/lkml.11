Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63678C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 20:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbiC3U65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbiC3U6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791483AA7D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12CA161644
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A4EC340EC;
        Wed, 30 Mar 2022 20:57:06 +0000 (UTC)
Date:   Wed, 30 Mar 2022 16:57:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Crash on x86_32 for: mm: page_alloc: avoid merging
 non-fallbackable pageblocks with others
Message-ID: <20220330165704.730be2b5@gandalf.local.home>
In-Reply-To: <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
References: <20220330154208.71aca532@gandalf.local.home>
        <CAHk-=whz_8tRNGCr09X59nMW3JBzFLE-g-F-brxd+AkK+RceCw@mail.gmail.com>
        <B7789993-75EC-4F74-B4E6-AF1CC2CBD9D4@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 16:29:28 -0400
Zi Yan <ziy@nvidia.com> wrote:

> In the original code, it will jump back to continue_merging and still tries
> to find the buddy. The crash means the found buddy is not valid, since its
> pageblock migratetype is NULL. That seems to suggest the physical memory
> range is not aligned to MAX_ORDER_NR_PAGES, which should not be the case.
> But if (!page_is_buddy(page, buddy, order)) prevents further buddy merging.
> I must be missing something.

Not sure if this matters or not, but my kernel command line has:

  crashkernel=256M

Could that have caused this to break?

-- Steve
