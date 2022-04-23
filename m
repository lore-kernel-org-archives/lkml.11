Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC9C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 02:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiDWCg6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 22:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiDWCgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:36:52 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DA513696A;
        Fri, 22 Apr 2022 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=huM+m
        OZR7PJhaVONZnXeurYvNfm3rx48wRZTVxQfbeE=; b=WArgwkzyovv1uu+1GkZ9P
        ox2lVvulFCAT1BKjqLBhbNq4BS6dxTfpGKYOXNCKHC3R+6qOYaHLYnOrdtHkpVZe
        +oBBLJyMExiN31vPIdfwpxXTdUC+UHUmSbonl/QtPbzitWUOtGVe9Pa292GzIg2m
        6PSOfacHggEs/fHqSt8Sfg=
Received: from localhost (unknown [119.123.75.74])
        by smtp8 (Coremail) with SMTP id DMCowACnGfR+ZWNiMUVWCg--.36859S2;
        Sat, 23 Apr 2022 10:33:34 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        adobriyan@gmail.com, fweimer@redhat.com, ddiss@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Junwen Wu <wudaemon@163.com>
Subject: [PATCH v1] proc: limit schedstate node write operation
Date:   Sat, 23 Apr 2022 02:31:04 +0000
Message-Id: <20220423023104.153004-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACnGfR+ZWNiMUVWCg--.36859S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryfKF48Kr1kAF47tF4UCFg_yoWDuFXEva
        45KaykGwsYqFn5JFW5C343Jryjva1kGrn8GayDtFyDJF4kK3sYgFWUAF9rCFWUXr1fA3Z8
        Cr4kXF93Cr15CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRu1v33UUUUU==
X-Originating-IP: [119.123.75.74]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisR7rbVXlpag8xQAAst
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whatever value is written to /proc/$pid/sched, a task's schedstate data
will reset.In some cases, schedstate will drop by accident. We restrict
writing a certain value to this node before the data is reset.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
 fs/proc/base.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7150fd..6bb2677659ce 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1459,13 +1459,21 @@ sched_write(struct file *file, const char __user *buf,
 {
 	struct inode *inode = file_inode(file);
 	struct task_struct *p;
+	char ubuf[5];
 
-	p = get_proc_task(inode);
-	if (!p)
-		return -ESRCH;
-	proc_sched_set_task(p);
+	memset(ubuf, 0, sizeof(ubuf));
+	if (count > 5)
+		count = 0;
+	if (copy_from_user(ubuf, buf, count))
+		return -EFAULT;
+	if (strcmp(ubuf, "reset") == 0) {
+		p = get_proc_task(inode);
+		if (!p)
+			return -ESRCH;
+		proc_sched_set_task(p);
 
-	put_task_struct(p);
+		put_task_struct(p);
+	}
 
 	return count;
 }
-- 
2.25.1

