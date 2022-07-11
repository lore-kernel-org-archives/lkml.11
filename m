Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2D5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 20:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiGKUmv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGKUmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:42:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD00774B0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48C23B81203
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CFAC34115;
        Mon, 11 Jul 2022 20:42:45 +0000 (UTC)
Date:   Mon, 11 Jul 2022 16:42:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] coccinelle: Remove script that checks replacing 0/1 with
 false/true in functions returning bool
Message-ID: <20220711164243.092eec75@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There is nothing wrong with current code that returns 0 or 1 for a
function returning bool. It is perfectly acceptable by the C standard.

To avoid churn of unwanted patches that are constantly sent to maintainers
who do not care about this change, remove the script that flags it as an
issue. This issue is not worth the burden on maintainers to accept
useless patches.

Link: https://lore.kernel.org/all/20220705073822.7276-1-jiapeng.chong@linux.alibaba.com/
Link: https://lore.kernel.org/all/20220429075201.68581-1-jiapeng.chong@linux.alibaba.com/
Link: https://lore.kernel.org/all/1649236467-29390-1-git-send-email-baihaowen@meizu.com/
Link: https://lore.kernel.org/all/20220317014740.3138-1-jiapeng.chong@linux.alibaba.com/
Link: https://lore.kernel.org/all/190b5c2f2f2fb9cc775fce8daed72bf893be48a4.1642065293.git.davidcomponentone@gmail.com/
Link: https://lore.kernel.org/all/20211214113845.439392-1-deng.changcheng@zte.com.cn/
Link: https://lore.kernel.org/all/20210824065735.60660-1-deng.changcheng@zte.com.cn/
Link: https://lore.kernel.org/all/20210824064305.60081-1-deng.changcheng@zte.com.cn/
Link: https://lore.kernel.org/all/20210824062359.59474-1-deng.changcheng@zte.com.cn/

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/coccinelle/misc/boolreturn.cocci | 59 ------------------------
 1 file changed, 59 deletions(-)
 delete mode 100644 scripts/coccinelle/misc/boolreturn.cocci

diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle/misc/boolreturn.cocci
deleted file mode 100644
index 29d2bf41e95d..000000000000
--- a/scripts/coccinelle/misc/boolreturn.cocci
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/// Return statements in functions returning bool should use
-/// true/false instead of 1/0.
-//
-// Confidence: High
-// Options: --no-includes --include-headers
-
-virtual patch
-virtual report
-virtual context
-
-@r1 depends on patch@
-identifier fn;
-typedef bool;
-symbol false;
-symbol true;
-@@
-
-bool fn ( ... )
-{
-<...
-return
-(
-- 0
-+ false
-|
-- 1
-+ true
-)
-  ;
-...>
-}
-
-@r2 depends on report || context@
-identifier fn;
-position p;
-@@
-
-bool fn ( ... )
-{
-<...
-return
-(
-* 0@p
-|
-* 1@p
-)
-  ;
-...>
-}
-
-
-@script:python depends on report@
-p << r2.p;
-fn << r2.fn;
-@@
-
-msg = "WARNING: return of 0/1 in function '%s' with return type bool" % fn
-coccilib.report.print_report(p[0], msg)
-- 
2.35.1

