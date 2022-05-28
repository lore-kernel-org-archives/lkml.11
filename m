Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9829FC4332F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 May 2022 03:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiE1DRs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiE1DRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 23:17:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003834BA3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 20:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7398B8268D
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 03:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33BFC34114;
        Sat, 28 May 2022 03:17:42 +0000 (UTC)
Date:   Fri, 27 May 2022 23:17:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 00/23] tracing: Last minute fixes and updates
 for 5.19
Message-ID: <20220527231741.5ef31534@gandalf.local.home>
In-Reply-To: <20220528025028.850906216@goodmis.org>
References: <20220528025028.850906216@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 22:50:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Actually, a lot of these changes were in my queue, I just haven't
> tested them. But they are mostly fixes and clean ups. No real functional
> features.
> 
> My tests on these have not completely finished, so I may have to rebase.
> But since this is half way into the merge window, I want these in
> linux-next for a little bit before sending my pull request.
> 

> Steven Rostedt (Google) (2):
>       ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function

And my test just failed on this one :-p (Something stupid and minor)

I guess I'll send out a v6 and try again.

-- Steve

