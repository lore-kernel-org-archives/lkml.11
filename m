Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ACBC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 04:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiCBEq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbiCBEqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:46:09 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A4B12C0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:45:23 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2722E100009;
        Wed,  2 Mar 2022 04:45:14 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net
Subject: [PATCH 12/12] powerpc: wiiu: Add minimal default config
Date:   Wed,  2 Mar 2022 15:44:06 +1100
Message-Id: <20220302044406.63401-13-ash@heyquark.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302044406.63401-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bare-minimum config to get a kernel compiled. Will need some more
interesting options once a storage device to boot from is added.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/configs/wiiu_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/powerpc/configs/wiiu_defconfig

diff --git a/arch/powerpc/configs/wiiu_defconfig b/arch/powerpc/configs/wiiu_defconfig
new file mode 100644
index 000000000000..a761ebcdd9f2
--- /dev/null
+++ b/arch/powerpc/configs/wiiu_defconfig
@@ -0,0 +1,7 @@
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
+CONFIG_WIIU=y
+# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
+CONFIG_HIGHMEM=y
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_PPC_EARLY_DEBUG=y
-- 
2.35.1

