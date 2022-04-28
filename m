Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFCEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 21:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352682AbiD1Vzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbiD1Vy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9465221E3B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC0461FB9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809CAC385B9;
        Thu, 28 Apr 2022 21:51:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nkC32-003MaG-Jh;
        Thu, 28 Apr 2022 17:51:40 -0400
Message-ID: <20220428215140.438634489@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 28 Apr 2022 17:51:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [for-next][PATCH 4/8] tracing: Add documentation for trace clock tai
References: <20220428215102.260147624@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Kanzenbach <kurt@linutronix.de>

Add documentation for newly introduced trace clock "tai".
This clock corresponds to CLOCK_TAI.

Link: https://lkml.kernel.org/r/20220414091805.89667-4-kurt@linutronix.de

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 45b8c56af67a..b37dc19e4d40 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -517,6 +517,18 @@ of ftrace. Here is a list of some of the key files:
 		processing should be able to handle them. See comments in the
 		ktime_get_boot_fast_ns() function for more information.
 
+	tai:
+		This is the tai clock (CLOCK_TAI) and is derived from the wall-
+		clock time. However, this clock does not experience
+		discontinuities and backwards jumps caused by NTP inserting leap
+		seconds. Since the clock access is designed for use in tracing,
+		side effects are possible. The clock access may yield wrong
+		readouts in case the internal TAI offset is updated e.g., caused
+		by setting the system time or using adjtimex() with an offset.
+		These effects are rare and post processing should be able to
+		handle them. See comments in the ktime_get_tai_fast_ns()
+		function for more information.
+
 	To set a clock, simply echo the clock name into this file::
 
 	  # echo global > trace_clock
-- 
2.35.1
