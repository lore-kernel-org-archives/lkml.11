Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8099C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 03:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376846AbiEMDiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 23:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbiEMDhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:37:53 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25CC1DA71
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:37:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VD1NsHJ_1652413066;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VD1NsHJ_1652413066)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 May 2022 11:37:47 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/2] Implement arm64 specific huge_ptep_get()
Date:   Fri, 13 May 2022 11:37:33 +0800
Message-Id: <cover.1652411252.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As Mike pointed out [1], the huge_ptep_get() will only return one specific
pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
size hugetlb page for those functions that want to check the dirty or
young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
will also get inaccurate access statistics.

To fix this issue, this patch set introduces an ARM64 specific huge_ptep_get()
implementation, which will take into account any subpages' dirty or young bits.

[1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/

Changes from v1:
 - Rebase on next-20220512.
 - Update commit message suggested by Muchun.
 - Add reviewed tag from Muchun.

Changes from RFC:
 - Implement arm64 specific huge_ptep_get() instead of introducing a new interface.
 - Add a new patch to convert huge_ptep_get() in hugetlbpage.c

Baolin Wang (2):
  arm64/hugetlb: Use ptep_get() to get the pte value of a huge page
  arm64/hugetlb: Implement arm64 specific huge_ptep_get()

 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 32 ++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
1.8.3.1

