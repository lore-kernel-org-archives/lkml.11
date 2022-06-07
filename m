Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F15C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 12:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbiFGMlS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiFGMlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:41:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52087C7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:41:02 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LHVKX4Rq1z1KCMb;
        Tue,  7 Jun 2022 20:39:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:50 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 3/6] mm: ioremap: Setup phys_addr of struct vm_struct
Date:   Tue, 7 Jun 2022 20:50:24 +0800
Message-ID: <20220607125027.44946-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show physical address of each ioremap in /proc/vmallocinfo.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/ioremap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 2d754b48d230..e1d008e8f87f 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -33,6 +33,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	if (!area)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
+	area->phys_addr = phys_addr;
 
 	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
 			       __pgprot(prot))) {
-- 
2.35.3

