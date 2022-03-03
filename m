Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 07:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiCCHyM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 02:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiCCHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:54:08 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBB416939A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:53:22 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V66qkpz_1646293999;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V66qkpz_1646293999)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 15:53:20 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs: remove repeat container_of() in damon_sysfs_kdamond_release()
Date:   Thu,  3 Mar 2022 15:53:14 +0800
Message-Id: <20220303075314.22502-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In damon_sysfs_kdamond_release(), we have use container_of() to get
"kdamond" pointer, so there no need to get it once again.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index a4ad6b473b0a..687e7c7e8dea 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2432,7 +2432,7 @@ static void damon_sysfs_kdamond_release(struct kobject *kobj)
 
 	if (kdamond->damon_ctx)
 		damon_destroy_ctx(kdamond->damon_ctx);
-	kfree(container_of(kobj, struct damon_sysfs_kdamond, kobj));
+	kfree(kdamond);
 }
 
 static struct kobj_attribute damon_sysfs_kdamond_state_attr =
-- 
2.27.0

