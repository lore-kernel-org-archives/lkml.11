Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BFBC433FE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Mar 2022 15:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiCFPRw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Mar 2022 10:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiCFPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 10:17:51 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499473FBEC;
        Sun,  6 Mar 2022 07:16:57 -0800 (PST)
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     YunQiang Su <yunqiang.su@cipunited.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@opendingux.net, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH] mips: Always permit to build u-boot images
Date:   Sun,  6 Mar 2022 15:16:48 +0000
Message-Id: <20220306151648.39599-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platforms where the kernel should be loaded above 0x8000.0000 do not
support loading u-boot images, that doesn't mean that we shouldn't be
able to generate them.

Additionally, since commit 79876cc1d7b8 ("MIPS: new Kconfig option
ZBOOT_LOAD_ADDRESS"), the $(zload-y) variable was no longer hardcoded,
which made it impossible to use the uzImage.bin target.

Fixes: 79876cc1d7b8 ("MIPS: new Kconfig option ZBOOT_LOAD_ADDRESS")
Cc: <stable@vger.kernel.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e036fc025ccc..4478c5661d61 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -340,14 +340,12 @@ drivers-$(CONFIG_PM)	+= arch/mips/power/
 boot-y			:= vmlinux.bin
 boot-y			+= vmlinux.ecoff
 boot-y			+= vmlinux.srec
-ifeq ($(shell expr $(load-y) \< 0xffffffff80000000 2> /dev/null), 0)
 boot-y			+= uImage
 boot-y			+= uImage.bin
 boot-y			+= uImage.bz2
 boot-y			+= uImage.gz
 boot-y			+= uImage.lzma
 boot-y			+= uImage.lzo
-endif
 boot-y			+= vmlinux.itb
 boot-y			+= vmlinux.gz.itb
 boot-y			+= vmlinux.bz2.itb
@@ -359,9 +357,7 @@ bootz-y			:= vmlinuz
 bootz-y			+= vmlinuz.bin
 bootz-y			+= vmlinuz.ecoff
 bootz-y			+= vmlinuz.srec
-ifeq ($(shell expr $(zload-y) \< 0xffffffff80000000 2> /dev/null), 0)
 bootz-y			+= uzImage.bin
-endif
 bootz-y			+= vmlinuz.itb
 
 #
-- 
2.34.1

