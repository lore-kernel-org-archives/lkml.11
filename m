Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A45AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 23:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiERXKC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 19:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiERXKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:10:00 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B401CE632
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 16:09:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VDhLBK1_1652915395;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VDhLBK1_1652915395)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 May 2022 07:09:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     chris@zankel.net
Cc:     jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] xtensa: Return true/false (not 1/0) from bool function
Date:   Thu, 19 May 2022 07:09:53 +0800
Message-Id: <20220518230953.112266-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
function. This fixes the following warnings from coccicheck:

./arch/xtensa/kernel/traps.c:304:10-11: WARNING: return of 0/1 in
function 'check_div0' with return type bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/xtensa/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index f97d43a8d13d..0c25e035ff10 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -301,7 +301,7 @@ static bool check_div0(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 		if (copy_from_user(buf, (void __user *)regs->pc + 2, 5))
-			return 0;
+			return false;
 		p = buf;
 	} else {
 		p = (const u8 *)regs->pc + 2;
-- 
2.20.1.7.g153144c

