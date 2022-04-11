Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B06EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 03:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbiDKDUP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 23:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbiDKDUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:20:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9819036
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zDQnIfuqccyfN2gbdNU5wS381S9cn2QMm9VzwK2eiK0=; b=XIJnU+2REbCnNo37VYNqYr4uMC
        QI+gOWbr9ORxTTOGHy6CyFQyNu7x4zgJACYTDu8xzxBdfR2vcQ9bHAf2L5o0EPTsl4iJOw/KdW3b+
        85Qv/iMHDmSTNCCuhIo0Qos0CgxpA1kdeNlkFzw1zlFspbJHC4grQ0jwRR1BWkBBygYVS7uSUFz8j
        tml0SXnu5HAoby5c9CgkiDnje58za7WD7pJz8dfwjKxfSuWwZrMtIeoHiscowyfvtLRD72tSlXV3m
        WNeeSWw8vz+6F5ssetqIxFzjAQaJftnaDks1997sZ6svd01T9sexygmqLw907Mm/TMynxc9jTxw7z
        hu94XzdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndkYe-00Byas-Co; Mon, 11 Apr 2022 03:17:40 +0000
Date:   Mon, 11 Apr 2022 04:17:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        songmuchun@bytedance.com, hch@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] mm/vmscan: introduce helper function
 reclaim_page_list()
Message-ID: <YlOd1Lvw6ia1vul2@casper.infradead.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-4-linmiaohe@huawei.com>
 <YlGNvn3cu2TftNRN@casper.infradead.org>
 <18ac3908-d162-f1ea-e91f-1da203272b74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18ac3908-d162-f1ea-e91f-1da203272b74@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:53:15AM +0800, Miaohe Lin wrote:
> On 2022/4/9 21:44, Matthew Wilcox wrote:
> > On Sat, Apr 09, 2022 at 05:34:54PM +0800, Miaohe Lin wrote:
> >> +	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
> >> +	while (!list_empty(page_list)) {
> >> +		folio = lru_to_folio(page_list);
> >> +		list_del(&folio->lru);
> >> +		putback_lru_page(&folio->page);
> > 
> > folio_putback_lru()
> 
> I thought folio_putback_lru is deliberately not to use because there is no caller of folio_putback_lru now.
> But it seems I was wrong. Will do it in next version.

Looks like all of the uses of it that I mooted during the last merge
window ended up going away.

https://lore.kernel.org/all/20220204195852.1751729-47-willy@infradead.org/
was obsoleted by commit b109b87050df

https://lore.kernel.org/all/20220204195852.1751729-48-willy@infradead.org/
and
https://lore.kernel.org/all/20220204195852.1751729-50-willy@infradead.org/
were also obsoleted by Hugh's mlock changes

I also sent
https://lore.kernel.org/all/YjJJIrENYb1qFHzl@casper.infradead.org/

but never quite got it up to submittable quality.
