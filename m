Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5510CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 03:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiFGDbq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 23:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFGDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:31:45 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA629427E8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:31:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0B8461E80D74;
        Tue,  7 Jun 2022 11:31:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VxJoDDgVzgzL; Tue,  7 Jun 2022 11:31:24 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 261341E80D55;
        Tue,  7 Jun 2022 11:31:24 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com
Cc:     linux@armlinux.org.uk, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] arm: create_mapping function to remove unused return values
Date:   Tue,  7 Jun 2022 11:31:22 +0800
Message-Id: <20220607033122.256388-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return value to void to reduce eax register execution.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/arm/mm/kasan_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 5ad0d6c56d56..db2068329985 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -187,7 +187,7 @@ static void __init clear_pgds(unsigned long start,
 		pmd_clear(pmd_off_k(start));
 }
 
-static int __init create_mapping(void *start, void *end)
+static void __init create_mapping(void *start, void *end)
 {
 	void *shadow_start, *shadow_end;
 
@@ -199,7 +199,6 @@ static int __init create_mapping(void *start, void *end)
 
 	kasan_pgd_populate((unsigned long)shadow_start & PAGE_MASK,
 			   PAGE_ALIGN((unsigned long)shadow_end), false);
-	return 0;
 }
 
 void __init kasan_init(void)
-- 
2.18.2

