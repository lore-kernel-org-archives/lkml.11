Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9439CECAAD5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 12:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiH2MLe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiH2MLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:11:00 -0400
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C780344;
        Mon, 29 Aug 2022 04:56:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNeBTl8_1661773934;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VNeBTl8_1661773934)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 19:52:15 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] seq_file: use iov_iter_ubuf() to simplify the code
Date:   Mon, 29 Aug 2022 19:52:12 +0800
Message-Id: <20220829115212.4006109-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use iov_iter_ubuf() instead of iov_iter_init() to simplify the code

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 fs/seq_file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 9456a2032224..6af66161576a 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -150,13 +150,12 @@ static int traverse(struct seq_file *m, loff_t offset)
  */
 ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 {
-	struct iovec iov = { .iov_base = buf, .iov_len = size};
 	struct kiocb kiocb;
 	struct iov_iter iter;
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, file);
-	iov_iter_init(&iter, READ, &iov, 1, size);
+	iov_iter_ubuf(&iter, READ, buf, size);
 
 	kiocb.ki_pos = *ppos;
 	ret = seq_read_iter(&kiocb, &iter);
-- 
2.17.1

