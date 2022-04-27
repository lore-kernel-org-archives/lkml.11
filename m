Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05391C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiD0MFf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiD0MFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:05:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6BE3B295
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:02:20 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KpHNr6hSFzGpNK;
        Wed, 27 Apr 2022 19:59:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:02:17 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:02:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/4] arm64: Cleanup ioremap() and support ioremap_prot()
Date:   Wed, 27 Apr 2022 20:14:09 +0800
Message-ID: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's arm64 use GENERIC_IOREMAP to cleanup code, and
support ioremap_prot()/HAVE_IOREMAP_PROT, which could
enable generic_access_phys().

Kefeng Wang (4):
  mm: ioremap: Setup phys_addr of struct vm_struct
  mm: ioremap: Add arch_ioremap/iounmap_check()
  arm64: mm: Convert to GENERIC_IOREMAP
  arm64: Add HAVE_IOREMAP_PROT support

 .../features/vm/ioremap_prot/arch-support.txt |  2 +-
 arch/arm64/Kconfig                            |  2 +
 arch/arm64/include/asm/io.h                   | 14 +--
 arch/arm64/include/asm/pgtable.h              | 10 +++
 arch/arm64/kernel/acpi.c                      |  2 +-
 arch/arm64/mm/hugetlbpage.c                   | 10 ---
 arch/arm64/mm/ioremap.c                       | 86 +++----------------
 include/asm-generic/io.h                      |  3 +
 mm/ioremap.c                                  | 21 ++++-
 9 files changed, 56 insertions(+), 94 deletions(-)

-- 
2.26.2

