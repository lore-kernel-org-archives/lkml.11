Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42937C28B2B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354405AbiHSQxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354605AbiHSQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:51:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5956A12CDE6;
        Fri, 19 Aug 2022 09:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93495B82816;
        Fri, 19 Aug 2022 16:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E227BC433D6;
        Fri, 19 Aug 2022 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660925301;
        bh=InaW1CtemCWyOs2I41nHjCaQsp2pWF+nl0S9h5SEmyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=197ds4qFqZbY2XrtYkprKl7XhcOXqtKqeuroD9l4RElROo1ne1Z+VzTu6a7HpemWJ
         D/eO/Z//0EK6q1R++RE5VQMX435u+Ihpz7HS+rt+DCB3shs9zoPMpaOM57mi5PQ3sj
         GsRWjvllxTyqohuUyw0EXV3LtXHaMSqFIdzHO56k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.10 448/545] posix-cpu-timers: Cleanup CPU timers before freeing them during exec
Date:   Fri, 19 Aug 2022 17:43:38 +0200
Message-Id: <20220819153849.478179293@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

commit e362359ace6f87c201531872486ff295df306d13 upstream.

Commit 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a
task") started looking up tasks by PID when deleting a CPU timer.

When a non-leader thread calls execve, it will switch PIDs with the leader
process. Then, as it calls exit_itimers, posix_cpu_timer_del cannot find
the task because the timer still points out to the old PID.

That means that armed timers won't be disarmed, that is, they won't be
removed from the timerqueue_list. exit_itimers will still release their
memory, and when that list is later processed, it leads to a
use-after-free.

Clean up the timers from the de-threaded task before freeing them. This
prevents a reported use-after-free.

Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20220809170751.164716-1-cascardo@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exec.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1286,6 +1286,9 @@ int begin_new_exec(struct linux_binprm *
 	bprm->mm = NULL;
 
 #ifdef CONFIG_POSIX_TIMERS
+	spin_lock_irq(&me->sighand->siglock);
+	posix_cpu_timers_exit(me);
+	spin_unlock_irq(&me->sighand->siglock);
 	exit_itimers(me);
 	flush_itimer_signals();
 #endif


