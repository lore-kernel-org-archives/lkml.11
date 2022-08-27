Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E171ECAAD5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 02:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbiH0CIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 22:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbiH0CIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:08:15 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18104C0B5E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:08:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id B0F004076272;
        Sat, 27 Aug 2022 02:08:11 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v6 5/5] x86/boot: Remove no longer needed includes
Date:   Sat, 27 Aug 2022 05:08:10 +0300
Message-Id: <cdd5dd2dd869f6440296aad900a6780d49bf4c55.1661565218.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661565218.git.baskov@ispras.ru>
References: <cover.1661565218.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/incldue/asm/shared/cmdline.h header already provides
COMMAND_LINE_SIZE definition.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/ident_map_64.c | 4 ----
 arch/x86/boot/compressed/kaslr.c        | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d4a314cc50d6..fdfe0e5f5cb0 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -33,10 +33,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 4a3f223973f4..39e455c105a7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -31,10 +31,6 @@
 #include <linux/ctype.h>
 #include <generated/utsrelease.h>
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Simplified build-specific string for starting entropy. */
-- 
2.37.2

