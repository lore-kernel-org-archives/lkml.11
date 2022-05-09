Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89A4C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 09:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiEIJct (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiEIJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:26:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF571C15E2;
        Mon,  9 May 2022 02:22:25 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxbGd0bHWzGphT;
        Mon,  9 May 2022 17:19:37 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 17:22:23 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <mturquette@baylibre.com>
Subject: [PATCH] clk: fixed-rate: Remove redundant if statement
Date:   Mon, 9 May 2022 17:21:02 +0800
Message-ID: <20220509092102.140520-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(np) is always true when (dev || !np) is false, so just remove
the check.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/clk/clk-fixed-rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 45501637705c..ac68a6b40f0e 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -87,7 +87,7 @@ struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 	hw = &fixed->hw;
 	if (dev || !np)
 		ret = clk_hw_register(dev, hw);
-	else if (np)
+	else
 		ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(fixed);
-- 
2.17.1

