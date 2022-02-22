Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93141C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 15:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiBVPxR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiBVPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:52:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDD60DAE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D92EB81B21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DA8C34100;
        Tue, 22 Feb 2022 15:52:19 +0000 (UTC)
Date:   Tue, 22 Feb 2022 10:52:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/ftrace: Make function graph use ftrace directly
Message-ID: <20220222105218.28e3d5aa@gandalf.local.home>
In-Reply-To: <20220222130049.81284-1-zhouchengming@bytedance.com>
References: <20220222130049.81284-1-zhouchengming@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 21:00:49 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
> use ftrace directly"), we don't need special hook for graph tracer,
> but instead we use graph_ops:func function to install return_hooker.
> 
> Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
> implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
> the same optimization on arm64.

Note. Ideally we want it to hook with DYNAMIC_FTARCE_WITH_ARGS, and not
FTRACE_WITH_REGS. If arm64 is like x86_64, saving all regs at every
function call has a bit more overhead than saving the minimum. The
DYNAMIC_FTRACE_WITH_ARGS, means that the minimum is still saved, but now
exposes the arguments and the stack pointer, which function_graph_tracer
needs.

-- Steve


> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
