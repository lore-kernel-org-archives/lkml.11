Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBDEC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 May 2022 13:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385411AbiEGOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 May 2022 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbiEGOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D629CA5
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20A116124C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 13:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA29C385A9;
        Sat,  7 May 2022 13:57:25 +0000 (UTC)
Date:   Sat, 7 May 2022 09:57:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes: Fix build errors with CONFIG_KRETPROBES=n
Message-ID: <20220507095723.5f2639a7@rorschach.local.home>
In-Reply-To: <20220505093140.9a0500813b8d529442c76933@kernel.org>
References: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
        <165163539094.74407.3838114721073251225.stgit@devnote2>
        <CAMo8BfJF_HTZc-PUrK4y5yLEdwWPmpKu2NyzJusjGd1Ste0b3g@mail.gmail.com>
        <20220505093140.9a0500813b8d529442c76933@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 09:31:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Steve, can you pick this fix?

Hi Masami,

When I get back home from traveling I'll pull this in.

-- Steve
