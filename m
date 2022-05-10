Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 09:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiEJJ7c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiEJJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:59:27 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54192A1FEC;
        Tue, 10 May 2022 02:55:30 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 10 May
 2022 17:55:29 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 10 May
 2022 17:55:28 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: VR41xx: Drop redundant spinlock initialization
Date:   Tue, 10 May 2022 17:55:27 +0800
Message-ID: <1652176527-4507-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slot_errbuf_lock has declared and initialized by DEFINE_SPINLOCK,
so we don't need to spin_lock_init again, drop it.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/mips/vr41xx/common/cmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/vr41xx/common/cmu.c b/arch/mips/vr41xx/common/cmu.c
index b59ee5479313..e4cbe116b26d 100644
--- a/arch/mips/vr41xx/common/cmu.c
+++ b/arch/mips/vr41xx/common/cmu.c
@@ -236,8 +236,6 @@ static int __init vr41xx_cmu_init(void)
 	if (current_cpu_type() == CPU_VR4133)
 		cmuclkmsk2 = cmu_read(CMUCLKMSK2);
 
-	spin_lock_init(&cmu_lock);
-
 	return 0;
 }
 
-- 
2.7.4

