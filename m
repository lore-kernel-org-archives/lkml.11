Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1101BC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 10:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiGVKKu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:10:47 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E7FD193ED
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=naYs/
        0hvcPG1kmcd0zhyIiSbdDvvP+aOMnYV8xDrKUI=; b=PPNUMLYTVaGrOvvR+47dU
        /xTGgrK03+glV+mk7jz6zN6x5qjE0au5TAtoryrl9s2i2oyJM/2witl0ZmrS26JD
        iCVkZJOKpVdvVapMA9kYL0GKZawqlz49WxpI4+xJ7yIPfWZCCm/K2uQSD8VF1cSp
        apiXl1fE6XxjLgNZo7xTJA=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp5 (Coremail) with SMTP id HdxpCgDn7zujd9piHZy5Pg--.21851S2;
        Fri, 22 Jul 2022 18:10:45 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.orgg,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] fs: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:10:41 +0800
Message-Id: <20220722101041.80370-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgDn7zujd9piHZy5Pg--.21851S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUAr4kWrWDGw17XF1UZFb_yoW3WFg_A3
        Z7Jw4I9w4YvF1Igw47A3WSqF4Fg3yrCF15XF4rJr9Fvas5ZrsI93Z3tFWUta1rWr17GF15
        W3Zagw1rZw13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtzuX3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivwVGZFWB0j0lkQAAsX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f0f71d93e24f..f2a1aefbbce4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3070,7 +3070,7 @@ extern void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
- * Userspace may rely on the the inode number being non-zero. For example, glibc
+ * Userspace may rely on the inode number being non-zero. For example, glibc
  * simply ignores files with zero i_ino in unlink() and other places.
  *
  * As an additional complication, if userspace was compiled with
-- 
2.25.1

