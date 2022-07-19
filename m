Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 11:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiGSLwu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGSLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:52:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E8624097
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:52:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LnHHM0Tk0zFq9R;
        Tue, 19 Jul 2022 19:51:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 19:52:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mempolicy: remove unneeded out label
Date:   Tue, 19 Jul 2022 19:52:33 +0800
Message-ID: <20220719115233.6706-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use unlock label to unlock ptl and return ret directly to remove the
unneeded out label and reduce the size of mempolicy.o. No functional change
intended.

[Before]
   text	   data	    bss	    dec	    hex	filename
  26702	   3972	   6168	  36842	   8fea	mm/mempolicy.o

[After]
   text	   data	    bss	    dec	    hex	filename
  26662	   3972	   6168	  36802	   8fc2	mm/mempolicy.o

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mempolicy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index dc74239d1ac7..6c27acb6cd63 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -466,9 +466,8 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	}
 	page = pmd_page(*pmd);
 	if (is_huge_zero_page(page)) {
-		spin_unlock(ptl);
 		walk->action = ACTION_CONTINUE;
-		goto out;
+		goto unlock;
 	}
 	if (!queue_pages_required(page, qp))
 		goto unlock;
@@ -485,7 +484,6 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 		ret = -EIO;
 unlock:
 	spin_unlock(ptl);
-out:
 	return ret;
 }
 
-- 
2.23.0

