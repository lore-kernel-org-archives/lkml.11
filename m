Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74651C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 08:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiEaI6D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiEaI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:58:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC4BC36;
        Tue, 31 May 2022 01:57:57 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LC5jY037SzgYTF;
        Tue, 31 May 2022 16:56:16 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 16:57:55 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <tdas@codeaurora.org>
CC:     <bjorn.andersson@linaro.org>, <agross@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: qcom: clk-rpmh: Remove redundant if statement
Date:   Tue, 31 May 2022 16:56:11 +0800
Message-ID: <20220531085611.122884-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(!ret) has been checked, so remove (ret).

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/clk/qcom/clk-rpmh.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index aed907982344..6d207f7e943d 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -207,10 +207,7 @@ static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
 	if (!ret)
 		return 0;
 
-	if (ret && enable)
-		c->state = 0;
-	else if (ret)
-		c->state = c->valid_state_mask;
+	c->state = enable ? 0 : c->valid_state_mask;
 
 	WARN(1, "clk: %s failed to %s\n", c->res_name,
 	     enable ? "enable" : "disable");
-- 
2.17.1

