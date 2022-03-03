Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4BBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 22:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiCCWAv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiCCWAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:00:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF494579B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF54261D33
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6D7C004E1;
        Thu,  3 Mar 2022 22:00:01 +0000 (UTC)
Date:   Thu, 3 Mar 2022 17:00:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/4 v2] tracing: Add a way to have custom events in the
 tracefs directory
Message-ID: <20220303170000.1f4f0f2e@gandalf.local.home>
In-Reply-To: <20220303214832.031378059@goodmis.org>
References: <20220303214832.031378059@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2022 16:48:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> #define TRACE_INCLUDE_FILE trace_custom_sched
> #include <trace/define_custom_trace.h>
> ------------------------->%-------------------------  

It appears that I forgot to do a:

  git add include/trace/trace_custom_events.h include/trace/define_custom_trace.h

and those two very important files are missing from the last patch.

Will send a v3.

-- Steve
