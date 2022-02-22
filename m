Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA8BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiBVPyg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiBVPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:54:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD7E652DC;
        Tue, 22 Feb 2022 07:53:52 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 87FA21F39E;
        Tue, 22 Feb 2022 15:53:51 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 73181A3B88;
        Tue, 22 Feb 2022 15:53:51 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     arnd@kernel.org
Subject: [PATCH] MIPS: Handle address errors for accesses above CPU max virtual user address
Date:   Tue, 22 Feb 2022 16:53:44 +0100
Message-Id: <20220222155345.138861-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address errors have always been treated as unaliged accesses and handled
as such. But address errors are also issued for illegal accesses like
user to kernel space or accesses outside of implemented spaces. This
change implements Linux exception handling for accesses to the illegal
space above the CPU implemented maximum virtual user address and the
MIPS 64bit architecture maximum. With this we can now use a fixed value
for the maximum task size on every MIPS CPU and get a more optimized
access_ok().

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/kernel/unaligned.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index df4b708c04a9..7b5aba5df02e 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -1480,6 +1480,23 @@ asmlinkage void do_ade(struct pt_regs *regs)
 	prev_state = exception_enter();
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
 			1, regs, regs->cp0_badvaddr);
+
+#ifdef CONFIG_64BIT
+	/*
+	 * check, if we are hitting space between CPU implemented maximum
+	 * virtual user address and 64bit maximum virtual user address
+	 * and do exception handling to get EFAULTs for get_user/put_user
+	 */
+	if ((regs->cp0_badvaddr >= (1UL << cpu_vmbits)) &&
+	    (regs->cp0_badvaddr < XKSSEG)) {
+		if (fixup_exception(regs)) {
+			current->thread.cp0_baduaddr = regs->cp0_badvaddr;
+			return;
+		}
+		goto sigbus;
+	}
+#endif
+
 	/*
 	 * Did we catch a fault trying to load an instruction?
 	 */
-- 
2.29.2

