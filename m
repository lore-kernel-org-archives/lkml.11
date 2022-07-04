Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 02:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGKCgV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Jul 2022 22:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKCgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:36:20 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951018382
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 19:36:18 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id FZV00112;
        Mon, 11 Jul 2022 10:36:12 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.9; Mon, 11 Jul 2022 10:36:12 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] mm/gup: Fix the format of hugepte_addr_end and gup_hugepte
Date:   Mon, 4 Jul 2022 08:34:58 -0400
Message-ID: <20220704123458.14583-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20227111036121ff2bfb9d32b3b82230700b216496aed
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Operators should be separated by spaces.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0fa09ac3cf2f..2fd09f0820a4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2522,7 +2522,7 @@ static int record_subpages(struct page *page, unsigned long addr,
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
 {
-	unsigned long __boundary = (addr + sz) & ~(sz-1);
+	unsigned long __boundary = (addr + sz) & ~(sz - 1);
 	return (__boundary - 1 < end - 1) ? __boundary : end;
 }
 
@@ -2536,7 +2536,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	pte_t pte;
 	int refs;
 
-	pte_end = (addr + sz) & ~(sz-1);
+	pte_end = (addr + sz) & ~(sz - 1);
 	if (pte_end < end)
 		end = pte_end;
 
-- 
2.27.0

