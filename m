Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54246C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 01:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiBXBa4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 20:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiBXBat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:30:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0315471F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:30:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D4E60FC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACFAC340E7;
        Thu, 24 Feb 2022 01:30:03 +0000 (UTC)
Date:   Wed, 23 Feb 2022 20:30:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] arm64/ftrace: Make function graph use
 ftrace directly
Message-ID: <20220223203001.1158d9d4@rorschach.local.home>
In-Reply-To: <5d64733b-8d2a-4928-c4dc-ce4f3b5fc561@bytedance.com>
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
        <20220222105218.28e3d5aa@gandalf.local.home>
        <5d64733b-8d2a-4928-c4dc-ce4f3b5fc561@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 16:00:27 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> Yes, it would be better to implement DYNAMIC_FTRACE_WITH_ARGS on arm64 too,
> and this patch just use DYNAMIC_FTRACE_WITH_REGS to install return_hooker
> for graph tracer, so it's a code cleanup, no performance optimization.

I'm worried that a clean up is either breaking the design or hurting
performance.

You have:

> +void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> +		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	struct pt_regs *regs = arch_ftrace_get_regs(fregs);

Now, technically, arch_ftrace_get_regs() is to return NULL if the
ftrace_ops was not registered with ops->flags |= FTRACE_OPS_FL_SAVE_REGS.

Which function graph does not do.

But this is in arch specific code so you have more control of this
"undefined behavior". But you really should have a comment saying that
this needs to be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.

-- Steve


> +	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
> +
> +	prepare_ftrace_return(ip, parent, frame_pointer(regs));
> +}

-- Steve
