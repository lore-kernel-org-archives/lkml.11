Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiCBPtf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbiCBPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8F29819
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C705AB82084
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AEEC340F2;
        Wed,  2 Mar 2022 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236108;
        bh=b9g+mN/ZAtwltAyMV/mSLAV7goZAk3S3vfRPncmJ4xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onbUAlHDET9OqsvCzKqWXGdJlDrv9JTIL4U3pvQYJQkiVlADwu27jENpZWXlQqODi
         /4cCMKP9vE5KUAptZajfQBDlmw0xcuqNnb6keCvxn8Er89Jm7+4usCI6gs57s1hLyx
         kPnmSnbIIX+naKTgcKdwON0quUBIZbrau6MJjLM8Yq8yDIcnsBP0fhTYyEde7bBBDy
         1If4G6fVpiHl81o8EJKWdPJl03O9HVFzglQ+IMBcYW9JzgeNtKcQ2DQgH0fu2mQIvk
         cS5vjnmMUKgZVMry5iI2jU7KlUbOJRD92PUZLuaOYytJ8NhucRukb5bIXwNAymVE8Q
         9TjlWKevj6Z9w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/19] context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
Date:   Wed,  2 Mar 2022 16:47:54 +0100
Message-Id: <20220302154810.42308-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

context_tracking_enter() and context_tracking_exit() have confusing
names that don't explain the fact they are referring to user/guest state.

Use more self-explanatory names and shrink to the new context tracking
prefix instead.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 include/linux/context_tracking.h | 13 +++++++------
 kernel/context_tracking.c        | 12 ++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 69532cd18f72..7a5f04ae1758 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -17,21 +17,22 @@ extern void context_tracking_cpu_set(int cpu);
 extern void __ct_user_enter(enum ctx_state state);
 extern void __ct_user_exit(enum ctx_state state);
 
-extern void context_tracking_enter(enum ctx_state state);
-extern void context_tracking_exit(enum ctx_state state);
+extern void ct_user_enter(enum ctx_state state);
+extern void ct_user_exit(enum ctx_state state);
+
 extern void user_enter_callable(void);
 extern void user_exit_callable(void);
 
 static inline void user_enter(void)
 {
 	if (context_tracking_enabled())
-		context_tracking_enter(CONTEXT_USER);
+		ct_user_enter(CONTEXT_USER);
 
 }
 static inline void user_exit(void)
 {
 	if (context_tracking_enabled())
-		context_tracking_exit(CONTEXT_USER);
+		ct_user_exit(CONTEXT_USER);
 }
 
 /* Called with interrupts disabled.  */
@@ -57,7 +58,7 @@ static inline enum ctx_state exception_enter(void)
 
 	prev_ctx = this_cpu_read(context_tracking.state);
 	if (prev_ctx != CONTEXT_KERNEL)
-		context_tracking_exit(prev_ctx);
+		ct_user_exit(prev_ctx);
 
 	return prev_ctx;
 }
@@ -67,7 +68,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) &&
 	    context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
-			context_tracking_enter(prev_ctx);
+			ct_user_enter(prev_ctx);
 	}
 }
 
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 83e050675b23..e8e58c10f135 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -103,7 +103,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__ct_user_enter);
 
-void context_tracking_enter(enum ctx_state state)
+void ct_user_enter(enum ctx_state state)
 {
 	unsigned long flags;
 
@@ -122,8 +122,8 @@ void context_tracking_enter(enum ctx_state state)
 	__ct_user_enter(state);
 	local_irq_restore(flags);
 }
-NOKPROBE_SYMBOL(context_tracking_enter);
-EXPORT_SYMBOL_GPL(context_tracking_enter);
+NOKPROBE_SYMBOL(ct_user_enter);
+EXPORT_SYMBOL_GPL(ct_user_enter);
 
 /**
  * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
@@ -173,7 +173,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__ct_user_exit);
 
-void context_tracking_exit(enum ctx_state state)
+void ct_user_exit(enum ctx_state state)
 {
 	unsigned long flags;
 
@@ -184,8 +184,8 @@ void context_tracking_exit(enum ctx_state state)
 	__ct_user_exit(state);
 	local_irq_restore(flags);
 }
-NOKPROBE_SYMBOL(context_tracking_exit);
-EXPORT_SYMBOL_GPL(context_tracking_exit);
+NOKPROBE_SYMBOL(ct_user_exit);
+EXPORT_SYMBOL_GPL(ct_user_exit);
 
 /**
  * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
-- 
2.25.1

