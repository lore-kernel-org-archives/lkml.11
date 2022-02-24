Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B2BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 06:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiBXG16 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiBXG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:27:51 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B7827CE4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:27:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V5MmLmK_1645684037;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V5MmLmK_1645684037)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 14:27:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/mlock: Fix argument list that the kdoc format and script verified.
Date:   Thu, 24 Feb 2022 14:27:14 +0800
Message-Id: <20220224062714.27058-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warnings were found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

mm/mlock.c:225: warning: Function parameter or member 'folio' not
described in 'mlock_folio'
mm/mlock.c:225: warning: Excess function parameter 'page' description in
'mlock_folio'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/mlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index e8e4274480bf..d6294042698a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -219,7 +219,7 @@ bool need_mlock_page_drain(int cpu)
 
 /**
  * mlock_folio - mlock a folio already on (or temporarily off) LRU
- * @page: folio to be mlocked.
+ * @folio: The folio we're currently operating on.
  */
 void mlock_folio(struct folio *folio)
 {
-- 
2.20.1.7.g153144c

