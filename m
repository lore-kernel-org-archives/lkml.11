Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F643C19F2A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 21:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiHKVLw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKVLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:11:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D189927F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FD8DB82292
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC547C433D6;
        Thu, 11 Aug 2022 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660252305;
        bh=QDi6d2wdEg67T+HL++ziCYFM/PIMfgMLbZ/GFK3yHx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FQ7zMwPVDo2Lew39mgg4vI8sla0gL151pp3ERG72INZjn4wtOML4/s2MUGmBlBOTy
         RMswgXFRUFw1+vAySqmlnxnsMCs/TjmLK9ui2sRvs627kl5u+/W13D2TOXfb39/ZWW
         bHEznoEuGRmxLKZWh4+yLqlXys8dqQqgerBnnFaM=
Date:   Thu, 11 Aug 2022 14:11:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] mm/uffd: Reset write protection when unregister with
 wp-mode
Message-Id: <20220811141144.6aa509e68c5c7cd8b6c131b6@linux-foundation.org>
In-Reply-To: <20220811201340.39342-1-peterx@redhat.com>
References: <20220811201340.39342-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 16:13:40 -0400 Peter Xu <peterx@redhat.com> wrote:

> I added a Fixes upon introducing of uffd-wp shmem+hugetlbfs because that's
> the only issue reported so far and that's the commit David's reproducer
> will start working (v5.19+).  But the whole idea actually applies to not
> only file memories but also anonymous.  It's just that we don't need to fix
> anonymous prior to v5.19- because there's no known way to exploit.

I added a cc:stable to this.
