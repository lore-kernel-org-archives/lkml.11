Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD39CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 22:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiEOWJJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 18:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEOWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 18:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD124964
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 15:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69833611A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 22:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB27C385B8;
        Sun, 15 May 2022 22:09:04 +0000 (UTC)
Date:   Sun, 15 May 2022 18:09:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Perches <joe@perches.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm v2] tracing: incorrect gfp_t conversion
Message-ID: <20220515180903.37fc18e4@gandalf.local.home>
In-Reply-To: <8b9ba8ce-7376-2ef2-95f5-30e53cb46914@openvz.org>
References: <b8feb625dd2ba0d0dfc298a2f39ca1d8368ba5c9.camel@perches.com>
        <8b9ba8ce-7376-2ef2-95f5-30e53cb46914@openvz.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 10:20:39 +0300
Vasily Averin <vvs@openvz.org> wrote:

> Fixes the following sparse warnings:
> 
> include/trace/events/*: sparse: cast to restricted gfp_t
> include/trace/events/*: sparse: restricted gfp_t degrades to integer
> 
> gfp_t type is bitwise and requires __force attributes for any casts.
> 
> Signed-off-by:	Vasily Averin <vvs@openvz.org>
> ---
> v2: 1) re-based to 5.18-rc6
>     2) re-defined __def_gfpflag_names array according to
> 	akpm@, willy@ and Joe Perches recommendations
> ---
>  include/linux/gfp.h               |  2 +-
>  include/trace/events/btrfs.h      |  4 +-
>  include/trace/events/compaction.h |  4 +-
>  include/trace/events/kmem.h       | 12 ++---
>  include/trace/events/mmflags.h    | 84 ++++++++++++++++---------------
>  include/trace/events/vmscan.h     | 16 +++---
>  mm/compaction.c                   |  2 +-
>  7 files changed, 63 insertions(+), 61 deletions(-)

From the tracing POV:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
