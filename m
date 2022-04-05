Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838783AbiDFA4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385155AbiDEMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:31:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C87DE1A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:45:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 99DBD210E5;
        Tue,  5 Apr 2022 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649159149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2+2DI4PJUlQeQ3bPjloIZWijphTujPw/rrjaz7/Ejs=;
        b=ghtHkB4Oe3/PPKVMfeSxtiRqyttn4srt4dPMqKfup4sys6+1pALw8SNp1pRxsbuNgfa2U1
        za2xH+BJM6ssCQ5jl1aKQwmnkGePjjYuRUxUYNmBkyg3kUv/7Yviozl12mPKkoWf4YWkfr
        yFpKJIYX1CUAzxHqmSdGe/Mjx9kU8pY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86893A3B87;
        Tue,  5 Apr 2022 11:45:48 +0000 (UTC)
Date:   Tue, 5 Apr 2022 13:45:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: mm: swap: locking in release_pages()
Message-ID: <Ykwr7OHllqM+Dpii@dhcp22.suse.cz>
References: <89009285-c75d-0f09-5b08-d133c42a18f9@nokia.com>
 <YkwdRnuQBjoJ01YK@dhcp22.suse.cz>
 <dc5eb22d-5389-bacb-3756-253e774a8394@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5eb22d-5389-bacb-3756-253e774a8394@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-04-22 13:36:09, Alexander Sverdlin wrote:
> Hello Michal,
> 
> thanks for the quick reply!
> 
> On 05/04/2022 12:43, Michal Hocko wrote:
> >> 1. Crash of v5.4.170 on an ARM32 machine:
> >>
> >> Unable to handle kernel NULL pointer dereference at virtual address 00000104
> >> pgd = e138149d
> >> [00000104] *pgd=84d2fd003, *pmd=8ffd6f003
> >> Internal error: Oops: a07 [#1] PREEMPT SMP ARM
> >> ...
> >> CPU: 1 PID: 6172 Comm: AaSysInfoRColle Tainted: G    B      O      5.4.170-... #1
> >> Hardware name: Keystone
> >> PC is at release_pages+0x194/0x358
> >> LR is at release_pages+0x10c/0x358
> > Which LOC does this correspond to? (faddr2line should give you a nice
> > output).
> 
> Sorry, I forgot this info in the initial report:
> 
> this is indeed the del_page_from_lru_list() in this crash.

Could you be more specific please? Is the problem in list_del or
update_lru_size?

-- 
Michal Hocko
SUSE Labs
