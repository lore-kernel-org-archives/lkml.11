Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31406C4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 20:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbiBJUJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 15:09:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344102AbiBJUJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:09:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0232735
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:09:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3329A6182E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 20:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F4C004E1;
        Thu, 10 Feb 2022 20:09:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nIFkS-002zIr-MR;
        Thu, 10 Feb 2022 15:09:00 -0500
Message-ID: <20220210200509.089236997@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Feb 2022 15:05:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/6] tracing: Updates for v5.17
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fixes to the RTLA tooling.

 - A fix to a tp_printk overriding tp_printk_stop_on_boot on command line.

Daniel Bristot de Oliveira (5):
      rtla: Follow kernel version
      rtla/utils: Fix session duration parsing
      rtla/trace: Error message fixup
      rtla: Fix segmentation fault when failing to enable -t
      MAINTAINERS: Add RTLA entry

JaeSang Yoo (1):
      tracing: Fix tp_printk option related with tp_printk_stop_on_boot

----
 MAINTAINERS                            | 8 ++++++++
 kernel/trace/trace.c                   | 4 ++++
 tools/tracing/rtla/Makefile            | 4 +++-
 tools/tracing/rtla/src/osnoise.c       | 3 +++
 tools/tracing/rtla/src/osnoise_hist.c  | 7 +++----
 tools/tracing/rtla/src/osnoise_top.c   | 7 +++----
 tools/tracing/rtla/src/timerlat_hist.c | 7 +++----
 tools/tracing/rtla/src/timerlat_top.c  | 7 +++----
 tools/tracing/rtla/src/trace.c         | 8 ++++----
 tools/tracing/rtla/src/utils.c         | 4 ++--
 10 files changed, 36 insertions(+), 23 deletions(-)
