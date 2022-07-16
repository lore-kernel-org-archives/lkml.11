Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB49C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiGPXGg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jul 2022 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiGPXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:06:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0913D3C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35537B80CBE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 23:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81458C34114;
        Sat, 16 Jul 2022 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658012790;
        bh=Qlry9Ybw/VR9Sy2AXbyuFkQjZf1l5R33jNnOzKlzbsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DE7sthqNzk53rdM+yZTLPvWRxvo+8Z4b1MecZy0fPpQZF0/4onzIQ2w3VsnuH0vYZ
         EubjvaTZCeOidvbnk79KBI9b/ABSTELQnyAQYE34rT3ZU/zE/fXne1x03GnJ6C+twL
         ivNNmSD6lhHnQfAzR9u2sLBXPF4KKe3mqhihJ7nA=
Date:   Sat, 16 Jul 2022 16:06:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-Id: <20220716160629.d065828c84ad2423c10f7733@linux-foundation.org>
In-Reply-To: <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
        <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
        <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 17:59:53 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/7/14 1:23, Andrew Morton wrote:
> > On Tue, 12 Jul 2022 21:05:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > 
> >> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> >> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> >> for them mistakenly because they're not vm_shared. This will corrupt the
> >> page->mapping used by page cache code.
> > 
> > Well that sounds bad.  And theories on why this has gone unnoticed for
> > over a year?  I assume this doesn't have coverage in our selftests?
> 
> As discussed in another thread, when minor fault handling is proposed, only
> VM_SHARED vma is expected to be supported

So...  do we feel that this fix should be backported?  And if so, is
there a suitable commit for the Fixes:?
