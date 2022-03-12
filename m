Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C01C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 23:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiCLX1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 18:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiCLX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:27:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9F931A5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98472B80B27
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E1EC340F5;
        Sat, 12 Mar 2022 23:25:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nTB7O-000WdY-DG;
        Sat, 12 Mar 2022 18:25:50 -0500
Message-ID: <20220312232550.246237276@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 12 Mar 2022 18:25:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 02/12] user_events: Fix potential uninitialized pointer while parsing field
References: <20220312232525.234705244@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Ensure name is initialized by default to NULL to prevent possible edge
cases that could lead to it being left uninitialized. Add an explicit
check for NULL name to ensure edge boundaries.

Link: https://lore.kernel.org/bpf/20220224105334.GA2248@kili/
Link: https://lore.kernel.org/linux-trace-devel/20220224181637.2129-1-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2b5e9fdb63a0..9a6191a6a786 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -362,6 +362,8 @@ static int user_event_parse_field(char *field, struct user_event *user,
 	*field++ = '\0';
 	depth++;
 parse:
+	name = NULL;
+
 	while ((part = strsep(&field, " ")) != NULL) {
 		switch (depth++) {
 		case FIELD_DEPTH_TYPE:
@@ -382,7 +384,7 @@ static int user_event_parse_field(char *field, struct user_event *user,
 		}
 	}
 
-	if (depth < FIELD_DEPTH_SIZE)
+	if (depth < FIELD_DEPTH_SIZE || !name)
 		return -EINVAL;
 
 	if (depth == FIELD_DEPTH_SIZE)
-- 
2.35.1
