Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D382C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 03:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiCGDFX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Mar 2022 22:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCGDFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:05:19 -0500
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122613F4C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:04:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V6OXvO._1646622258;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0V6OXvO._1646622258)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 11:04:19 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        joey.gouly@arm.com, mark.rutland@arm.com, akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] arm64: improve display about CPU architecture in cpuinfo
Date:   Mon,  7 Mar 2022 11:04:17 +0800
Message-Id: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, it is unsuitable for both ARMv8 and ARMv9 to show a
fixed string "CPU architecture: 8" in /proc/cpuinfo.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 330b92e..6d9b7e8 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -195,7 +195,7 @@ static int c_show(struct seq_file *m, void *v)
 
 		seq_printf(m, "CPU implementer\t: 0x%02x\n",
 			   MIDR_IMPLEMENTOR(midr));
-		seq_printf(m, "CPU architecture: 8\n");
+		seq_printf(m, "CPU architecture: aarch64\n");
 		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
 		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
 		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
-- 
1.8.3.1

