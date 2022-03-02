Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA61C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 04:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiCBEpf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbiCBEp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:45:27 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5361B12C7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:44:40 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6B41F100002;
        Wed,  2 Mar 2022 04:44:32 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net
Subject: [PATCH 04/12] powerpc: wiiu: introduce wiiu platform
Date:   Wed,  2 Mar 2022 15:43:58 +1100
Message-Id: <20220302044406.63401-5-ash@heyquark.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302044406.63401-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add empty platforms/wiiu for Nintendo Wii U console.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/platforms/Kconfig       | 1 +
 arch/powerpc/platforms/Makefile      | 1 +
 arch/powerpc/platforms/wiiu/Kconfig  | 5 +++++
 arch/powerpc/platforms/wiiu/Makefile | 1 +
 4 files changed, 8 insertions(+)
 create mode 100644 arch/powerpc/platforms/wiiu/Kconfig
 create mode 100644 arch/powerpc/platforms/wiiu/Makefile

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index e02d29a9d12f..7ea25ea369b4 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -22,6 +22,7 @@ source "arch/powerpc/platforms/40x/Kconfig"
 source "arch/powerpc/platforms/amigaone/Kconfig"
 source "arch/powerpc/platforms/book3s/Kconfig"
 source "arch/powerpc/platforms/microwatt/Kconfig"
+source "arch/powerpc/platforms/wiiu/Kconfig"
 
 config KVM_GUEST
 	bool "KVM Guest support"
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 94470fb27c99..944ddd938711 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
 obj-$(CONFIG_AMIGAONE)		+= amigaone/
 obj-$(CONFIG_PPC_BOOK3S)	+= book3s/
 obj-$(CONFIG_PPC_MICROWATT)	+= microwatt/
+obj-$(CONFIG_WIIU)		+= wiiu/
diff --git a/arch/powerpc/platforms/wiiu/Kconfig b/arch/powerpc/platforms/wiiu/Kconfig
new file mode 100644
index 000000000000..e5513205da3c
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config WIIU
+	bool "Nintendo Wii U"
+	depends on PPC_BOOK3S_32
diff --git a/arch/powerpc/platforms/wiiu/Makefile b/arch/powerpc/platforms/wiiu/Makefile
new file mode 100644
index 000000000000..f66554cd5c45
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0
-- 
2.35.1

