Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29EC4332F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiDWNbD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiDWNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:30:58 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1497C782
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:28:01 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id iFnrnuctdAKwFiFnrnIybL; Sat, 23 Apr 2022 15:27:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Apr 2022 15:27:59 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: SGI-IP30: Free some unused memory
Date:   Sat, 23 Apr 2022 15:27:58 +0200
Message-Id: <f9475119cf8d7dc51f9f993ab6a4de40a2735ca1.1650720466.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_device_add_data() duplicates the memory it is passed. So we can
free some memory to save a few bytes that would remain unused otherwise.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/mips/sgi-ip30/ip30-xtalk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/sgi-ip30/ip30-xtalk.c b/arch/mips/sgi-ip30/ip30-xtalk.c
index 8a2894645529..8129524421cb 100644
--- a/arch/mips/sgi-ip30/ip30-xtalk.c
+++ b/arch/mips/sgi-ip30/ip30-xtalk.c
@@ -63,6 +63,8 @@ static void bridge_platform_create(int widget, int masterwid)
 	}
 	platform_device_add_resources(pdev, &w1_res, 1);
 	platform_device_add_data(pdev, wd, sizeof(*wd));
+	/* platform_device_add_data() duplicates the data */
+	kfree(wd);
 	platform_device_add(pdev);
 
 	bd = kzalloc(sizeof(*bd), GFP_KERNEL);
@@ -92,6 +94,8 @@ static void bridge_platform_create(int widget, int masterwid)
 	bd->io_offset	= IP30_SWIN_BASE(widget);
 
 	platform_device_add_data(pdev, bd, sizeof(*bd));
+	/* platform_device_add_data() duplicates the data */
+	kfree(bd);
 	platform_device_add(pdev);
 	pr_info("xtalk:%x bridge widget\n", widget);
 	return;
-- 
2.32.0

