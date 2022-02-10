Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE71C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 14:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbiBJOVf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:21:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242814AbiBJOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:21:18 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3A139
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:21:18 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jvf6405k8zbk3p;
        Thu, 10 Feb 2022 22:20:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Feb
 2022 22:21:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/8] mm/memory-failure.c: A few cleanup patches for memory failure
Date:   Thu, 10 Feb 2022 22:17:25 +0800
Message-ID: <20220210141733.1908-1-linmiaohe@huawei.com>
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

Hi,
This series contains a few patches to simplify the code logic, remove
unneeded variable and remove obsolete comment. More details can be found
in the respective changelogs. Thanks!

Miaohe Lin (8):
  mm/memory-failure.c: minor clean up for memory_failure_dev_pagemap
  mm/memory-failure.c: avoid walking page table when vma_address()
    return -EFAULT
  mm/memory-failure.c: rework the signaling logic in kill_proc
  mm/memory-failure.c: remove unneeded orig_head
  mm/memory-failure.c: remove PageSlab check in hwpoison_filter_dev
  mm/memory-failure.c: rework the try_to_unmap logic in
    hwpoison_user_mappings()
  mm/memory-failure.c: remove obsolete comment in __soft_offline_page
  mm/memory-failure.c: remove unnecessary PageTransTail check

 mm/memory-failure.c | 74 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

-- 
2.23.0

