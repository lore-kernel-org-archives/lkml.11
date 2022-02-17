Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 10:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiBQKYy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:24:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbiBQKY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E6B27908C;
        Thu, 17 Feb 2022 02:24:14 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645093453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWbPOcLNbd+78CrHSdKKmwuiwmtQSc74Iuad3beVla8=;
        b=fHPPBLjF9+ZJ48rBstHcHLvXZjVophxsE6QjuwpIIfRtQGlrK+GWyvmbGeDhofvpqhp8mX
        7BhQ0dwvGE3ilLt0IT5HsTJishv3qIqEoxHgPbeNp2E+f5Dq1xp3rIoWBy6YCwUw68l2c3
        bhuLUvZbsSUMlEXeYejuDJBLrI84iZ5x8kRKcHo7GsgKVnjJGAeyec8l3yxi3PrwW2z2tC
        zS+I0XsTmT09fUnOofJFd+1YP6tFV2ooRO9VAkg5a70bF02GDkB5P4EeNg9SkYIg23VaVB
        vsih6ug4akfMlyV9mplT/bnDVKnI8Vxo8T+NZnkRsfNeuo7iBRbUN6zv1LRVCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645093453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWbPOcLNbd+78CrHSdKKmwuiwmtQSc74Iuad3beVla8=;
        b=gyBFGLoe6dzqIDz/Zv/9rNogBmQdaqQftY6FSSOmcrPYKlrIV1jDtFPOmxx/9f3gNZsfig
        GPziWMahoxOIeICA==
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 8/8] kernel/fork: Use IS_ENABLED() in account_kernel_stack().
Date:   Thu, 17 Feb 2022 11:24:06 +0100
Message-Id: <20220217102406.3697941-9-bigeasy@linutronix.de>
In-Reply-To: <20220217102406.3697941-1-bigeasy@linutronix.de>
References: <20220217102406.3697941-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not strickly needed but checking CONFIG_VMAP_STACK instead of
task_stack_vm_area()' result allows the compiler the remove the else
path in the CONFIG_VMAP_STACK case where the pointer can't be NULL.

Check for CONFIG_VMAP_STACK in order to use the proper path.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index aa17ed2a2afc7..4c97e0b5fb62a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -485,16 +485,16 @@ void vm_area_free(struct vm_area_struct *vma)
=20
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
-	void *stack =3D task_stack_page(tsk);
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-
-	if (vm) {
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm =3D task_stack_vm_area(tsk);
 		int i;
=20
 		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
 			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
+		void *stack =3D task_stack_page(tsk);
+
 		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
--=20
2.34.1

