Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B807C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 04:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiHOEGC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 00:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiHOEF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519725DD
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A2B6102C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF50C433C1;
        Mon, 15 Aug 2022 04:05:54 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: mm: avoid unnecessary page fault retires on shared memory types
Date:   Mon, 15 Aug 2022 12:05:54 +0800
Message-Id: <20220815040554.1455722-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d92725256b4f22d0 ("mm: avoid unnecessary page fault retires on
shared memory types") modifies do_page_fault() to handle the VM_FAULT_
COMPLETED case, but forget to change for LoongArch, so fix it as other
architectures does.

Fixes: d92725256b4f22d0 ("mm: avoid unnecessary page fault retires on shared memory types")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 605579b19a00..1ccd53655cab 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -216,6 +216,10 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		return;
 	}
 
+	/* The fault is fully completed (including releasing mmap lock) */
+	if (fault & VM_FAULT_COMPLETED)
+		return;
+
 	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
 
-- 
2.31.1

