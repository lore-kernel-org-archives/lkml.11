Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ECC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 09:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiCNJ3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbiCNJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0931DD8;
        Mon, 14 Mar 2022 02:28:16 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EBkxPLM8JE+xb7garO/AIgaFKMfIedBjlr0n5DYGzsU=;
        b=JSc4ESWRtE/QCFAiN974jQFIsdEGXo3zYVNGrMwmP+ixL/UEXBjaPpC+fEKYnQzIYN2tLx
        IZidt7wHykGZZEW2fGEcxdfIOrPYD7xcWorltxsvrn6YoeAU+LThAt/llLXkrAzSsOjxDx
        uphOzxcJlCXYZjWZahLV0ugYusvgmZ9rTYKtv8GxPNJ3z4Dwu0PFOjqREQ5p/YOezL10+j
        R61Ls3SlR+Q3rgriXu5DsnH1TCYQ+Tib2ns7VwrVJtcmuLv8rijzbOlhSO0wgE0UPPM8CM
        Q3+JbYudaGxW7ArCupM1FZcB3f73sAI7nqaycODRmz6gCmCxzbuuZ6VvI49spQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EBkxPLM8JE+xb7garO/AIgaFKMfIedBjlr0n5DYGzsU=;
        b=RQ1JjvlrPthbll3Y+68SFbNNe+scJdZaajfTOJnad8q6btkgUMEkg7NpK5thg3tBns/6kF
        WH9eQhIWtEoogNCw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/irq_poll: Declare IRQ_POLL softirq vector as
 ksoftirqd-parking safe
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164725009404.16921.7536879085374537233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f96272a90d9eaea9933aaab704ddbd258feb3841
Gitweb:        https://git.kernel.org/tip/f96272a90d9eaea9933aaab704ddbd258feb3841
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 08 Feb 2022 17:16:35 +01:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 07 Mar 2022 23:53:50 +01:00

lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe

The following warning may appear while setting a CPU down:

	NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #20!!!

The IRQ_POLL_SOFTIRQ vector can be raised during the hotplug cpu_down()
path after ksoftirqd is parked and before the CPU actually dies. However
this is handled afterward at the CPUHP_IRQ_POLL_DEAD stage where the
queue gets migrated.

Hence this warning can be considered spurious and the vector can join
the "hotplug-safe" list.

Reported-and-tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
---
 include/linux/interrupt.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9613326..f40754c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -580,12 +580,15 @@ enum
 };
 
 /*
- * Ignoring the RCU vector after ksoftirqd is parked is fine
- * because:
- * 	1) rcutree_migrate_callbacks() takes care of the queue.
+ * The following vectors can be safely ignored after ksoftirqd is parked:
+ *
+ * _ RCU:
+ * 	1) rcutree_migrate_callbacks() migrates the queue.
  * 	2) rcu_report_dead() reports the final quiescent states.
+ *
+ * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
  */
-#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ))
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
