Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63600C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 13:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiDYNaR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiDYNaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:30:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED30403F6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:27:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kn5PX0w8Yz1JBjg;
        Mon, 25 Apr 2022 21:26:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 21:26:59 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>
CC:     <ying.huang@intel.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/4] A few cleanup and fixup patches for migration
Date:   Mon, 25 Apr 2022 21:27:19 +0800
Message-ID: <20220425132723.34824-1-linmiaohe@huawei.com>
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
This series contains a few patches to remove unneeded lock page and
PageMovable check, reduce the rcu lock duration. Also we fix potential
pte_unmap on an not mapped pte. More details can be found in the
respective changelogs. Thanks!

---
v2:
  collect Reviewed-by tag
  make isolate_huge_page consistent with isolate_lru_page
  add hugetlbfs variant of hugetlb_migration_entry_wait
v1:
  rebase [1] on mainline.

[1] https://lore.kernel.org/lkml/20220304093409.25829-2-linmiaohe@huawei.com/T/
---
Miaohe Lin (4):
  mm/migration: reduce the rcu lock duration
  mm/migration: remove unneeded lock page and PageMovable check
  mm/migration: return errno when isolate_huge_page failed
  mm/migration: fix potential pte_unmap on an not mapped pte

 include/linux/hugetlb.h |  6 +++---
 include/linux/swapops.h | 12 ++++++++----
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 15 +++++++--------
 mm/memory-failure.c     |  2 +-
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            | 39 +++++++++++++++++++++++++--------------
 7 files changed, 46 insertions(+), 32 deletions(-)

-- 
2.23.0

