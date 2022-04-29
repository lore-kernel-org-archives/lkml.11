Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D9AC43217
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 10:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357473AbiD2KYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbiD2KYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:24:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA1F66AD5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:21:33 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqT5b0cMczfZfD;
        Fri, 29 Apr 2022 18:20:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 18:21:31 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 18:21:31 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/5] mm: ioremap: Setup phys_addr of struct vm_struct
Date:   Fri, 29 Apr 2022 18:32:22 +0800
Message-ID: <20220429103225.75121-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show physical address of each ioremap in /proc/vmallocinfo.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/ioremap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 1f9597fbcc07..7cb9996b0c12 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -32,6 +32,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
 	if (!area)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
+	area->phys_addr = phys_addr;
 
 	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, __pgprot(prot))) {
 		free_vm_area(area);
-- 
2.35.3

