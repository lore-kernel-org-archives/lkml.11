Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F59FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 04:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiCBEgr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbiCBEga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A631DB108C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uYCqflrBoaogKtYO3azgayBAXohniRh2EXS8txrntpg=; b=OtlzBRNUz6ChHQOoQvjzKJEbV2
        ywF0K/EWNPqawhanWFG+QyzDP5DyXeiHeTQDNpftYahnjpxwm1rdDQ+OKMHlmHFr+L4edPZP+U09X
        oDlF1dvNRBjBCEcMgBzXX+D4J4JQx/rl5jbY+rXa7fhGKzIAg8emPzobPN0fZxPNUbheahoniwYpw
        YExRoAk12YUc/AH1KQzhPjiioRKEirTlPB+8rrZo/fJrS+BgGQgPKQwaaoduGi7pNBMvejS5Z8/VW
        at4Gcjkvfc7m78qjyCL0owHiCEMeDgTzeiKncGzduyT2BHERbUvLz0U1FSwoSTcwKLDZhg2HsmZ+K
        qy2o/bIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhR-00AF73-Vd; Wed, 02 Mar 2022 04:34:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] swait: Parameterize the return variable to __swait_event_interruptible_timeout()
Date:   Wed,  2 Mar 2022 04:34:35 +0000
Message-Id: <20220302043451.2441320-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220302043451.2441320-1-willy@infradead.org>
References: <20220302043451.2441320-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not refer to variables which aren't in their arguments.
Pass the name from its caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swait.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 0ca80e31776f..4147be3a0014 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -215,7 +215,7 @@ do {									\
 	__ret;								\
 })
 
-#define __swait_event_interruptible_timeout(wq, condition, timeout)	\
+#define __swait_event_interruptible_timeout(wq, condition, timeout, __ret) \
 	___swait_event(wq, ___wait_cond_timeout(condition, __ret),	\
 		      TASK_INTERRUPTIBLE, timeout,			\
 		      __ret = schedule_timeout(__ret))
@@ -225,7 +225,7 @@ do {									\
 	long __ret = timeout;						\
 	if (!___wait_cond_timeout(condition, __ret))			\
 		__ret = __swait_event_interruptible_timeout(wq,		\
-						condition, timeout);	\
+					condition, timeout, __ret);	\
 	__ret;								\
 })
 
-- 
2.34.1

