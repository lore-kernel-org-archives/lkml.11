Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36274C35273
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 02:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850164AbiDFCsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 22:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585288AbiDEX7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:59:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E642128DE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2CD3B81FF0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C925FC385A0;
        Tue,  5 Apr 2022 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649196978;
        bh=8LM8oYesOnkFwWaxBlNnPegAUYU1pEClxEtyin3U9X4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xhSnE3/EqIsFBG1SJ9QvyIlXgsBBF10o2ufCqKuVO6VnuoC/MBQk1LXh6QsK+K48u
         ISBzQ3C3lETGXI8Tym4xIRgrj/eIbFLSafSiKWwN4Lr+ddk/Hzp3qy07MVn40I/HyF
         B91NVya62FH+qrHH3H5ePWiv79lbB34m/t4HKDm4=
Date:   Tue, 5 Apr 2022 15:16:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-Id: <20220405151616.bf25fa4aad55536cd031e1ab@linux-foundation.org>
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Apr 2022 21:46:23 -0400 Peter Xu <peterx@redhat.com> wrote:

> This is v8 of the series to add shmem+hugetlbfs support for userfaultfd
> write protection. 

Various compilation catastrophes with x86_64 allnoconfig.  I poked at
the include ordering for a while but other things quickly became more
attractive ;)
