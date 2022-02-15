Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E864C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 16:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbiBOQlS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:41:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiBOQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:41:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FAFF212D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PcDFt5b9r6iGncybJUkp80gOtRNm+YuPdYaT6WiL4VE=; b=vSsWSska5vRI2Or64pkY00wKxf
        WEy3JiVQNFITbMmotguhLRRUx9qrpXGJxRv9afMSqTRP5WKnZ9Oiyuyb8T/7ARFWhxIYm0rCKOBMI
        ua6+YYDGOIJnsTCPyStQlHauU3GscK7VyKwGWq6qFI2ZAb7dXNuz+rRmsUxhy/I3KmAAuzUON5uVP
        Kwj1kEcYxdEhHTS7u6iJ0mefNijE/SY5/yXZaTuN8Ub18MBvvgZzL1T43HP25+0yCAijVmWrodOtW
        Wbih0AMcw7oqym1cffYKOUiYP8/PIgmAXEU4m7QOUoYNwyIQ2vIQ5LZsCzZb2RNB2KxyxHzIK6daX
        6ZK1+xbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK0sh-00E0D7-Rg; Tue, 15 Feb 2022 16:40:47 +0000
Date:   Tue, 15 Feb 2022 16:40:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/13] mm/munlock: mlock_page() munlock_page() batch
 by pagevec
Message-ID: <YgvXjwapRTOXQOuQ@casper.infradead.org>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
 <1abb94ee-fe72-dba9-3eb0-d1e576d148e6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1abb94ee-fe72-dba9-3eb0-d1e576d148e6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 06:37:29PM -0800, Hugh Dickins wrote:
> +/*
> + * Flags held in the low bits of a struct page pointer on the mlock_pvec.
> + */
> +#define LRU_PAGE 0x1
> +#define NEW_PAGE 0x2
> +#define mlock_lru(page) ((struct page *)((unsigned long)page + LRU_PAGE))
> +#define mlock_new(page) ((struct page *)((unsigned long)page + NEW_PAGE))

You've tripped over one of the weirdnesses in the C preprocessor here.
If the variable passed is not _named_ page, it gets cast to a pointer
to a struct of the same name as the variable.  There's no way to tell
cpp that that 'page' after 'struct' is literal and not to be replaced
by the 'page' argument.

I'm going to change this to:

static inline struct page *mlock_lru(struct page *page)
{
	return (struct page *)((unsigned long)page + LRU_PAGE);
}

(mutatis mutandi for mlock_new)

