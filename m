Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 14:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbiCPONW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356380AbiCPOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:13:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C266F99
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tJ8jKnnq2oXOf2skIlAI6sEObeCdDa1t+RvJj1Qq/nw=; b=kuzTZXSYLrAgnvQEbI3bH3jaMA
        4wqExcDMLUCVCJJ5tcjy3/aQqnOwSveFurPpT9bJo7r21iISrci7K+Xehr4MVhwBo0ginPmQCGhGw
        LwCrwV28DYES1833szbLoSP76NO53WBamM4MZMP8QG+gJLHqm2iZDLyJ8/EsQbwK68l2/8hxhhtVj
        +7kBLHTkRrJfi5Ig7OHqNfG7zEvGkFKDegjebQKguyAveOXgHXv/RlsBu1Jn4sAcB41J2WqXQSu+s
        jxk1Ictqbgyswq9g9iKeQgd/YRoO9jwfYTlx9BykcRdZAwvsxjbxJ/FsP3xdALL8KxVFvgSDgsAwB
        sN7nSXJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUUND-0062Mi-Rj; Wed, 16 Mar 2022 14:11:35 +0000
Date:   Wed, 16 Mar 2022 14:11:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, sj@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: minor cleanup for damon_pa_young
Message-ID: <YjHwFyc5WfCQAgVh@casper.infradead.org>
References: <20220316081528.6034-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316081528.6034-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:15:28PM +0800, Miaohe Lin wrote:
> if need_lock is true but folio_trylock fails, we should return false
> instead of NULL to match the return value type exactly. No functional
> change intended.

Thanks.  Given the extensive changes I've made to this function for
this merge window, I've added it to my for-next tree.
