Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12380C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiEaJrd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiEaJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:47:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1A748E5E;
        Tue, 31 May 2022 02:47:25 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LC6qZ1gDDzjX4V;
        Tue, 31 May 2022 17:46:34 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 17:47:23 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <quic_tdas@quicinc.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: qcom: clk-rpmh: Fix if statement to match comment
Date:   Tue, 31 May 2022 17:45:39 +0800
Message-ID: <20220531094539.252642-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(c->state) is u32, (enable) is bool. It returns false when
(c->state) > 1 and (enable) is true. Convert (c->state) to bool.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/clk/qcom/clk-rpmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index aed907982344..851e127432a9 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -196,7 +196,7 @@ static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
 	int ret;
 
 	/* Nothing required to be done if already off or on */
-	if (enable == c->state)
+	if (enable == !!c->state)
 		return 0;
 
 	c->state = enable ? c->valid_state_mask : 0;
-- 
2.17.1

