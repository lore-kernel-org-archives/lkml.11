Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A060C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbiC3KUL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiC3KUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:20:10 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137313E09
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:18:23 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 30 Mar
 2022 18:18:24 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 30 Mar
 2022 18:18:21 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] bus: imx-weim: fix pdev is NULL but dereferenced
Date:   Wed, 30 Mar 2022 18:18:20 +0800
Message-ID: <1648635500-12631-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pdev is NULL，so we can't dereference it dev_err(&pdev->dev

Fixes: e6cb540 ("bus: imx-weim: add DT overlay support for WEIM bus")

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/bus/imx-weim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 60fbd42..31a2213 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -352,9 +352,8 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
 
 		pdev = of_find_device_by_node(rd->dn);
 		if (!pdev) {
-			dev_err(&pdev->dev,
-				"Could not find platform device for '%pOF'\n",
-				rd->dn);
+			pr_err("%s: Could not find platform device for '%pOF'\n",
+				__func__, rd->dn);
 
 			ret = notifier_from_errno(-EINVAL);
 		} else {
-- 
2.7.4

