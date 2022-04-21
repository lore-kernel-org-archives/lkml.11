Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430DEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385906AbiDUM4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383849AbiDUM4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:56:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6F32ED1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:53:24 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KkcsR5G0dzhXrW;
        Thu, 21 Apr 2022 20:53:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 20:53:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <david@redhat.com>, <apopple@nvidia.com>,
        <surenb@google.com>, <minchan@kernel.org>, <peterx@redhat.com>,
        <sfr@canb.auug.org.au>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/3] A few fixup patches for mm
Date:   Thu, 21 Apr 2022 20:53:45 +0800
Message-ID: <20220421125348.62483-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few patches to avoid mapping random data if swap
read fails and fix lost swap bits in unuse_pte. Also we free hwpoison and
swapin error entry in madvise_free_pte_range. More details can be found
in the respective changelogs. Thanks!

---
v2:
  make the terminology consistent and collect Acked-by tag per David
  fix lost swap bits in unuse_pte per Peter
  free hwpoison and swapin error entry per Alistair
  Many thanks Alistair, David and Peter for review!
---
Miaohe Lin (3):
  mm/swapfile: unuse_pte can map random data if swap read fails
  mm/swapfile: Fix lost swap bits in unuse_pte()
  mm/madvise: free hwpoison and swapin error entry in
    madvise_free_pte_range

 include/linux/swap.h    |  7 ++++++-
 include/linux/swapops.h | 10 ++++++++++
 mm/madvise.c            | 13 ++++++++-----
 mm/memory.c             |  5 ++++-
 mm/swapfile.c           | 23 ++++++++++++++++++++---
 5 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.23.0

