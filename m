Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 23:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGRXRz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGRXRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B5633404
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22B67615C2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555EAC341C0;
        Mon, 18 Jul 2022 23:17:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oDZzn-000ZeL-38;
        Mon, 18 Jul 2022 19:17:47 -0400
Message-ID: <20220718231725.880245563@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 18 Jul 2022 19:17:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: A few more updates for 5.20
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 659a93c01063f2fe4aac85938cb52306fe8dd5ac


Masami Hiramatsu (Google) (1):
      selftests/kprobe: Update test for no event name syntax error

Steven Rostedt (Google) (1):
      tracing: Add example and documentation for new __vstring() macro

----
 samples/trace_events/trace-events-sample.c         | 14 ++++++++--
 samples/trace_events/trace-events-sample.h         | 32 +++++++++++++++++++---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  1 +
 3 files changed, 41 insertions(+), 6 deletions(-)
