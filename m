Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1077C25B08
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 12:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbiHTMsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 08:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C51F21E0B;
        Sat, 20 Aug 2022 05:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17EFD61226;
        Sat, 20 Aug 2022 12:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0111C433D6;
        Sat, 20 Aug 2022 12:48:24 +0000 (UTC)
Date:   Sat, 20 Aug 2022 08:48:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] tracing/eprobes: Do not hardcode $comm as a string
Message-ID: <20220820084837.4d6a95e4@gandalf.local.home>
In-Reply-To: <20220820201824.5637c4feff4a7674aebde60a@kernel.org>
References: <20220820014035.531145719@goodmis.org>
        <20220820014833.035925907@goodmis.org>
        <20220820201824.5637c4feff4a7674aebde60a@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 20:18:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Do not assume that comm is a string. Not to mention, it currently forces
> > comm fields to fault, as string processing for event probes is currently
> > broken.  
> 
> Indeed. There should be an event argument which names "comm".
> Eprobe might refer it. BTW, does eprobe use any special common fields?
> I originally introduced "$" variable for such special variables.

I used the '$' for denoting the fields, as it was the easiest way to
integrate with trace_probe.c. There's no special variables, but this patch
series now allows '@' as well as if $comm (or $COMM) is not a field, it
acts the same as $comm for kprobes. Filtering and histograms do the same
thing (use 'comm' as the event field, or has the current->comm if the event
does not have 'comm' as a field). I should probably make "$common_comm"
used too.

-- Steve
