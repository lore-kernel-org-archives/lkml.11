Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5416CC28B2B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 13:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiHPNGX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiHPNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:06:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5042608
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:06:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6WXz1YJhzlW9k;
        Tue, 16 Aug 2022 21:03:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 16 Aug
 2022 21:06:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/6] A few fixup patches for hugetlb
Date:   Tue, 16 Aug 2022 21:05:47 +0800
Message-ID: <20220816130553.31406-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few fixup patches to fix incorrect update of
max_huge_pages, fix WARN_ON(!kobj) in sysfs_create_group() and so on.
More details can be found in the respective changelogs.
Thanks!

Miaohe Lin (6):
  mm/hugetlb: fix incorrect update of max_huge_pages
  mm/hugetlb: fix WARN_ON(!kobj) in sysfs_create_group()
  mm/hugetlb: fix missing call to restore_reserve_on_error()
  mm: hugetlb_vmemmap: add missing smp_wmb() before set_pte_at()
  mm/hugetlb: fix sysfs group leak in hugetlb_unregister_node()
  mm/hugetlb: make detecting shared pte more reliable

 mm/hugetlb.c         | 46 +++++++++++++++++++++++++++-----------------
 mm/hugetlb_vmemmap.c |  5 +++++
 2 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.23.0

