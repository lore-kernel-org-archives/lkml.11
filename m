Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A5C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 08:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiCSIjp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Mar 2022 04:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiCSIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:39:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003C2BE2D2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:38:15 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KLDkf1tpXzfYxR;
        Sat, 19 Mar 2022 16:36:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Mar
 2022 16:38:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <mike.kravetz@oracle.com>,
        <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v4 0/2] A few fixup patches for memory failure
Date:   Sun, 20 Mar 2022 13:13:32 +0800
Message-ID: <20220320051334.44502-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

Hi everyone,
This series contains a patch to avoid calling invalidate_inode_page()
with unexpected pages and another one to make non-LRU movable pages
unhandlable. More details can be found in the respective changelogs.
Thanks!

---
v3->v4:
  fix typo and drop "bool movable" per David. Thanks David.
v2->v3:
  drop patch "mm/memory-failure.c: fix race with changing page compound again"
  collect reviewed-by and acked-by tag
  fix stale commit id in the commit log
v1->v2:
  drop "mm/memory-failure.c: fix wrong user reference report"
  make non-LRU movable pages unhandlable
  fix confusing commit log and introduce MF_MSG_DIFFERENT_PAGE_SIZE
  Many thanks Naoya, Mike and Yang Shi for review!
---

Miaohe Lin (2):
  mm/memory-failure.c: avoid calling invalidate_inode_page() with
    unexpected pages
  mm/memory-failure.c: make non-LRU movable pages unhandlable

 mm/memory-failure.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.23.0

