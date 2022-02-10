Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E12BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 09:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiBJJSX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:18:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiBJJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:18:21 -0500
X-Greylist: delayed 1071 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 01:18:22 PST
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1084F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:18:22 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JvVwG6mpwz1FD5t;
        Thu, 10 Feb 2022 16:56:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 17:00:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Feb
 2022 17:00:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <op-tee@lists.trustedfirmware.org>
CC:     <jens.wiklander@linaro.org>, <sumit.garg@linaro.org>
Subject: [PATCH -next] tee: optee: fix error return code in probe function
Date:   Thu, 10 Feb 2022 17:10:53 +0800
Message-ID: <20220210091053.2045809-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If teedev_open() fails, probe function need return
error code.

Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/tee/optee/ffa_abi.c | 4 +++-
 drivers/tee/optee/smc_abi.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f2bf6c61197f..f744ab15bf2c 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -869,8 +869,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	optee_supp_init(&optee->supp);
 	ffa_dev_set_drvdata(ffa_dev, optee);
 	ctx = teedev_open(optee->teedev);
-	if (IS_ERR(ctx))
+	if (IS_ERR(ctx)) {
+		rc = PTR_ERR(ctx);
 		goto err_rhashtable_free;
+	}
 	optee->ctx = ctx;
 	rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
 	if (rc)
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 1a55339c7072..c517d310249f 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1417,8 +1417,10 @@ static int optee_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, optee);
 	ctx = teedev_open(optee->teedev);
-	if (IS_ERR(ctx))
+	if (IS_ERR(ctx)) {
+		rc = PTR_ERR(ctx);
 		goto err_supp_uninit;
+	}
 	optee->ctx = ctx;
 	rc = optee_notif_init(optee, max_notif_value);
 	if (rc)
-- 
2.25.1

