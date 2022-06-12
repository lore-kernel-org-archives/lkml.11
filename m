Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457A1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jun 2022 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiFLEfL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 00:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLEfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:35:04 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8331A666BE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:35:03 -0700 (PDT)
From:   Yixun Lan <dlan@gentoo.org>
To:     linux-riscv@lists.infradead.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>
Subject: [PATCH] RISC-V: enable CONFIG_ARCH_KEEP_MEMBLOCK
Date:   Sun, 12 Jun 2022 12:34:33 +0800
Message-Id: <20220612043433.10469-1-dlan@gentoo.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserve the memblock info while CONFIG_DEBUG_FS is enabled.
So later, the information can be showed at:
  /sys/kernel/debug/memblock/{memory,reserved}

Signed-off-by: Yixun Lan <dlan@gentoo.org>

---
Check mm/memblock.c:2120 for the code logic:
   #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)

I've tested on unmatched board, with this patch applied
for example, we can see the memblock reserved info as:

 # cat /sys/kernel/debug/memblock/reserved
   0: 0x0000000080000000..0x000000008007ffff
   1: 0x0000000080200000..0x00000000823fffff
   2: 0x0000000088000000..0x000000008800307f
   3: 0x00000000ec000000..0x00000000ffffffff
   4: 0x000000046d600000..0x000000047edfffff
   5: 0x000000047ee2d000..0x000000047eeecfff
   6: 0x000000047eeed440..0x000000047eeed947
   7: 0x000000047eeed980..0x000000047eeede1f
   8: 0x000000047eeede40..0x000000047eeedfc7
   9: 0x000000047eeee000..0x000000047ef59fff
  10: 0x000000047ef5c000..0x000000047efdd05f
  11: 0x000000047efdd080..0x000000047efdd29f
  12: 0x000000047efdd2c0..0x000000047efdd3df
  13: 0x000000047efdd400..0x000000047efdd41f
  14: 0x000000047efdd440..0x000000047efdd44f
  15: 0x000000047efdd480..0x000000047efdd487
  16: 0x000000047efdd4c0..0x000000047efdd525
  17: 0x000000047efdd540..0x000000047efdd5a5
  18: 0x000000047efdd5c0..0x000000047ffdfa47
  19: 0x000000047ffdfa78..0x000000047ffdfaa8
  20: 0x000000047ffdfab0..0x000000047ffdfade
  21: 0x000000047ffdfae0..0x000000047ffdfb0e
  22: 0x000000047ffdfb10..0x000000047ffeeffb
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c22f58155948..e457c5855222 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,7 @@ config RISCV
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_KEEP_MEMBLOCK
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
-- 
2.35.1

