Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 08:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354923AbiFVIjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 04:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355742AbiFVIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:38:35 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FC624E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:37:56 -0700 (PDT)
X-QQ-mid: bizesmtp67t1655887042tqj0vzir
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 16:37:12 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: G+mSt178IQq2rG8Ts3NtHlgm7fTwS95UiSRnQtvvNUdnoVFpnCBLA6SsRE1/G
        VA0jbRuLqpkmZ4vu2nMJtpHBFXI4k707Ji/OZZgyJUM3KfJGeowo7i8WYy7pJAy1BRJbKeU
        WHfvkCbgLq9FYmwbDB197E0j+Wre9TGs/gaqavCMtv5/SkL6q1EXcEW6XA9cd5ZgC+9/wk3
        wfPeT/UfY/VE78EkNDsiD5MWjFF2TVb6mFgO0LW/DyCw1EZIChxS9v941gNcG7FfI3GxGu4
        pYZlAbklepja702dqrxS9k/iYbgbLKyzvmKDWnszE3chaMntxJyFMULaSuPC1B71/R/I7UI
        KbcVg/NLHzR77w3bFy40MvNkIG0TQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] arm:kernel:Fix typo in comment
Date:   Wed, 22 Jun 2022 16:37:01 +0800
Message-Id: <20220622083701.20973-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'ARM'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/kernel/hw_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 054e9199f30d..0b3c8f2ff7b0 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -199,7 +199,7 @@ static int get_num_wrps(void)
 	 * know which watchpoint fired. In the future we can either add a
 	 * disassembler and address generation emulator, or we can insert a
 	 * check to see if the DFAR is set on watchpoint exception entry
-	 * [the ARM ARM states that the DFAR is UNKNOWN, but experience shows
+	 * [the ARM states that the DFAR is UNKNOWN, but experience shows
 	 * that it is set on some implementations].
 	 */
 	if (get_debug_arch() < ARM_DEBUG_ARCH_V7_1)
-- 
2.36.1


