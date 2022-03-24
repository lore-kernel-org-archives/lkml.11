Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E179C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 00:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346684AbiCXAJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 20:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbiCXAJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:09:12 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E0F8CCFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:07:39 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nXB0q-00055s-7h; Thu, 24 Mar 2022 01:07:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 08/14] riscv: move boot alternatives to after fill_hwcap
Date:   Thu, 24 Mar 2022 01:07:04 +0100
Message-Id: <20220324000710.575331-9-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324000710.575331-1-heiko@sntech.de>
References: <20220324000710.575331-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the application of boot alternatives to after the hw-capabilities
are populated. This allows to check for available extensions when
determining which alternatives to apply and also makes it actually
work if CONFIG_SMP is disabled for whatever reason.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/setup.c   | 2 ++
 arch/riscv/kernel/smpboot.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 339ceb595b38..b4879c942b42 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/efi.h>
 #include <linux/crash_dump.h>
 
+#include <asm/alternative.h>
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
@@ -295,6 +296,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+	apply_boot_alternatives();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index a6d13dca1403..f1e4948a4b52 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -32,7 +32,6 @@
 #include <asm/sections.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
-#include <asm/alternative.h>
 
 #include "head.h"
 
@@ -41,7 +40,6 @@ static DECLARE_COMPLETION(cpu_running);
 void __init smp_prepare_boot_cpu(void)
 {
 	init_cpu_topology();
-	apply_boot_alternatives();
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
-- 
2.35.1

