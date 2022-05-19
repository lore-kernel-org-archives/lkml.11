Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87478C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 21:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbiESVlu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245170AbiESVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:41:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B448336
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NtxpRvMipUusyaSMRuF1GQDqmhBvdAgxyA3nzuh6DWA=; b=c0ExzCD7vdgcK8CuVpLeNS58qh
        z1gw/+kXW09MsN4iKGZNlIKznt/1t5bWNKdVzQff3gBQZ8swGJh3MLaVB1r1zjspUe3SEIIPUNjv4
        CtFYlGnl1GeK4KsSmsV0hpt+GJWZRCKMSfaq2i+VQcTBTqo/joN8IGJJb01EalZUhkZsqWi52XzFd
        ZWHxIyAyP0BQxc8QJOVI1FSBFoXo1NNwfgNGePFsx0nB8LgKFXiYj0yaL+VA6UP9wQusKw3aTZIUy
        09GMAsFY9LK/66uO0H3TjCtnIyDTQh0lz5BUqSnHPW3ehSdcdFlOAQhQqDTRoOmAZtyC1YLYljoII
        71pnN0kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrntP-0028du-Bd; Thu, 19 May 2022 21:41:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A49E301152;
        Thu, 19 May 2022 23:41:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 10ADC2021AF7C; Thu, 19 May 2022 23:41:07 +0200 (CEST)
Message-ID: <20220519213421.869214636@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 19 May 2022 23:27:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org
Subject: [RFC][PATCH 5/9] rcu: Fix rcu_idle_exit()
References: <20220519212750.656413111@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current rcu_idle_exit() is terminally broken because it uses
local_irq_{save,restore}(), which are traced which uses RCU.

However, now that all the callers are sure to have IRQs disabled, we
can remove these calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -659,7 +659,7 @@ static noinstr void rcu_eqs_enter(bool u
  * If you add or remove a call to rcu_idle_enter(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_enter(void)
+void noinstr rcu_idle_enter(void)
 {
 	lockdep_assert_irqs_disabled();
 	rcu_eqs_enter(false);
@@ -896,13 +896,10 @@ static void noinstr rcu_eqs_exit(bool us
  * If you add or remove a call to rcu_idle_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_exit(void)
+void noinstr rcu_idle_exit(void)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
+	lockdep_assert_irqs_disabled();
 	rcu_eqs_exit(false);
-	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(rcu_idle_exit);
 


