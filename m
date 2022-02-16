Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC36C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 19:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiBPTB7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:01:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiBPTB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:01:57 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEAF14012
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:01:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645038100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KdJNhqvT10fpX2TPTtNinLyaEIbw3AI3xc8h9ebWAy4=;
        b=cCAtLRxWwCZC99tDT8BMawYtJ0xaVEtPQkTx9SmYLx0XK02F59/j9/qSTpUrBIJDlISYDe
        qL4qYxiG7k+mmkWi7pzeYTNtdIH8HGLmqW2aZssgEvahVG+b+xkYZqdaWxl8PQP/bbQpJB
        q8MZO6RSO/5D+5K7dmr0cz1j9ilLQuw=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] kasan: print virtual mapping info in reports
Date:   Wed, 16 Feb 2022 20:01:37 +0100
Message-Id: <5b120f7cadcc0e0d8d5f41fd0cff35981b3f7f3a.1645038022.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Print virtual mapping range and its creator in reports affecting virtual
mappings.

Also get physical page pointer for such mappings, so page information
gets printed as well.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Note: no need to merge this patch into any of the KASAN vmalloc patches
that are already in mm, better to keep it separate.
---
 mm/kasan/report.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 137c2c0b09db..8002fb3c417d 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -260,8 +260,18 @@ static void print_address_description(void *addr, u8 tag)
 		pr_err(" %pS\n", addr);
 	}
 
+	if (is_vmalloc_addr(addr)) {
+		struct vm_struct *va = find_vm_area(addr);
+
+		pr_err("The buggy address belongs to the virtual mapping at\n"
+		       " [%px, %px) created by:\n"
+		       " %pS\n", va->addr, va->addr + va->size, va->caller);
+
+		page = vmalloc_to_page(page);
+	}
+
 	if (page) {
-		pr_err("The buggy address belongs to the page:\n");
+		pr_err("The buggy address belongs to the physical page:\n");
 		dump_page(page, "kasan: bad access detected");
 	}
 
-- 
2.25.1

