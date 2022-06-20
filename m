Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B9C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 21:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbiFTVce (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiFTVc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:32:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9813CFE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8519B81645
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC4EC341CD;
        Mon, 20 Jun 2022 21:32:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1o3P0Q-003o2v-M3;
        Mon, 20 Jun 2022 17:32:22 -0400
Message-ID: <20220620213222.521941315@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 20 Jun 2022 17:32:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gautam Menghani <gautammenghani201@gmail.com>
Subject: [for-linus][PATCH 4/4] tracing/uprobes: Remove unwanted initialization in
 __trace_uprobe_create()
References: <20220620213158.468216113@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gautam Menghani <gautammenghani201@gmail.com>

Remove the unwanted initialization of variable 'ret'. This fixes the clang
scan warning: Value stored to 'ret' is never read [deadcode.DeadStores]

Link: https://lkml.kernel.org/r/20220612144232.145209-1-gautammenghani201@gmail.com

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9711589273cd..c3dc4f859a6b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -546,7 +546,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	bool is_return = false;
 	int i, ret;
 
-	ret = 0;
 	ref_ctr_offset = 0;
 
 	switch (argv[0][0]) {
-- 
2.35.1
