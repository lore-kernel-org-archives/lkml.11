Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 09:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245750AbiFJJrF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiFJJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:46:58 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE73E288D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:46:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VFyr1cm_1654854401;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VFyr1cm_1654854401)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 17:46:50 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] freevxfs: Describe 'mapping' parameter of vxfs_get_page()
Date:   Fri, 10 Jun 2022 17:46:39 +0800
Message-Id: <20220610094639.30906-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one warning found by running scripts/kernel-doc, which is caused
by using 'make W=1':

fs/freevxfs/vxfs_subr.c:45: warning: Function parameter or member 'mapping' not described in 'vxfs_get_page'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/freevxfs/vxfs_subr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index c99282df7761..e2e337b415b3 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -30,8 +30,8 @@ vxfs_put_page(struct page *pp)
 }
 
 /**
- * vxfs_get_page - read a page into memory.
- * @ip:		inode to read from
+ * vxfs_get_page() - read a page into memory.
+ * @mapping:    logical to physical mapping to use
  * @n:		page number
  *
  * Description:
-- 
2.20.1.7.g153144c

