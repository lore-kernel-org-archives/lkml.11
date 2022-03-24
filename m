Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 08:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiCXIqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbiCXIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:46:47 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB9549BBB1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=hbQtGcGdsRfjLfzJe0
        nhtrj0QFYvT56HXlrOmgtNRjs=; b=ORcHIqPGOBG4ypZP9M/QfR7HkDbPho5X5C
        U9Bi5mgegbXckI+hqAFbxm7eE+clrZi+Y0vXGRpCCe94vMNvNwWpQoAhOruN6acL
        SyJVe7/UQeJ7hy9znZ0Lq0aoTW7tyhNiqi9UwvqEgLA6nDzvQnrGGBX/+kwG+fbe
        FejKdSh10=
Received: from localhost (unknown [159.226.95.33])
        by smtp8 (Coremail) with SMTP id DMCowAC3jK2ULzxizxz+Bg--.28201S2;
        Thu, 24 Mar 2022 16:45:08 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     jckuo@nvidia.com
Cc:     linux-kernel@vger.kernel.org, QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] phy: tegra: xusb: Check for NULL return of devm_kzalloc()
Date:   Thu, 24 Mar 2022 16:45:05 +0800
Message-Id: <1648111505-5806-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowAC3jK2ULzxizxz+Bg--.28201S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr18Cw17tF1ktF4kGr45KFg_yoWfGwb_uw
        s5Zr97XrWqgr17Cw1jyw43ZrySya1IgFn7ZFsYqa43A3yjvr4Fy3yUZrZxu3yxC3Z5WFZr
        J34DZF1fZr17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUb6wZ5UUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/xtbCbhTNH2BbCZuMRwAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation of devm_kzalloc() may return a NULL pointer, can cause
a NULL-pointer dereference in the follow lines of code.

To avoid this, it is better to check the return value of devm_kzalloc().

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/phy/tegra/xusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index aa5237e..f32b3cf 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -668,6 +668,9 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	port->dev.driver = devm_kzalloc(&port->dev,
 					sizeof(struct device_driver),
 					GFP_KERNEL);
+	if (!port->dev.driver)
+		return -ENOMEM;
+
 	port->dev.driver->owner	 = THIS_MODULE;
 
 	port->usb_role_sw = usb_role_switch_register(&port->dev,
-- 
2.7.4

