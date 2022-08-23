Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E519C3F6B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 05:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiHWFwg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 01:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiHWFwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:52:05 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC105F12B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:52:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VN0H0NZ_1661233903;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VN0H0NZ_1661233903)
          by smtp.aliyun-inc.com;
          Tue, 23 Aug 2022 13:51:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jpoimboe@kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/unwind/orc: Use swap() instead of open coding it
Date:   Tue, 23 Aug 2022 13:51:41 +0800
Message-Id: <20220823055141.18380-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./arch/x86/kernel/unwind_orc.c:217:16-17: WARNING opportunity for swap().

https://bugzilla.openanolis.cn/show_bug.cgi?id=1943
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/kernel/unwind_orc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 0ea57da92940..4569959581b1 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -201,7 +201,6 @@ static struct orc_entry *cur_orc_table = __start_orc_unwind;
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
-	struct orc_entry orc_tmp;
 	int *a = _a, *b = _b, tmp;
 	int delta = _b - _a;
 
@@ -213,9 +212,7 @@ static void orc_sort_swap(void *_a, void *_b, int size)
 	/* Swap the corresponding .orc_unwind entries: */
 	orc_a = cur_orc_table + (a - cur_orc_ip_table);
 	orc_b = cur_orc_table + (b - cur_orc_ip_table);
-	orc_tmp = *orc_a;
-	*orc_a = *orc_b;
-	*orc_b = orc_tmp;
+	swap(*orc_a, *orc_b);
 }
 
 static int orc_sort_cmp(const void *_a, const void *_b)
-- 
2.20.1.7.g153144c

