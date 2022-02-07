Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED9AC4167E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 10:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350042AbiBGKjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 05:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbiBGKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:36:35 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D505C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:36:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V3qO07L_1644230187;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V3qO07L_1644230187)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 18:36:32 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     andy@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] lib/test_string.c: return -ENOMEM on memset16_selftest allocation failure
Date:   Mon,  7 Feb 2022 18:36:26 +0800
Message-Id: <20220207103626.103256-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following smatch warning:

lib/test_string.c:14 memset16_selftest() warn: returning -1 instead of
-ENOMEM is sloppy.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/test_string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_string.c b/lib/test_string.c
index 9dfd6f52de92..f23d6cd2d9c7 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -11,7 +11,7 @@ static __init int memset16_selftest(void)
 
 	p = kmalloc(256 * 2 * 2, GFP_KERNEL);
 	if (!p)
-		return -1;
+		return -ENOMEM;
 
 	for (i = 0; i < 256; i++) {
 		for (j = 0; j < 256; j++) {
-- 
2.20.1.7.g153144c

