Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386F7C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jan 2022 03:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbiA2DrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jan 2022 22:47:03 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35881 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238931AbiA2DrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:47:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V35.M-4_1643428014;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V35.M-4_1643428014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 11:47:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm/vmalloc.c: Fix "unused function" warning
Date:   Sat, 29 Jan 2022 11:46:52 +0800
Message-Id: <20220129034652.75359-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compute_subtree_max_size() is unused, when building with
DEBUG_AUGMENT_PROPAGATE_CHECK=y.

mm/vmalloc.c:785:1: warning: unused function 'compute_subtree_max_size'
[-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/vmalloc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 028ce2b9bbf9..42d37b4bd351 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -778,17 +778,6 @@ get_subtree_max_size(struct rb_node *node)
 	return va ? va->subtree_max_size : 0;
 }
 
-/*
- * Gets called when remove the node and rotate.
- */
-static __always_inline unsigned long
-compute_subtree_max_size(struct vmap_area *va)
-{
-	return max3(va_size(va),
-		get_subtree_max_size(va->rb_node.rb_left),
-		get_subtree_max_size(va->rb_node.rb_right));
-}
-
 RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
 	struct vmap_area, rb_node, unsigned long, subtree_max_size, va_size)
 
@@ -978,6 +967,17 @@ unlink_va(struct vmap_area *va, struct rb_root *root)
 }
 
 #if DEBUG_AUGMENT_PROPAGATE_CHECK
+/*
+ * Gets called when remove the node and rotate.
+ */
+static __always_inline unsigned long
+compute_subtree_max_size(struct vmap_area *va)
+{
+	return max3(va_size(va),
+		get_subtree_max_size(va->rb_node.rb_left),
+		get_subtree_max_size(va->rb_node.rb_right));
+}
+
 static void
 augment_tree_propagate_check(void)
 {
-- 
2.20.1.7.g153144c

