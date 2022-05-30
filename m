Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2241AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 11:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbiE3LaY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 07:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiE3LaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:30:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9687E1F8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:30:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBY7d1DzYzgYTZ;
        Mon, 30 May 2022 19:28:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 19:30:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <peterx@redhat.com>, <apopple@nvidia.com>, <ying.huang@intel.com>,
        <osalvador@suse.de>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 0/4] A few cleanup and fixup patches for migration
Date:   Mon, 30 May 2022 19:30:12 +0800
Message-ID: <20220530113016.16663-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
v4:
  collect Reviewed-by tag of Oscar.
  fix build error reported by kernel test robot.
v3:
[PATCH 1/4] mm/migration: reduce the rcu lock duration
  add the analysis that the original race condition isn't possible now
  alsoreduce the rcu lock duration in kernel_migrate_pages
[PATCH 2/4] mm/migration: remove unneeded lock page and PageMovable check
  let free_pages_prepare() clear PG_isolated for us
[PATCH 3/4] mm/migration: return errno when isolate_huge_page failed
  rename isolate_huge_page to isolate_hugetlb
[PATCH 4/4] mm/migration: fix potential pte_unmap on an not mapped pte
  collect Reviewed-by tag
v2:
  collect Reviewed-by tag
  make isolate_huge_page consistent with isolate_lru_page
  add hugetlbfs variant of hugetlb_migration_entry_wait
v1:
  rebase [1] on mainline.

[1] https://lore.kernel.org/lkml/20220304093409.25829-2-linmiaohe@huawei.com/T/
---

Miaohe Lin (4):
  mm: reduce the rcu lock duration
  mm/migration: remove unneeded lock page and PageMovable check
  mm/migration: return errno when isolate_huge_page failed
  mm/migration: fix potential pte_unmap on an not mapped pte

 include/linux/hugetlb.h |  6 +++---
 include/linux/swapops.h | 12 ++++++++----
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 15 +++++++--------
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  5 ++---
 mm/migrate.c            | 42 +++++++++++++++++++++++++----------------
 8 files changed, 49 insertions(+), 37 deletions(-)

-- 
2.23.0

