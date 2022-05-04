Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C88C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 06:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbiEDGNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiEDGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:13:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14541EC4C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mLg1H11s7vwLj6tClFSIgTh3DOgfbrxxwGziAtkuLp4=; b=eV214LHb/UZi0ZSrWlQMcNMG5g
        DpH8mozghTyqroVmN4m8MymM9ejFV7R7x1XGd2y2XZJo3SfvtSUk3uEK6blqWeZru7CfRlYp0ez60
        yzagl3xaydH9tu6MXX5z3UgbRnoh+xQSHer9aTuu3hlAslwES1f17TClD9b91jMbZeIA0XqhByXEb
        6nMQ9lqfQj4d85bDzJGPWQzhOH3mldD8Z91WJoSOyRDZ9QP8SVeSkSyRc8qCk3WlX19Zu5vfuedcL
        dZqvWdZzZa91CLaP5gE2DAPaKVWXCh0qta43j9P6e8qu5i0isgyKXisYBB1CndthS8VV7RRLlGcBI
        MJcnUMTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm8Cf-00GHkz-9X; Wed, 04 May 2022 06:09:37 +0000
Date:   Wed, 4 May 2022 07:09:37 +0100
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
Message-ID: <YnIYofrw/GGEvc0U@casper.infradead.org>
References: <20220503170341.1413961-1-minchan@kernel.org>
 <YnHzvV2Uz2ynENnG@casper.infradead.org>
 <YnIBbjRYACzvuZpp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnIBbjRYACzvuZpp@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 09:30:38PM -0700, Minchan Kim wrote:
> On Wed, May 04, 2022 at 04:32:13AM +0100, Matthew Wilcox wrote:
> > On Tue, May 03, 2022 at 10:03:41AM -0700, Minchan Kim wrote:
> > > -void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
> > > -void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
> > > +void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
> > > +void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
> > 
> > I see the build bot already beat me to pointing out why this is wrong,
> > but do you not look at git log to figure out why code was changed to be
> > the way it is now, before you change it back?
> 
> This patch added a new field as out param like compact_control so
> the rmap_walk_control is not immutable.

... but we have a user which treats it as if it is.
