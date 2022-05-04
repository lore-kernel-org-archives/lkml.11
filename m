Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2212C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 03:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiEDDf4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 23:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiEDDfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:35:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B01AF03
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x56R5P5Ovst1E8E/m3Q42KgG3BOgifNTi5pj7aSPnuQ=; b=OC5188RCeNmzIV/clsEa71+0AM
        8kZE/w3O1HprWmJBAKnItAlcllSYAUUyyUTK9J+oYNHpXst53X8tsrtpbbDQjkWuNBMGGx63gAkV0
        +bof377JuUv9evhToXmbfYVYyOicOPYAa3vxUIldkdfT6+n9Sm5zc87sH3Z3mC0VDMkqdD6q19/Lu
        AlH6nGuFL+Dj6vv/XzsWX2kF3DICyR0RNzkV/EFMIfqzRInT1UfglZbx0+Dt94FNfUUlptScc6rdi
        p4I1tgoEh1RhQfCXojJGZLcMM9JPj453nPBKNtFpZc1PpJWoE9jVJDq9yXv/vyamGag0lvqVIC5+M
        Q4/FXLUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm5kL-00GCYk-Id; Wed, 04 May 2022 03:32:13 +0000
Date:   Wed, 4 May 2022 04:32:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnHzvV2Uz2ynENnG@casper.infradead.org>
References: <20220503170341.1413961-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503170341.1413961-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 10:03:41AM -0700, Minchan Kim wrote:
> -void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
> -void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
> +void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
> +void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);

I see the build bot already beat me to pointing out why this is wrong,
but do you not look at git log to figure out why code was changed to be
the way it is now, before you change it back?
