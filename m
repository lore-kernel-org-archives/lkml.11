Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F5C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 12:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiC2MxO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiC2MxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:53:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9E659E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:50:51 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSTpZ4sXwzBrg5;
        Tue, 29 Mar 2022 20:46:46 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 20:50:49 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 20:50:48 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH 0/2] fix several contiguous memmap assumptions
Date:   Tue, 29 Mar 2022 21:09:26 +0800
Message-ID: <20220329130928.266323-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't true for only SPARSEMEM configs to assume that a compound page
has virtually contiguous page structs, so use nth_page to iterate each
page.

Inspired by:
https://lore.kernel.org/linux-mm/20220204195852.1751729-8-willy@infradead.org/

Chen Wandun (2):
  mm: fix contiguous memmap assumptions about split page
  mm: fix contiguous memmap assumptions about alloc/free pages

 include/linux/mm.h |  2 ++
 mm/compaction.c    |  6 +++---
 mm/huge_memory.c   |  2 +-
 mm/page_alloc.c    | 14 ++++++++------
 4 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.18.0.huawei.25

