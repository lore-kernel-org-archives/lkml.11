Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5E9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 01:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352745AbiCQBmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 21:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiCQBmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:42:03 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5110FE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:40:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V7PClT8_1647481244;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7PClT8_1647481244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:40:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     arve@android.com
Cc:     tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, hridya@google.com, surenb@google.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] binder: Fix some kernel-doc comments
Date:   Thu, 17 Mar 2022 09:40:42 +0800
Message-Id: <20220317014042.126282-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/android/binder.c:1155: warning: expecting prototype for
binder_dec_ref(). Prototype was for binder_dec_ref_olocked() instead
drivers/android/binder.c:2683: warning: Function parameter or member
'procp' not described in 'binder_get_node_refs_for_txn'
drivers/android/binder.c:2683: warning: Excess function parameter 'proc'
description in 'binder_get_node_refs_for_txn'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..65e8145e6170 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1143,7 +1143,7 @@ static int binder_inc_ref_olocked(struct binder_ref *ref, int strong,
 }
 
 /**
- * binder_dec_ref() - dec the ref for given handle
+ * binder_dec_ref_olocked() - dec the ref for given handle
  * @ref:	ref to be decremented
  * @strong:	if true, strong decrement, else weak
  *
@@ -2658,7 +2658,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 /**
  * binder_get_node_refs_for_txn() - Get required refs on node for txn
  * @node:         struct binder_node for which to get refs
- * @proc:         returns @node->proc if valid
+ * @procp:         returns @node->proc if valid
  * @error:        if no @proc then returns BR_DEAD_REPLY
  *
  * User-space normally keeps the node alive when creating a transaction
-- 
2.20.1.7.g153144c

