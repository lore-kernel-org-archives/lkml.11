Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134AAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Apr 2022 11:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiDXLup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Apr 2022 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiDXLuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 07:50:32 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AEF8136E36
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 04:47:31 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D4AA79200B3; Sun, 24 Apr 2022 13:47:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CEE6592009B;
        Sun, 24 Apr 2022 12:47:30 +0100 (BST)
Date:   Sun, 24 Apr 2022 12:47:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sched_clock: Fix formatting of frequency reporting
 code
In-Reply-To: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204240148220.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use flat rather than nested indentation for chained else/if clauses as 
per coding-style.rst:

	if (x == y) {
		..
	} else if (x > y) {
		...
	} else {
		....
	}

This also improves readability.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 32fea568aec5b ("timers, sched/clock: Clean up the code a bit")
---
Hi,

 I guess this got broken with 32fea568aec5b by mistake.

  Maciej
---
 kernel/time/sched_clock.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

linux-sched-clock-rate-cond.diff
Index: linux-macro/kernel/time/sched_clock.c
===================================================================
--- linux-macro.orig/kernel/time/sched_clock.c
+++ linux-macro/kernel/time/sched_clock.c
@@ -202,13 +202,11 @@ sched_clock_register(u64 (*read)(void),
 	if (r >= 4000000) {
 		r = DIV_ROUND_CLOSEST(r, 1000000);
 		r_unit = 'M';
+	} else if (r >= 4000) {
+		r = DIV_ROUND_CLOSEST(r, 1000);
+		r_unit = 'k';
 	} else {
-		if (r >= 4000) {
-			r = DIV_ROUND_CLOSEST(r, 1000);
-			r_unit = 'k';
-		} else {
-			r_unit = ' ';
-		}
+		r_unit = ' ';
 	}
 
 	/* Calculate the ns resolution of this counter */
