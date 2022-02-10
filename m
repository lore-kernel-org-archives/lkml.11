Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA3AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 07:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiBJHtx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 02:49:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiBJHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:49:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C95103D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:49:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 45DF71F382;
        Thu, 10 Feb 2022 07:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644479390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EDHtHvuI0rX56upto/aTnkApaVCYeNt0NfBKbGzA2cw=;
        b=eoyRrh0VWU/qJAoLWCl9fgGdtYB1r6YQ73vYM6K7VJQdi8D3ZgJQpKti2VXmaxHz6O82Tl
        Mrz4lRsft7pzJHNn0OGo6csM5urkGCFprE9QJvBKirma9L6Jy5uie/5LuxR76/dvRk1x12
        mVW46fCjSh7pKbD39YAlgCoLAMHPJ1E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 38A70A3B8A;
        Thu, 10 Feb 2022 07:49:49 +0000 (UTC)
Date:   Thu, 10 Feb 2022 08:49:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/13] mm/munlock: rework of mlock+munlock page handling
Message-ID: <YgTDnd9MihFS4cjD@dhcp22.suse.cz>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
 <YgPfX+/f0ksBpx6G@dhcp22.suse.cz>
 <147388c6-eb7-5c58-79a-7a8279c27fd@google.com>
 <YgQrpMpYiGZXqdbp@dhcp22.suse.cz>
 <a650e078-25cb-14f8-4880-e575c937847@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a650e078-25cb-14f8-4880-e575c937847@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-02-22 14:59:19, Hugh Dickins wrote:
[...]
> Ah, but you're worrying about any previously-mapped pages when
> VM_LOCKONFAULT is established: those ones get done by mlock_pte_range()
> in 07/13, same as when VM_LOCKED is established - I checked again,
> VM_LOCKONFAULT is not set without VM_LOCKED.

Right you are. mlock_fixup->mlock_vma_pages_range is the missing piece.
This is called for both do_mlock and mlockall paths. So all good and
thanks for the clarification!

I will get back to this sometimes next week.
-- 
Michal Hocko
SUSE Labs
