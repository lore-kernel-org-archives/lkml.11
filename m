Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38504C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 14:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349062AbiCOOQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiCOOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E784EA0B;
        Tue, 15 Mar 2022 07:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0486A61699;
        Tue, 15 Mar 2022 14:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF0C340E8;
        Tue, 15 Mar 2022 14:15:25 +0000 (UTC)
Date:   Tue, 15 Mar 2022 10:15:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the ftrace tree with the nfsd tree
Message-ID: <20220315101524.6215285d@gandalf.local.home>
In-Reply-To: <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
References: <20220315145828.413e9301@canb.auug.org.au>
        <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 13:33:30 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> >  af6b9668e85f ("tracing: Move the defines to create TRACE_EVENTS into their own files")
> > 
> > from the ftrace tree.
> > 
> > Well, this is a pain :-(  

Welcome to the include/trace directory ;-)

> 
> Apologies. Steven, can you take the sockaddr patches in your tree
> and resolve the x86_64 build issue?

My apologies, I forgot that there was changes in other trees that affect
this.

Anyway, I'll go and do a merge myself and see what happens. The point of
linux-next is to resolve these kinds of issues. I believe the reason you
took those changes was because you have a dependency on them, and I think
they should stay in your tree.

Let me do the merge myself and verify what Stephen did was correct or needs
to be updated. This will also need to be done for Linus as well.

Thanks,

-- Steve
