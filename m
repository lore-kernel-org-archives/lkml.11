Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA00CCA479
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 09:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiFYJdu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiFYJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:33:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575530572
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:33:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LVTJm00TJz1KCBw;
        Sat, 25 Jun 2022 17:31:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 17:33:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <ying.huang@intel.com>,
        <songmuchun@bytedance.com>, <quic_qiancai@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 0/2] A few cleanup and fixup patches for swap
Date:   Sat, 25 Jun 2022 17:33:44 +0800
Message-ID: <20220625093346.48894-1-linmiaohe@huawei.com>
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

Hi everyone,
This series contains a cleaup patch to remove unneeded swap_cache_info
statistics, and a bugfix patch to avoid data races of inuse_pages. More
details can be found in the respective changelogs. Thanks!

---
v3:
  rebase on linux-next-20220624
  drop patch 1/3 per Huang, Ying
  collect Reviewed-by tag per David, Muchun, Acked-by tag per Huang, Ying
  use WRITE_ONCE to pair with READ_ONCE in patch 2/3
v2:
  collect Reviewed-by tag per David
  drop patch "mm/swapfile: avoid confusing swap cache statistics"
  add a new patch to remove swap_cache_info statistics per David
  Many thanks David for review and comment.
---
Miaohe Lin (2):
  mm/swapfile: fix possible data races of inuse_pages
  mm/swap: remove swap_cache_info statistics

 mm/swap_state.c | 17 -----------------
 mm/swapfile.c   |  8 ++++----
 2 files changed, 4 insertions(+), 21 deletions(-)

-- 
2.23.0

