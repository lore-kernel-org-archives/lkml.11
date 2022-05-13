Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C9AC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 06:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377511AbiEMGzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377491AbiEMGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:55:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FAF2A3749;
        Thu, 12 May 2022 23:55:33 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kzzsx3YygzgYlc;
        Fri, 13 May 2022 14:55:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 14:55:31 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH v2 -next] net: hinic: add missing destroy_workqueue in hinic_pf_to_mgmt_init
Date:   Fri, 13 May 2022 15:09:22 +0800
Message-ID: <20220513070922.3278070-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hinic_pf_to_mgmt_init misses destroy_workqueue in error path,
this patch fixes that.

Fixes: 6dbb89014dc3 ("hinic: fix sending mailbox timeout in aeq event work")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
v1->v2: add Fixes tag
 drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c
index ebc77771f5da..4aa1f433ed24 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c
@@ -643,6 +643,7 @@ int hinic_pf_to_mgmt_init(struct hinic_pf_to_mgmt *pf_to_mgmt,
 	err = alloc_msg_buf(pf_to_mgmt);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to allocate msg buffers\n");
+		destroy_workqueue(pf_to_mgmt->workq);
 		hinic_health_reporters_destroy(hwdev->devlink_dev);
 		return err;
 	}
@@ -650,6 +651,7 @@ int hinic_pf_to_mgmt_init(struct hinic_pf_to_mgmt *pf_to_mgmt,
 	err = hinic_api_cmd_init(pf_to_mgmt->cmd_chain, hwif);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to initialize cmd chains\n");
+		destroy_workqueue(pf_to_mgmt->workq);
 		hinic_health_reporters_destroy(hwdev->devlink_dev);
 		return err;
 	}
--
2.31.1

