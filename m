Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D21AECAAD8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 06:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiHaGc1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiHaGcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:32:14 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC1BE4E7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:31:59 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661927497t1giej8p
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:31:36 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: +bXiSo2NuBf+ponRVv7AtWHT6qIyPogmQiiXaQ+j4LJkXlNaOvkERIDEpGIxs
        U6MPZZp4JG6VqsJnTOngY4wJXqUaIX2JI+CWCdQGVehxszJfbjRq0+O9HpDxPio+oh0UPeO
        ymxs/OsDQvbELlsaNWz4a+PbXt9S6EcCOcsGLMu4E2BiqZVYdwxxM+RBbl8sKOnSlkk98Rv
        yXA1kvjATF82W8O1cj4Vvc9sCpxdUlwwOSBt4fdGwdxwgI04dP046llDZQ5wzgVd14ukYdQ
        5mtjtAZN+pBMbF8oQ50CceKz0fK6igQ0jgLiaxC5wU7T1nRRvGFDMzQDL6B6U0rX86IosJv
        U6RBHKsNYuL7DQdaNJHkqvJFr8JLlpiefBpNje5MtXhHxqzLxc=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] arm: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:31:30 +0800
Message-Id: <20220831063130.13628-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/include/asm/unwind.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index b51f85417f58..5fc323586c7a 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
-- 
2.36.1

