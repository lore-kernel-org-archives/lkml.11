Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67950C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiCVO2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiCVO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:27:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB32B241
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:25:51 -0700 (PDT)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KNDKx2LLzzcbFF;
        Tue, 22 Mar 2022 22:25:41 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 22:25:48 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 22:25:47 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v2 0/4]mm: page_table_check: add support on arm64 and riscv
Date:   Tue, 22 Mar 2022 14:44:43 +0000
Message-ID: <20220322144447.3563146-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page table check performs extra verifications at the time when new
pages become accessible from the userspace by getting their page
table entries (PTEs PMDs etc.) added into the table. It is supported
on X86[1].

This patchset made some simple changes and make it easier to support
new architecture, then we support this feature on ARM64 and RISCV.

[1]https://lore.kernel.org/lkml/20211123214814.3756047-1-pasha.tatashin@soleen.com/

v1 -> v2:
  1. Fix arm64's pte/pmd/pud_user_accessible_page() according to the the
     suggestions of Catalin.
  2. Also fix riscv's pte_pmd_pud_user_accessible_page(). 

Kefeng Wang (2):
  mm: page_table_check: move pxx_user_accessible_page into x86
  arm64: mm: add support for page table check

Tong Tiangen (2):
  mm: page_table_check: add hooks to public helpers
  riscv: mm: add support for page table check

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 65 ++++++++++++++++++++++++---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/pgtable.h | 77 +++++++++++++++++++++++++++++---
 arch/x86/include/asm/pgtable.h   | 29 +++++++-----
 include/linux/pgtable.h          | 27 +++++++----
 mm/page_table_check.c            | 25 ++++-------
 7 files changed, 179 insertions(+), 46 deletions(-)

-- 
2.18.0.huawei.25

