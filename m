Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB243C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 17:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiGLRok (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 13:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGLRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:44:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F084CDA2A;
        Tue, 12 Jul 2022 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657647878; x=1689183878;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=n/EFQWi2zN3zPt+WoTW4/wSsWNc9KD0J7PX0+1/53+M=;
  b=Td6WIUZqSNBRWbiC61TOpf0pKn4PIjVOJMm2M/HlSbUFEj0Seyk3Q5tF
   aRY49hGr3Kr2coQG50vS+LYLZzbY8MdIQWDSGc3IopIoXflHpaqYlsxXO
   omk52EKlmtjb0NL83uzx4oNl/sO94owZIzTy28aPD3B8d7znOusOqetbk
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 10:44:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:44:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 10:44:37 -0700
Received: from hu-rkollals-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 10:44:35 -0700
From:   Rohith Kollalsi <quic_rkollals@quicinc.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rohith Kollalsi" <quic_rkollals@quicinc.com>
Subject: [PATCH] usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup
Date:   Tue, 12 Jul 2022 23:14:23 +0530
Message-ID: <20220712174423.20484-1-quic_rkollals@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the programming guide, it is recommended to
perform a GCTL_CORE_SOFTRESET only when switching the mode
from device to host or host to device. However, it is found
that during bootup when __dwc3_set_mode() is called for the
first time, GCTL_CORESOFTRESET is done with suspendable bit(BIT 17)
of DWC3_GUSB3PIPECTL set. This some times leads to issues
like controller going into bad state and controller registers
reading value zero. Until GCTL_CORESOFTRESET is done and
run/stop bit is set core initialization is not complete.
Setting suspendable bit of DWC3_GUSB3PIPECTL and then
performing GCTL_CORESOFTRESET is therefore not recommended.
Avoid this by only performing the reset if current_dr_role is set,
that is, when doing subsequent role switching.

Fixes: f88359e1588b ("usb: dwc3: core: Do core softreset when switch mode")
Signed-off-by: Rohith Kollalsi <quic_rkollals@quicinc.com>
---
 drivers/usb/dwc3/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 050b2ba5986d..7ce0e033d755 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -158,9 +158,13 @@ static void __dwc3_set_mode(struct work_struct *work)
 		break;
 	}
 
-	/* For DRD host or device mode only */
-	if ((DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
-	    dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
+	/*
+	 * When current_dr_role is zero, do not perform GCTL_CORESOFTRESET.
+	 * Perform it only for DRD host or device mode.
+	 */
+	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
+			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
+			dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 		reg |= DWC3_GCTL_CORESOFTRESET;
 		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-- 
2.17.1

