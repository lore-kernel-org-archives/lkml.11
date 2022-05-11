Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE14C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 18:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346374AbiEKShs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiEKShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:37:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A64B1F2;
        Wed, 11 May 2022 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BI1saOr2o22TYZFAvLdljrzElw0LGv3iZn79hoIGbjg=; b=ah5Z5rQNhZ9sru+uOjYIakHJc+
        cLY2PYPEMQX5zK5sh1iuPa/YWz7lt/vvJRj7gdUK+pntmccrtePyZB0sbCu75482aO8mhch+n/or/
        CZ2I2UPDYdIMyTaGWQAiQc6fq3gejE97zLCSIEfAZbhuOgyuE2XBgg31a5YJm+8eOkKyq2FPtAY0e
        FQSHiOUtj7JRIhCRQGBTSDc2ipk0KwYcbRZj7mbIxmeid5ccdtnNVP2prkflVuhOHGuoas+pUHSXX
        qi6bmqD7nqmDVvLD2+2ohDoPmmnHFP1TRa3lW3bKPnboDBTQ3hR3OnEL3hjuqoiaHeUakkQQBbWvl
        KiUrzLug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1norDA-005gSg-4q; Wed, 11 May 2022 18:37:24 +0000
Date:   Wed, 11 May 2022 19:37:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [next] sh: hugetlb.h:27:1: error: no return statement in
 function returning non-void [-Werror=return-type]
Message-ID: <YnwCZMldIQiQUrKt@casper.infradead.org>
References: <CA+G9fYtS5fXzbODO3+Rz7VE4VvjY_1c99Da5UhruXi16jcVGbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtS5fXzbODO3+Rz7VE4VvjY_1c99Da5UhruXi16jcVGbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:26:45PM +0530, Naresh Kamboju wrote:
> arch/sh/include/asm/hugetlb.h: In function 'huge_ptep_clear_flush':
> arch/sh/include/asm/hugetlb.h:27:1: error: no return statement in
> function returning non-void [-Werror=return-type]
>    27 | }
>       | ^
> cc1: some warnings being treated as errors

It's easy enough to figure out whose patch this was.

$ git log -p next-20220511 arch/sh/include/asm/hugetlb.h

commit 083af99303b9
Author: Baolin Wang <baolin.wang@linux.alibaba.com>
Date:   Tue May 10 17:47:33 2022 -0700

    mm: change huge_ptep_clear_flush() to return the original pte

You don't have to spray everybody who's ever touched the MM with email.
