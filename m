Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C954C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 09:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384128AbiEBJTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 05:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384194AbiEBJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:19:10 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA56336B7C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:15:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2F643419B4;
        Mon,  2 May 2022 09:15:36 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] arm64: Set ARCH_NR_GPIO to 2048 for ARCH_APPLE
Date:   Mon,  2 May 2022 18:14:27 +0900
Message-Id: <20220502091427.28416-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're already running into the 512 GPIO limit on t600[01] depending on
how many SMC GPIOs we allocate, and a 2-die version could double that.
Let's make it 2K to be safe for now.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20ea89d9ac2f..b0da0a28aa2d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2050,6 +2050,18 @@ config STACKPROTECTOR_PER_TASK
 	def_bool y
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
 
+# The GPIO number here must be sorted by descending number. In case of
+# a multiplatform kernel, we just want the highest value required by the
+# selected platforms.
+config ARCH_NR_GPIO
+        int
+        default 2048 if ARCH_APPLE
+        default 0
+        help
+          Maximum number of GPIOs in the system.
+
+          If unsure, leave the default value.
+
 endmenu
 
 menu "Boot options"
-- 
2.35.1

