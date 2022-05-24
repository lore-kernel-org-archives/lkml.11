Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E9BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 20:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiEXUbA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiEXUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:30:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6CB62BDB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E46F3B81B9B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3259C34100;
        Tue, 24 May 2022 20:30:53 +0000 (UTC)
Date:   Tue, 24 May 2022 16:30:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes: Fix build errors with CONFIG_KRETPROBES=n
Message-ID: <20220524163052.7aacc45f@gandalf.local.home>
In-Reply-To: <20220507095723.5f2639a7@rorschach.local.home>
References: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
        <165163539094.74407.3838114721073251225.stgit@devnote2>
        <CAMo8BfJF_HTZc-PUrK4y5yLEdwWPmpKu2NyzJusjGd1Ste0b3g@mail.gmail.com>
        <20220505093140.9a0500813b8d529442c76933@kernel.org>
        <20220507095723.5f2639a7@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2022 09:57:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 5 May 2022 09:31:40 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Steve, can you pick this fix?  
> 
> Hi Masami,
> 
> When I get back home from traveling I'll pull this in.
>

Just added it to my queue. I'll be running tests when I've finished with
all the patches in my backlog.

-- Steve
