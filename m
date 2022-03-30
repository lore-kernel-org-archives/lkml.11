Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D349C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiC3KI2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiC3KI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:08:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B613F8F1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:06:41 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KT28p4jwGzDq8G;
        Wed, 30 Mar 2022 18:04:26 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 18:06:39 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 18:06:39 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>
Subject: [PATCH v2 0/2] fix several contiguous memmap assumptions
Date:   Wed, 30 Mar 2022 18:25:32 +0800
Message-ID: <20220330102534.1053240-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 ==> v2:
remove page_nth

It isn't true for only SPARSEMEM configs to assume that a compound page
has virtually contiguous page structs, so use nth_page to iterate each
page.

Inspired by:
https://lore.kernel.org/linux-mm/20220204195852.1751729-8-willy@infradead.org/

Chen Wandun (2):
  mm: fix contiguous memmap assumptions about split page
  mm: fix contiguous memmap assumptions about alloc/free pages

 mm/compaction.c  |  6 +++---
 mm/huge_memory.c |  2 +-
 mm/page_alloc.c  | 18 ++++++++++--------
 3 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.18.0.huawei.25

