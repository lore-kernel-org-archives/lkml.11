Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACC0C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 10:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358908AbiCYKgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356758AbiCYKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:36:29 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51AFB6D3C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648204489;
        bh=r7MTF35xCe4CtzCMUlH4AuHMMOLVBgWolF8Nu+I39t8=;
        h=From:To:Cc:Subject:Date;
        b=e5FazAwFDmuHogT0CQVByFlmkgCsCWPZOYvLaqVkODR8iSQM+ZIW+uWrPh07cMBdx
         AhuJQm/5tZyIIaG/zy14Zf5bkR8yRmz3tqmyo1pA22krd2DY/HHdQqwNGe3SREpJ1V
         iK792qqeD4GB2gG4PeupWvBhtbHu5qzljXm7B+KA=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 6DFA0EBB; Fri, 25 Mar 2022 18:27:31 +0800
X-QQ-mid: xmsmtpt1648204051tp1m08xmo
Message-ID: <tencent_C0622B5C4209E83F1C6495D926979F239D05@qq.com>
X-QQ-XMAILINFO: OOWntbL6xj16UYjmDCYdk3zdV6AkUlVJYVXvFXwyqwiwhHIj+QucYg/rjcEuOt
         YO7j/eprBmyc4h2c06wgdcYMWSep4SXwq7n+QGxdcp6ICsFbd9yTBd2y9WzUKB2YwYvs/h8Mu+NF
         3O/awHA4MLl1CeBeM8HFfgPZWH4/vqzvwiDrMgaZ1iu7C+gGmhfen9xCWY78+E9vsdumUiwchXp4
         mJ73wtlnQeZQVQvB0aU6xAs+7niZUpJswpFFx/U+6co38r4urXkGPe7qIJSEtptS8cCk3XI76bTp
         GBE+6cG8pXUfIhIIY9a7UwUFabdQ/611P/rXY4ZbxNXiy8imWSu0q73DKFp1Msl/Pa6B+f5RKrac
         sSm5Px8sotmHtHcqLRGQL365aXb8G3bBusnZsNdweoK6RnKfba5j1ExXohhWM3FWaZVb01iUwIjO
         pT0uKiE2iQVbdhmVfWnzg2WAg+6AXI+v+dsz4HXd4ir0CpdQyG4Mib4UAQ2w64jYH+G2tUmzeiO9
         9N+Ovt6E8HcR0Tgr/s+oXNSDCJh9CgsVSGZnTQUqi93ePXrydTOfbWsoZ0bm/3w7cdnlXn6pNOF9
         40+wNNghlHZdV0tlfWByU4qL02Q62qlEokvhYrJA08qEVbWsPgtdDnFlY2pEOyogx28ge0OdJ2+m
         uVRokNyTXZOSXJFejgBRQH3MwBIxrMvlEuN81q5FUuHsBCfxmqKB3NrQcjYDGNjsWOA7q/UFbbU8
         0RgF7ducb3U9hMY0DCyV5rs3grDP+0m82+2Fxk+Bgc47ZWsWcTGnKI23eMDlfDInZFmuP8CXDGfo
         3F5LJfdBoqKuPXyuapA6uM02us/UpXvP6ex3EJV25oaVzPNcIvty5n3vPl95GMhOiXT+jqXPdXYX
         uhv4HuJcsBQ3Sq8KD4AmLy27zc0kW4D6QVRKYYc1Ma8FrYOrL8GxLkNokTZ7YcnIA0Tdh2vAxPmH
         erom5GfnM=
From:   xkernel.wang@foxmail.com
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] clk: pxa: add a check for the return value of kzalloc()
Date:   Fri, 25 Mar 2022 18:27:20 +0800
X-OQ-MSGID: <20220325102720.4155-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/clk/pxa/clk-pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index cfc79f9..d0df104 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -102,6 +102,8 @@ int __init clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks)
 
 	for (i = 0; i < nb_clks; i++) {
 		pxa_clk = kzalloc(sizeof(*pxa_clk), GFP_KERNEL);
+		if (!pxa_clk)
+			continue;
 		pxa_clk->is_in_low_power = clks[i].is_in_low_power;
 		pxa_clk->lp = clks[i].lp;
 		pxa_clk->hp = clks[i].hp;
-- 
