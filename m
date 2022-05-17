Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FD8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 01:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiEQB2Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 21:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiEQB2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:28:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8A45AC5;
        Mon, 16 May 2022 18:28:20 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2JQS4PyvzhZ7f;
        Tue, 17 May 2022 09:27:44 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 09:28:18 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <hkallweit1@gmail.com>, <bhelgaas@google.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <wupeng58@huawei.com>
Subject: [PATCH] sfc/siena: fix driver suspend/resume methods
Date:   Tue, 17 May 2022 01:23:34 +0000
Message-ID: <20220517012334.122677-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing pci_disable_device() before return
from efx_pm_resume() in the error handling case.

Meanwhile, drivers should do this:
.resume()
	pci_enable_device()
.suspend()
	pci_disable_device()

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/net/ethernet/sfc/siena/efx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/ethernet/sfc/siena/efx.c
index 63d999e63960..4c0ab91914f2 100644
--- a/drivers/net/ethernet/sfc/siena/efx.c
+++ b/drivers/net/ethernet/sfc/siena/efx.c
@@ -1216,21 +1216,26 @@ static int efx_pm_resume(struct device *dev)
 	pci_set_master(efx->pci_dev);
 	rc = efx->type->reset(efx, RESET_TYPE_ALL);
 	if (rc)
-		return rc;
+		goto out;
 	down_write(&efx->filter_sem);
 	rc = efx->type->init(efx);
 	up_write(&efx->filter_sem);
 	if (rc)
-		return rc;
+		goto out;
 	rc = efx_pm_thaw(dev);
 	return rc;
+out:
+	pci_disable_device(pci_dev);
+	return rc;
 }
 
 static int efx_pm_suspend(struct device *dev)
 {
+	struct pci_dev *pci_dev = to_pci_dev(dev);
 	int rc;
 
 	efx_pm_freeze(dev);
+	pci_disable_device(pci_dev);
 	rc = efx_pm_poweroff(dev);
 	if (rc)
 		efx_pm_resume(dev);
-- 
2.17.1

