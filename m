Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7240C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 11:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiDYLQX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiDYLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:15:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EDB2A737
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:12:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kn2Q01JDsz1JBfc;
        Mon, 25 Apr 2022 19:11:20 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 19:12:11 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <iamjoonsoo.kim@lge.com>, <hch@lst.de>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 5/6] mm/vmscan: remove obsolete comment in kswapd_run
Date:   Mon, 25 Apr 2022 19:12:31 +0800
Message-ID: <20220425111232.23182-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220425111232.23182-1-linmiaohe@huawei.com>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6b700b5b3c59 ("mm/vmscan.c: remove cpu online notification
for now"), cpu online notification is removed. So kswapd won't move to
proper cpus if cpus are hot-added. Remove this obsolete comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 10ba16fdd748..db3500bd5c7d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4572,7 +4572,6 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 
 /*
  * This kswapd start function will be called by init and node-hot-add.
- * On node-hot-add, kswapd will moved to proper cpus if cpus are hot-added.
  */
 void kswapd_run(int nid)
 {
-- 
2.23.0

