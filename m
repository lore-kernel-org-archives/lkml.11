Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E88BC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Jul 2022 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiGCVzD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGCVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:55:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797E26C9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+MGiKEfl9xrsgJZ7q400SimQ9kR8E7tJt+7JZCpxN+M=; b=SHfDE5+6mBKPlBCsEOm5QP5yij
        8KU96A8vwOX+IDsEWrs9aJENczKn0RR+ucv0UgGLJuzRETPiRnk97j960pKVDWXup/epaiuhYQ7sc
        lpRtgNCIo0c8+veMEhsKXmjsQbJW2VVFVfK6qURCKgssti0tgSMvYZItSMqiFp7vbMmAM29ep0jby
        7Bm5yyy5R82u59478H5/Zfro9dQkULW/V1um6IBHGR+GCvnusUKMLPuJZWqyAwS2/EMsZWIap6lxX
        X0mdMnIuTGWtBtwX+q5heba1Rwhs658yDib36h3OuX5vfvR7u2AYQi5EvYU3s7QhvfMvhERepib69
        5nTPYdgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o87YH-00GjBn-FN; Sun, 03 Jul 2022 21:54:49 +0000
Date:   Sun, 3 Jul 2022 22:54:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsIQKdYiswzq5kTG@casper.infradead.org>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > This is the number of bits used by a PMD entry, not the order of a PMD.
> 
> No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> This is even more confusing.

Well, what is it then?  The order of something is PAGE_SIZE << n, and
that doesn't seem to be what this is.  Happy to call it whatever you
want to call it.
