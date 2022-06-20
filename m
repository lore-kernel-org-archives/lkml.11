Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7866C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 21:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiFTVch (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 17:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiFTVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:32:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71C412D32
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4511CCE17C2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E68C3411B;
        Mon, 20 Jun 2022 21:32:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1o3P0P-003o0g-Un;
        Mon, 20 Jun 2022 17:32:21 -0400
Message-ID: <20220620213158.468216113@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 20 Jun 2022 17:31:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Fixes for 5.19
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Gautam Menghani (1):
      tracing/uprobes: Remove unwanted initialization in __trace_uprobe_create()

Masami Hiramatsu (Google) (1):
      tracing/kprobes: Check whether get_kretprobe() returns NULL in kretprobe_dispatcher()

Xiang wangx (1):
      tracefs: Fix syntax errors in comments

sunliming (1):
      tracing: Simplify conditional compilation code in tracing_set_tracer()

----
 fs/tracefs/inode.c          |  2 +-
 kernel/trace/trace.c        |  2 --
 kernel/trace/trace_kprobe.c | 11 ++++++++++-
 kernel/trace/trace_uprobe.c |  1 -
 4 files changed, 11 insertions(+), 5 deletions(-)
