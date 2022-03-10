Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 15:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbiCJPLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiCJPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:10:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD990195300
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:04:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37D8561670
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CA2C340E8;
        Thu, 10 Mar 2022 15:04:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nSKLR-001DYf-E8;
        Thu, 10 Mar 2022 10:04:49 -0500
Message-ID: <20220310150431.248810778@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Mar 2022 10:04:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Three fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Minor tracing fixes:

 - Fix unregistering the same event twice a the user could disable
   the event osnoise will disable on unregistering.

 - Inform RCU of a quiescent state in the osnoise testing thread.

 - Fix some kerneldoc comments.

Daniel Bristot de Oliveira (1):
      tracing/osnoise: Do not unregister events twice

Jiapeng Chong (1):
      ftrace: Fix some W=1 warnings in kernel doc comments

Nicolas Saenz Julienne (1):
      tracing/osnoise: Force quiescent states while tracing

----
 kernel/trace/ftrace.c        |  4 ++--
 kernel/trace/trace_osnoise.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
