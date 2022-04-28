Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD153C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 21:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352607AbiD1VzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346726AbiD1Vy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955F926101
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103B662006
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D80C385B5;
        Thu, 28 Apr 2022 21:51:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nkC32-003MZi-DY;
        Thu, 28 Apr 2022 17:51:40 -0400
Message-ID: <20220428215140.258564440@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 28 Apr 2022 17:51:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [for-next][PATCH 3/8] tracing: Introduce trace clock tai
References: <20220428215102.260147624@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Kanzenbach <kurt@linutronix.de>

A fast/NMI safe accessor for CLOCK_TAI has been introduced.
Use it for adding the additional trace clock "tai".

Link: https://lkml.kernel.org/r/20220414091805.89667-3-kurt@linutronix.de

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 400d3e9fe9ff..087740f63d92 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1542,6 +1542,7 @@ static struct {
 	{ ktime_get_mono_fast_ns,	"mono",		1 },
 	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
 	{ ktime_get_boot_fast_ns,	"boot",		1 },
+	{ ktime_get_tai_fast_ns,	"tai",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
-- 
2.35.1
