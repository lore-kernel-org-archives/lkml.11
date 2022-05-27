Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 06:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbiE0GtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 02:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbiE0GtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:49:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6BED8D5;
        Thu, 26 May 2022 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653634155; x=1685170155;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0t1DGejBLqrGuaKm5GDs3t3WPZiALR9whEGvT3f5TaU=;
  b=w4rrdtanXzZfPVL+EAnqPUVXpbR6bP61HNJ0fcPvu9vClxDNgplGmQCF
   YXe/B8C6bwJRN+5L59qFDZZ1HELxKjzN/pA9I+jN9cVvQPmR+Sl6a1dC6
   5hGViQXaaH6YRlqa9WY9tzd/tMjRl5IjHkdvMr2lzGVjbsiUkV/Pm2e8B
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 May 2022 23:49:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:49:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 23:49:13 -0700
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 23:49:11 -0700
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH] usb: common: usb-conn-gpio: Allow wakeup from system suspend
Date:   Fri, 27 May 2022 12:19:06 +0530
Message-ID: <1653634146-12215-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the VBUS/ID detection interrupts are disabled during system
suspend. So the USB cable connect/disconnect event can't wakeup the
system from low power mode. To allow this, we keep these interrupts
enabled and configure them as wakeup capable. This behavior can be
controlled through device wakeup source policy by the user space.

Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/common/usb-conn-gpio.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 395f9bb..b39c9f1c 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -257,6 +257,7 @@ static int usb_conn_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, info);
+	device_set_wakeup_capable(&pdev->dev, true);
 
 	/* Perform initial detection */
 	usb_conn_queue_dwork(info, 0);
@@ -286,6 +287,14 @@ static int __maybe_unused usb_conn_suspend(struct device *dev)
 {
 	struct usb_conn_info *info = dev_get_drvdata(dev);
 
+	if (device_may_wakeup(dev)) {
+		if (info->id_gpiod)
+			enable_irq_wake(info->id_irq);
+		if (info->vbus_gpiod)
+			enable_irq_wake(info->vbus_irq);
+		return 0;
+	}
+
 	if (info->id_gpiod)
 		disable_irq(info->id_irq);
 	if (info->vbus_gpiod)
@@ -300,6 +309,14 @@ static int __maybe_unused usb_conn_resume(struct device *dev)
 {
 	struct usb_conn_info *info = dev_get_drvdata(dev);
 
+	if (device_may_wakeup(dev)) {
+		if (info->id_gpiod)
+			disable_irq_wake(info->id_irq);
+		if (info->vbus_gpiod)
+			disable_irq_wake(info->vbus_irq);
+		return 0;
+	}
+
 	pinctrl_pm_select_default_state(dev);
 
 	if (info->id_gpiod)
-- 
2.7.4

