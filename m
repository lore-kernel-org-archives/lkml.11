Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00158C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 11:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiCBLMS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiCBLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:12:16 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80787B91D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:11:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V62RRlM_1646219481;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V62RRlM_1646219481)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Mar 2022 19:11:30 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm/damon/sysfs: Fix missing error code in damon_sysfs_attrs_add_dirs()
Date:   Wed,  2 Mar 2022 19:11:20 +0800
Message-Id: <20220302111120.24984-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-ENOMEM' to the return value 'err'.

Eliminate the follow smatch warning:

mm/damon/sysfs.c:1647 damon_sysfs_attrs_add_dirs() warn: missing error
code 'err'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 32a9d21c0db5..0eca71163924 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1643,8 +1643,10 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	attrs->intervals = intervals;
 
 	nr_regions_range = damon_sysfs_ul_range_alloc(10, 1000);
-	if (!nr_regions_range)
+	if (!nr_regions_range) {
+		err = -ENOMEM;
 		goto put_intervals_out;
+	}
 
 	err = kobject_init_and_add(&nr_regions_range->kobj,
 			&damon_sysfs_ul_range_ktype, &attrs->kobj,
-- 
2.20.1.7.g153144c

