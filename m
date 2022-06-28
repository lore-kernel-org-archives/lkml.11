Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B705AC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 13:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbiF1Nds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346589AbiF1NdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:33:10 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE038B846;
        Tue, 28 Jun 2022 06:33:08 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 802A2200004;
        Tue, 28 Jun 2022 13:33:00 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     krzysztof.kozlowski+dt@linaro.org, paulus@samba.org,
        mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org,
        joel@jms.id.au
Subject: [PATCH v3 10/12] powerpc: wiiu: platform support
Date:   Tue, 28 Jun 2022 23:31:42 +1000
Message-Id: <20220628133144.142185-11-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628133144.142185-1-ash@heyquark.com>
References: <20220622131037.57604-1-ash@heyquark.com>
 <20220628133144.142185-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform support for the Nintendo Wii U console.

Signed-off-by: Ash Logan <ash@heyquark.com>
Co-developed-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Signed-off-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Co-developed-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
v2->v3: Use of_platform_default_populate instead of a custom match table.

 arch/powerpc/platforms/wiiu/Makefile |  2 +-
 arch/powerpc/platforms/wiiu/setup.c  | 60 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/wiiu/setup.c

diff --git a/arch/powerpc/platforms/wiiu/Makefile b/arch/powerpc/platforms/wiiu/Makefile
index fa16c60261e6..abcb7a1beebf 100644
--- a/arch/powerpc/platforms/wiiu/Makefile
+++ b/arch/powerpc/platforms/wiiu/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_WIIU) += espresso-pic.o latte-pic.o
+obj-$(CONFIG_WIIU) += setup.o espresso-pic.o latte-pic.o
 obj-$(CONFIG_LATTEIPC_UDBG) += udbg_latteipc.o
diff --git a/arch/powerpc/platforms/wiiu/setup.c b/arch/powerpc/platforms/wiiu/setup.c
new file mode 100644
index 000000000000..e3f07ce65cad
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/setup.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Nintendo Wii U board-specific support
+ *
+ * Copyright (C) 2022 The linux-wiiu Team
+ */
+#define DRV_MODULE_NAME "wiiu"
+#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+
+#include "espresso-pic.h"
+#include "latte-pic.h"
+#include "udbg_latteipc.h"
+
+static int __init wiiu_probe(void)
+{
+	if (!of_machine_is_compatible("nintendo,wiiu"))
+		return 0;
+
+	latteipc_udbg_init();
+
+	return 1;
+}
+
+static void __noreturn wiiu_halt(void)
+{
+	for (;;)
+		cpu_relax();
+}
+
+static void __init wiiu_init_irq(void)
+{
+	espresso_pic_init();
+	latte_pic_init();
+}
+
+static int __init wiiu_device_probe(void)
+{
+	if (!machine_is(wiiu))
+		return 0;
+
+	of_platform_default_populate(NULL, NULL, NULL);
+	return 0;
+}
+device_initcall(wiiu_device_probe);
+
+define_machine(wiiu) {
+	.name = "wiiu",
+	.probe = wiiu_probe,
+	.halt = wiiu_halt,
+	.progress = udbg_progress,
+	.calibrate_decr = generic_calibrate_decr,
+	.init_IRQ = wiiu_init_irq,
+	.get_irq = espresso_pic_get_irq,
+};
-- 
2.36.1

