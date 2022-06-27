Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988F1C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 03:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiF0DXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 23:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiF0DXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:23:37 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882C272C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:23:35 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25R3MHAb012147;
        Mon, 27 Jun 2022 12:22:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25R3MHAb012147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656300138;
        bh=97eYsVHQn/scMnYMH7pkhsbcSK1IhdPPocIh+75FGu4=;
        h=From:To:Cc:Subject:Date:From;
        b=XNMCAB9x85Ft9HMdR9kedVHwdO0LTsltZioD+x8g6ccs+5wbjVW/TEsh8KWSYdSzA
         znIhrrkCv8CRy0Zvc6UWYB74nrfTJpgl5Z/1AeUNXML54lAEJR8Vf6Vq3cawndB7G/
         FZ86rZon9wFC0fvFYQH7yox7GAWsyZWUDgfiqxVP0kQEQHx415cdyW+zX++wkjaASW
         ZIk5dkAu1VvubC06lZdh0Bu1KFfKKb+lbubODnCopGok48wdEpk/4MpI4sw3wRJxE+
         kKQVtw/uV53gp0gh2RLnlfQXqZEJqmf4phRUJFxI0nAY18GQGoJKY+8jL+fdosg6+N
         0eNJLYK1c/cuQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] tick/nohz: unexport __init-annotated tick_nohz_full_setup()
Date:   Mon, 27 Jun 2022 12:22:09 +0900
Message-Id: <20220627032209.52396-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL and __init is a bad combination because the .init.text
section is freed up after the initialization. Hence, modules cannot
use symbols annotated __init. The access to a freed symbol may end up
with kernel panic.

modpost used to detect it, but it had been broken for a decade.

Commit 28438794aba4 ("modpost: fix section mismatch check for exported
init/exit sections") fixed it so modpost started to warn it again, then
this showed up:

    MODPOST vmlinux.symvers
  WARNING: modpost: vmlinux.o(___ksymtab_gpl+tick_nohz_full_setup+0x0): Section mismatch in reference from the variable __ksymtab_tick_nohz_full_setup to the function .init.text:tick_nohz_full_setup()
  The symbol tick_nohz_full_setup is exported and annotated __init
  Fix this by removing the __init annotation of tick_nohz_full_setup or drop the export.

Drop the export because tick_nohz_full_setup() is only called from the
built-in code in kernel/sched/isolation.c.

Fixes: ae9e557b5be2 ("time: Export tick start/stop functions for rcutorture")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/time/tick-sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 58a11f859ac7..30049580cd62 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -526,7 +526,6 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	cpumask_copy(tick_nohz_full_mask, cpumask);
 	tick_nohz_full_running = true;
 }
-EXPORT_SYMBOL_GPL(tick_nohz_full_setup);
 
 static int tick_nohz_cpu_down(unsigned int cpu)
 {
-- 
2.32.0

