Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D419BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 19:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiBRTX3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:23:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiBRTXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:23:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A36340FC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7911CE3314
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 19:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF58C340E9;
        Fri, 18 Feb 2022 19:23:02 +0000 (UTC)
Date:   Fri, 18 Feb 2022 14:23:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jakub =?UTF-8?B?TWF0xJtuYQ==?= <matenajakub@gmail.com>,
        linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, liam.howlett@oracle.com,
        hughd@google.com, kirill@shutemov.name, riel@surriel.com,
        peterz@infradead.org
Subject: Re: [RFC PATCH 4/4] [PATCH 4/4] mm: add tracing for VMA merges
Message-ID: <20220218142301.0b5731e1@gandalf.local.home>
In-Reply-To: <Yg/phVScjJCLsGuC@casper.infradead.org>
References: <20220218122019.130274-1-matenajakub@gmail.com>
        <20220218122019.130274-5-matenajakub@gmail.com>
        <20220218130920.5902d967@gandalf.local.home>
        <Yg/phVScjJCLsGuC@casper.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 18:46:29 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Feb 18, 2022 at 01:09:20PM -0500, Steven Rostedt wrote:
> > Please indent the above better. That is:
> > 
> > 		__entry->diff_count = (merge_prev == AV_MERGE_DIFFERENT)
> > 				+ (merge_next == AV_MERGE_DIFFERENT)
> > 				+ (merge_both == AV_MERGE_DIFFERENT);  
> 
> I thought our coding style preferred trailing operators; that is:
> 
> 		 __entry->diff_count = (merge_prev == AV_MERGE_DIFFERENT) +
> 				(merge_next == AV_MERGE_DIFFERENT) +
> 				(merge_both == AV_MERGE_DIFFERENT);

I'm OK with either. I just can't handle the original.

-- Steve
