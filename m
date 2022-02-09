Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D535AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 22:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiBIW7b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:59:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiBIW7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:59:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70496E019775
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:59:23 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id y23so4101340oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=uvj18JdALDTyA26ImErFuNGy6B/8vAJVfVxxI7MGaTM=;
        b=WG/G4fGENpWX/XkeGR6QHmH0cDKSeBMbhz7z2mK9w0WbYRRbQCRYbnXEG7sPMtBEOu
         uPopYA7OsEiCPUbRQ4MsoO8Zb3Yg/QORv8SB6g4q1LPqRNdmvJSXsT3lqQpk9DU3/qjb
         SX6Y418c2GNAnZHLTh+3uex7L44FUpBBioEcUp15x3Zd+1We3LZr3FenKLzQsJF9g1r2
         ui9YlyiDfa3xZOv1j6+JQ9M+ypoYiUqecjbMRSN6C2YXmiNc8cr6HKKedXHkbYj3bXP5
         AtDMrX96q4GYnjeiKI0efYQZkwfix5/mN/bMOoSKBXQrQuaNdZyhLPi7Jbk2eqNTI0jg
         YS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=uvj18JdALDTyA26ImErFuNGy6B/8vAJVfVxxI7MGaTM=;
        b=DEOiR//nHo0hTfuElC0Al7OhDIMVD3ubm4Coeh9uYQ/kqSxPLjHsjrYbmSTH6xhTgx
         ipPVHV7zz1L7x11SDOZ9gFIen9PNgtV1avuNRXfD0nNg22gijBabCF7PJ1+KRnf9+/tW
         vC+73dEqhL0mkAiduUQtAqVdID7GaBj3/H568b9sDclZWIiIh2cajqi2M8rGMRanV0+s
         eZZc1BvwlCxshIPlnPOdRODNFxqqWXpifVDeEN1kO7klKms0n3/ThecP83/rr4X1JVh4
         Uc+IN1xzVInlpiMxsghdzmJb/RXXyvTCo4KOGFcOZbEfb9fFZidWW4+RHy3jqQv3/pwM
         f/qA==
X-Gm-Message-State: AOAM530uFyl4Br/jRYHA5BXQQJfO/uI3whcTu5OPL8zb/VK45P5y52Az
        cUhKIa8K4p+uIxhpIsGvIr3kpQ==
X-Google-Smtp-Source: ABdhPJxJeLENcMrkf/ZQi9jdBZuxAD8iKmvJxNmhwu3EHmzGdlRZG6UqgJALyeHjqPem3G5g0ytwFw==
X-Received: by 2002:a05:6808:1902:: with SMTP id bf2mr2059138oib.55.1644447562612;
        Wed, 09 Feb 2022 14:59:22 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bl6sm7359384oib.38.2022.02.09.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:59:21 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:59:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Michal Hocko <mhocko@suse.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 00/13] mm/munlock: rework of mlock+munlock page
 handling
In-Reply-To: <YgQrpMpYiGZXqdbp@dhcp22.suse.cz>
Message-ID: <a650e078-25cb-14f8-4880-e575c937847@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <YgPfX+/f0ksBpx6G@dhcp22.suse.cz> <147388c6-eb7-5c58-79a-7a8279c27fd@google.com> <YgQrpMpYiGZXqdbp@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022, Michal Hocko wrote:
> On Wed 09-02-22 08:21:17, Hugh Dickins wrote:
> > On Wed, 9 Feb 2022, Michal Hocko wrote:
> [...]
> > > The only thing that is not entirely clear to me at the moment is why you
> > > have chosen to ignore already mapped LOCKONFAULT pages. They will
> > > eventually get sorted out during the reclaim/migration but this can
> > > backfire if too many pages have been pre-faulted before LOCKONFAULT
> > > call. Maybe not an interesting case in the first place but I am still
> > > wondering why you have chosen that way.
> > 
> > I'm puzzled: what makes you think I'm ignoring already mapped LOCKONFAULT
> > pages?  I'd consider that a bug.
> 
> I've had the following path in mind
> __mm_populate
>   populate_vma_page_range
>     if (vma->vm_flags & VM_LOCKONFAULT)
>     	return nr_page
> 
> which means that __get_user_pages is not called at all. This also means
> that follow_page_mask is skipped. The page table walk used to mark
> already mapped pages as mlocked so unless I miss some other path it
> would stay on its original LRU list and only get real mlock protection
> when encountered by the reclaim or migration.

That is so until 04/13: but then, whenever a page is faulted into a
VM_LOCKED area (except when skipping pte-of-compound) it goes through
mlock_page().  So it will then lock-on-fault.

Ah, but you're worrying about any previously-mapped pages when
VM_LOCKONFAULT is established: those ones get done by mlock_pte_range()
in 07/13, same as when VM_LOCKED is established - I checked again,
VM_LOCKONFAULT is not set without VM_LOCKED.

>  
> > It is the case, isn't it, that a VM_LOCKONFAULT area always has VM_LOCKED
> > set too?  If I've got that wrong, yes, I'll need to revisit conditions.
> 
> Yes, I did't really mean we would lose the mlock protection. We would
> just do the lazy mlock also on pages which are already mapped. This is
> certainly not a correctness issue - althoug stats might be off - but it
> could polute existing LRUs with mlocked pages rather easily.

Even with the lazy mlock in reclaim, I'd still accuse myself of a bug
if I've got this wrong.

> 
> As I've said. Either I am still missing something or this might even not
> be a big deal in real life. I was mostly curious about the choice to
> exclude the page table walk for LOCKONFAULT.

It surprised me too: but looking at how FOLL_POPULATE was handled in
faultin_page(), it appeared to me to become redundant, once mlocking
was counted at fault time (and in mlock_pte_range() - maybe that's
the page table walk you're looking for, not excluded but moved).

It is a big deal for me: please don't let me fool you, please do
continue to worry at it until you're convinced or you convince me.

Thanks,
Hugh
