Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 18:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiERSNZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 14:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiERSNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:13:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF4416A246;
        Wed, 18 May 2022 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652897601; x=1684433601;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2bv8YYEomi2Pw3GsY9fZwzSE3m5nm/FOF4cSfap6sTw=;
  b=aATq7G4lweGa/bdE0ULybxGQ5s5q4nr8poP9kkWa2rqurfKO8vPQljSN
   ajgKkHqzsuMVQtKvXt+q3m+vbcutbw9TwIQvlnxoHVkpAU16qay3IM7Os
   8uFMa8owsEgGQyXStZtVY2KjjlgqFABHcMwQrglAU5AArPEQrdDJhKdlH
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 11:13:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 11:13:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 11:13:20 -0700
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 11:13:20 -0700
From:   Mayank Rana <quic_mrana@quicinc.com>
To:     <peter.chen@kernel.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH] usb: dwc3: core: Add error log when core soft reset failed
Date:   Wed, 18 May 2022 11:12:52 -0700
Message-ID: <1652897572-14461-1-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DWC3 controller soft reset is important operation for USB functionality.
In case when it fails, currently there is no failure log. Hence add
error log when core soft reset failed.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/usb/dwc3/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d28cd1a..8b87ff6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -297,6 +297,7 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 			udelay(1);
 	} while (--retries);
 
+	dev_warn(dwc->dev, "DWC3 controller soft reset failed.\n");
 	return -ETIMEDOUT;
 
 done:
-- 
2.7.4

