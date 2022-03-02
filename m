Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E807EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 04:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiCBEhF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiCBEgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:36:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD0B10AF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zWLbUpoRsK7H/JHkwHsYHjVomRYbwn2YJ6bzcJ9P+js=; b=bGUXV9Js0AfoNwuyEerE5jofyd
        XRtktkuJVm2h8+iZHnHBcaWQYy2xjKOodGFg9W0tncnxqCM4AlulGwCjYEOT7R323d+SxuMExUvhO
        08JT7BI5LhQe5DyeYXb8SOJsI7Lchud+4FvUFnEo+II7pwm4tTuAJPNMt1Rtr8GTzzBZNZYsFB/Xn
        nVS1ziFd5jHFl3THDMY6eslVl/NueyG0gTX7AtyRfGRaGTKdoCxPitVCligQNgufq1o0bepNX3fg2
        J3yGZic+i5ZO4AviOgpOunCaM47bSK4sRd2XFb833vo7RLWcAGahXiRovU/AjyuyM2wr3VoZhUlLi
        InKkTTlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPGhS-00AF79-73; Wed, 02 Mar 2022 04:34:54 +0000
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
Subject: [PATCH 06/19] wait: Parameterize the return variable to __wait_event_freezable_timeout()
Date:   Wed,  2 Mar 2022 04:34:38 +0000
Message-Id: <20220302043451.2441320-7-willy@infradead.org>
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
 include/linux/wait.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index b34d36001fd2..5f2c43373061 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -418,7 +418,7 @@ do {										\
 	__ret;									\
 })
 
-#define __wait_event_freezable_timeout(wq_head, condition, timeout)		\
+#define __wait_event_freezable_timeout(wq_head, condition, timeout, __ret)	\
 	___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),		\
 		      TASK_INTERRUPTIBLE, 0, timeout,				\
 		      __ret = freezable_schedule_timeout(__ret))
@@ -432,7 +432,8 @@ do {										\
 	long __ret = timeout;							\
 	might_sleep();								\
 	if (!___wait_cond_timeout(condition, __ret))				\
-		__ret = __wait_event_freezable_timeout(wq_head, condition, timeout); \
+		__ret = __wait_event_freezable_timeout(wq_head,		\
+					condition, timeout, __ret);	\
 	__ret;									\
 })
 
-- 
2.34.1

