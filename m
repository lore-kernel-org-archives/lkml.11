Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 09:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiE3Jat (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiE3Jar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:30:47 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450486CAB0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:30:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VEloN62_1653903037;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0VEloN62_1653903037)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 May 2022 17:30:44 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     wufengguang@huawei.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@antgroup.com>
Subject: [PATCH for vm-scalability] usemem.c: do_units: Add output before sigsuspend
Date:   Mon, 30 May 2022 17:30:36 +0800
Message-Id: <20220530093036.6926-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Zhu <teawater@antgroup.com>

It is hard to make sure that the process is waiting for the signal
without any output.
This commit add output before sigsuspend in do_units to handle this
issue.

Signed-off-by: Hui Zhu <teawater@antgroup.com>
---
 usemem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/usemem.c b/usemem.c
index 3b4d207..2f100e1 100644
--- a/usemem.c
+++ b/usemem.c
@@ -800,6 +800,8 @@ long do_units(void)
 
 	if (opt_write_signal_read) {
 		sigset_t set;
+		printf("Process %d is waiting signal\n", getpid());
+		fflush(stdout);
 		sigfillset(&set);
 		sigdelset(&set, SIGUSR1);
 		sigsuspend(&set);
-- 
1.8.3.1

