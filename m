Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46B7C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbiHLSML (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiHLSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:12:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2DB2D8A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1kuZ1tf0B+TroFFOYxJQmWrPK3ACtUqm+sxQLEDf+/I=; b=eqfyJVBz1jub5Cndm+Sjr3uGO/
        cI0jFJnGAwfur5rzLm8yfpIHG2eTGIgVEdV64OdKHt4InPL+ZD1kjFOj/WympEQWxHr8aEKx9DeSw
        sp5P5hKjo0jfFl8Jv1Ixb4drW/ktYtx9HYfyERk1fufyNJrabzSDWY8rG4bbAv8aZ9Lzs18ZQ+mvf
        1KxAvyAkmEbx2CZhjad1/PnkFMCCzDAjTcreHBkWJaY4qKG1RZyeWBXK4l1e1nImvMumBt9Tv1cQA
        pVyZhbw7rm9/BPjsXwtYOtqGOuDb8Bg3pEn/92BSV0GQQQoIb5tCj/q10rU5iYt48f8k88zcoWNBJ
        HU4RcoMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMZ8T-002TUW-Iz; Fri, 12 Aug 2022 18:11:53 +0000
Date:   Fri, 12 Aug 2022 19:11:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Message-ID: <YvaX6emidD6ddjmb@casper.infradead.org>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <YvZOSUrXoeYnuCyg@casper.infradead.org>
 <51d4408b-14f5-f6a8-80cf-d23cdb0a7c69@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d4408b-14f5-f6a8-80cf-d23cdb0a7c69@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 11:02:42AM -0700, John Hubbard wrote:
> On 8/12/22 05:57, Matthew Wilcox wrote:
> > On Fri, Aug 12, 2022 at 12:13:08PM +1000, Alistair Popple wrote:
> > > +			get_page(&folio->page);
> > > +			unpin_user_page(&folio->page);
> > 
> > https://lore.kernel.org/linux-mm/YvJddHPZsh7Lwzps@casper.infradead.org/
> 
> The above fix shows up in patch 2/2. I noticed during review that
> it was applied to a different patch than the one you replied to,
> but figured it didn't matter which patch picked up this fix, since
> the problem precedes either patch.

Oh!  I didn't realise patch 2/2 changed the same lines.  let me go
and read 2/2.
