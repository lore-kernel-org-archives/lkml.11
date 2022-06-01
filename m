Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 12:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiFAMXn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346708AbiFAMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:23:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2783A3B3E2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:23:28 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LCpDC2Bw4z1K9BD;
        Wed,  1 Jun 2022 20:21:47 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 20:23:27 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 20:23:26 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH 4/4] mm/shmem: rework calculation of inflated_addr in shmem_get_unmapped_area
Date:   Wed, 1 Jun 2022 20:44:17 +0800
Message-ID: <20220601124417.2872001-5-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601124417.2872001-1-chenwandun@huawei.com>
References: <20220601124417.2872001-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function shmem_get_unmapped_area, inflated_offset and offset
are unsigned long, it will result in underflow when offset below
inflated_offset, a little confusing, no functional change.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/shmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ca04f3975a8a..f12163bd0f69 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2201,9 +2201,12 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 		return addr;
 
 	inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);
-	inflated_addr += offset - inflated_offset;
-	if (inflated_offset > offset)
+	if (offset > inflated_offset)
+		inflated_addr += offset - inflated_offset;
+	else if (offset < inflated_offset) {
+		inflated_addr -= inflated_offset - offset;
 		inflated_addr += HPAGE_PMD_SIZE;
+	}
 
 	if (inflated_addr > TASK_SIZE - len)
 		return addr;
-- 
2.25.1

