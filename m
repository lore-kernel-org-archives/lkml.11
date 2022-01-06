Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2280C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jan 2022 15:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbiAFPAE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:00:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32994 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiAFPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:00:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34B68B820CD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29C9C36AE0;
        Thu,  6 Jan 2022 15:00:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n5UFD-000sLI-VY;
        Thu, 06 Jan 2022 09:59:59 -0500
Message-ID: <20220106145716.663267282@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Jan 2022 09:57:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [for-linus][PATCH 0/3] tracing: Minor fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three minor tracing fixes:

- Fix missing prototypes in sample module for direct functions

- Fix check of valid buffer in get_trace_buf()

- Fix annotations of percpu pointers.

Jiri Olsa (1):
      ftrace/samples: Add missing prototypes direct functions

Naveen N. Rao (2):
      tracing: Fix check for trace_percpu_buffer validity in get_trace_buf()
      tracing: Tag trace_percpu_buffer as a percpu pointer

----
 kernel/trace/trace.c                        | 6 +++---
 samples/ftrace/ftrace-direct-modify.c       | 3 +++
 samples/ftrace/ftrace-direct-multi-modify.c | 3 +++
 samples/ftrace/ftrace-direct-too.c          | 3 +++
 samples/ftrace/ftrace-direct.c              | 2 ++
 5 files changed, 14 insertions(+), 3 deletions(-)
