Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3900DECAAD8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 07:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiH3Hcj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiH3Hce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:32:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954C6BCC0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:32:31 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661844734t85hnxqz
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 15:31:01 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: ElntjVByhgWSdzc/QHMUUwCd3lZIH1XXkytQS3NHJzV5dA7eCUO987Pr72Msq
        QgC0i8p7NutHd3hzps4jwRJrgBKs6gpB2o+DHtckFdEJqA8EjtY0kMyceZ7h7lAHNTAzk76
        Or92g/akS8KkqC+rceYO4y/PoRXGNQIY6+Ke3l8F2Vt6cyg6XskyIay1bJ8ChZeFTKOmlso
        iH7I3KxxJatDhaS8nGsgovO9x5UKNLFdKNNKMEnY+IS1wR9gOTqLZ3ST4OS6QLvy/mtM3IV
        nU+bQ1Gf36PxeItazSCvoMJ/fvGG0gjPVCBp7m/T3/x5ez96FzljKQ7pqWgF82dC/MT9CxK
        Eg6c2b1Dug0AbIEEIkKLRYxPyiHHjevXppPGMBn
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] arm/mm: Fix comments typo
Date:   Tue, 30 Aug 2022 03:31:00 -0400
Message-Id: <20220830073100.7912-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "there" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a49f0b9c0f75..1207d431e1b4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1301,7 +1301,7 @@ static __init void prepare_page_table(void)
 	/*
 	 * Skip over the KASan shadow area. KASAN_SHADOW_END is sometimes
 	 * equal to MODULES_VADDR and then we exit the pmd clearing. If we
-	 * are using a thumb-compiled kernel, there there will be 8MB more
+	 * are using a thumb-compiled kernel, there will be 8MB more
 	 * to clear as KASan always offset to 16 MB below MODULES_VADDR.
 	 */
 	for (addr = KASAN_SHADOW_END; addr < MODULES_VADDR; addr += PMD_SIZE)
-- 
2.35.1

