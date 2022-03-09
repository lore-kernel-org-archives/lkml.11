Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 06:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiCIG4e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 01:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIG4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:56:33 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7704B161112
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:55:32 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Mar 2022 15:55:30 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B1C8D2006F55;
        Wed,  9 Mar 2022 15:55:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 9 Mar 2022 15:55:30 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E5EA2C1E22;
        Wed,  9 Mar 2022 15:55:29 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        stable@vger.kernel.org
Subject: [PATCH] clk: uniphier: Fix fixed-rate initialization
Date:   Wed,  9 Mar 2022 15:55:18 +0900
Message-Id: <1646808918-30899-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed-rate clocks in UniPhier don't have any parent clocks, however,
initial data "init.flags" isn't initialized, so it might be determined
that there is a parent clock for fixed-rate clock.

This sets init.flags to zero as initialization.

Cc: <stable@vger.kernel.org>
Fixes: 734d82f4a678 ("clk: uniphier: add core support code for UniPhier clock driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-fixed-rate.c b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
index 5319cd380480..3bc55ab75314 100644
--- a/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
+++ b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
@@ -24,6 +24,7 @@ struct clk_hw *uniphier_clk_register_fixed_rate(struct device *dev,
 
 	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
+	init.flags = 0;
 	init.parent_names = NULL;
 	init.num_parents = 0;
 
-- 
2.7.4

