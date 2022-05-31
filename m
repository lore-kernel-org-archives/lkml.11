Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 13:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbiEaNFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:05:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9689185EFA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2LaeE6TXNYbEbm2V2tXhLHBQx057Dlx91hkU5xAWauU=; b=NafnL0NLUqNnb1avAu6c+9ng/1
        5oEC8BhrwdbQXoTtFrOmL2MLVaHyLtwHfmXTkELVG++FlFc9sSPWOS6nFx+laQZUh0TgANJJtw66h
        JkhC9DcvgMpuUWe1bAwWV4H6VNDmSqGdiZz4ql25ZaTcVuTWHWUwH3MswFN0D67GWhZ2O0p8pECC/
        apRZsAt+ksza8domwjXUD0pLNPvJUaGxtPj0IxLHWzK7jg2MMCxI4mTH8HqmIToXEya+OHZ+jCZuE
        x1do3ZJd/8GgUeTGrGe/bqnjjdA1aHRata6VB1rQWA6OWWwLg2VnmL8yOSzAgb0+umvGrPh/kHu6/
        p/UuxSNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nw1Yl-005OL0-Eb; Tue, 31 May 2022 13:05:19 +0000
Date:   Tue, 31 May 2022 14:05:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        peterx@redhat.com, apopple@nvidia.com, ying.huang@intel.com,
        osalvador@suse.de, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
Message-ID: <YpYSjw/T8jTGr7e8@casper.infradead.org>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-2-linmiaohe@huawei.com>
 <YpYQ937N8Daad6u/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpYQ937N8Daad6u/@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 01:58:31PM +0100, Matthew Wilcox wrote:
> On Mon, May 30, 2022 at 07:30:13PM +0800, Miaohe Lin wrote:
> > Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
> > extends the period of the rcu_read_lock until after the permissions checks
> > are done to prevent the task pointed to from changing from under us. But
> > the task_struct refcount is also taken at that time, the reference to task
> > is guaranteed to be stable. So it's unnecessary to extend the period of
> > the rcu_read_lock. Release the rcu lock after task refcount is successfully
> > grabbed to reduce the rcu holding time.
> 
> But why bother?  You know the RCU read lock isn't a "real" lock, right?

Looking over this code some more, I think this may harm performance.
ptrace_may_access() itself takes the rcu_read_lock().  So we currently
have:

rcu_read_lock()
rcu_read_lock();
rcu_read_unlock();
rcu_read_unlock();

In at least one RCU configuration, rcu_read_lock() maps to
preempt_disable().  Nested preempt_disable() just bump a counter, while
that counter reaching zero incurs some actual work.  So nested
rcu_read_lock() can be better than sequential lock/unlock/lock/unlock.

This needs far better justification.
