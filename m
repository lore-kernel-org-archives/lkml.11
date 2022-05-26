Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFDFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 22:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349377AbiEZWyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 18:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbiEZWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA81E8B8F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22AE361C32
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF07C341C7;
        Thu, 26 May 2022 22:54:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nuMN6-002Tgb-QN;
        Thu, 26 May 2022 18:54:24 -0400
Message-ID: <20220526225424.651461970@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 18:53:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 5/6] rtla: Fix __set_sched_attr error message
References: <20220526225345.068997320@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

rtla's function __set_sched_attr() was borrowed from stalld, but I
forgot to update the error message to something meaningful for rtla.

 Update the error message from:
        boost_with_deadline failed to boost pid PID: STRERROR
 to a proper one:
        Failed to set sched attributes to the pid PID: STRERROR

Link: https://lkml.kernel.org/r/a2d19b2c53f6512aefd1ee7f8c1bd19d4fc8b99d.1651247710.git.bristot@kernel.org
Link: https://lore.kernel.org/r/eeded730413e7feaa13f946924bcf2cbf7dd9561.1650617571.git.bristot@kernel.org/

Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index da2b590edaed..3bd6f64780cf 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -255,7 +255,7 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
 
 	retval = sched_setattr(pid, attr, flags);
 	if (retval < 0) {
-		err_msg("boost_with_deadline failed to boost pid %d: %s\n",
+		err_msg("Failed to set sched attributes to the pid %d: %s\n",
 			pid, strerror(errno));
 		return 1;
 	}
-- 
2.35.1
