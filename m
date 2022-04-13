Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40091C43217
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 08:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiDMISj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiDMISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:18:37 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A74AE27;
        Wed, 13 Apr 2022 01:16:16 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 13 Apr
 2022 16:16:15 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 13 Apr
 2022 16:16:14 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
Date:   Wed, 13 Apr 2022 16:16:12 +0800
Message-ID: <1649837773-3501-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this issue by freeing the cpg when exiting the function in the
error/normal path.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: free both cpg&clks

 drivers/clk/renesas/clk-r8a73a4.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/clk-r8a73a4.c b/drivers/clk/renesas/clk-r8a73a4.c
index cfed11c659d9..5a8d976f49e0 100644
--- a/drivers/clk/renesas/clk-r8a73a4.c
+++ b/drivers/clk/renesas/clk-r8a73a4.c
@@ -215,7 +215,7 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
 
 	cpg->reg = of_iomap(np, 0);
 	if (WARN_ON(cpg->reg == NULL))
-		return;
+		goto out_free_cpg;
 
 	for (i = 0; i < num_clks; ++i) {
 		const char *name;
@@ -233,6 +233,9 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+out_free_cpg:
+	kfree(cpg);
+	kfree(clks);
 }
 CLK_OF_DECLARE(r8a73a4_cpg_clks, "renesas,r8a73a4-cpg-clocks",
 	       r8a73a4_cpg_clocks_init);
-- 
2.7.4

