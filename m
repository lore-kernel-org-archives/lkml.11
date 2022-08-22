Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C7C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 23:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiHVXVO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiHVXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:21:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C1055090;
        Mon, 22 Aug 2022 16:21:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27MNKmIo072232;
        Mon, 22 Aug 2022 18:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661210448;
        bh=5MgM4AcC0Lhor+4qBPCkkXGr/4m2H9W3ELACWQrvmRA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MNEfSSEtH7f4BD6/aQ8EmmjCtOoYkQDBfbNMg3hwfLRHAzE5TqH0Yd7jjJzKGcRM+
         FVrLrdL2mzHSHL7im7ZJlVrjrE0rGPm+xbgWEhFgd3rQT3kGjHTH2+t7zvhFd1wGMR
         KVrtXXpMRdHQvE5jrYPSmLaua0MUKJKi3cxwnJr8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27MNKmrY011826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 18:20:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 18:20:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 18:20:47 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27MNKkkS122207;
        Mon, 22 Aug 2022 18:20:47 -0500
From:   Andrew Davis <afd@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] ARM: nspire: Remove unused header file mmio.h
Date:   Mon, 22 Aug 2022 18:20:46 -0500
Message-ID: <20220822232046.1230-3-afd@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220822232046.1230-1-afd@ti.com>
References: <20220822232046.1230-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nspire boardfile platform drivers have all been converted. None
of the definitions in this header are used anymore. Remove it.

While here lets remove all the other unused headers and the file
name from in the file itself.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-nspire/mmio.h   | 13 -------------
 arch/arm/mach-nspire/nspire.c | 14 --------------
 2 files changed, 27 deletions(-)
 delete mode 100644 arch/arm/mach-nspire/mmio.h

diff --git a/arch/arm/mach-nspire/mmio.h b/arch/arm/mach-nspire/mmio.h
deleted file mode 100644
index 2ce0656139ec..000000000000
--- a/arch/arm/mach-nspire/mmio.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *	linux/arch/arm/mach-nspire/mmio.h
- *
- *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- */
-
-#define NSPIRE_PWR_PHYS_BASE		0x900B0000
-#define NSPIRE_PWR_VIRT_BASE		0xFEEB0000
-#define NSPIRE_PWR_BUS_DISABLE1		0x18
-#define NSPIRE_PWR_BUS_DISABLE2		0x20
-
-#define NSPIRE_LCD_PHYS_BASE		0xC0000000
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 1e13337972dd..2fbfc23237ff 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -1,23 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *	linux/arch/arm/mach-nspire/nspire.c
- *
  *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
-#include <linux/init.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/arm-vic.h>
-#include <linux/clkdev.h>
-#include <linux/amba/bus.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-#include <asm/mach/map.h>
-
-#include "mmio.h"
 
 static const char *const nspire_dt_match[] __initconst = {
 	"ti,nspire",
-- 
2.36.1

