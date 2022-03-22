Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8AFC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 07:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbiCVHJy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiCVHJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:09:46 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FF606F5;
        Tue, 22 Mar 2022 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647932899; x=1679468899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=exEL5My83w1KFkmArEDf0YLEXkhzH1s/iCOXA0WVQEM=;
  b=LgrdDZfBFkW6H9AibU61Ec02ja677c5oceexwIUqKjL9MK8UIWJqjkkK
   pgh6AjSbHq1ruqrXYsyXJAHw8XCRb904ZEThPLFDH1ti/1PgdXB7IDg0C
   4AQhQ1RPSAii4QPWvA7mBv97AyNP8Tz8AQQ5Kz+JXAkWLULsU86CGUha8
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 00:08:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 00:08:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 00:08:18 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 00:08:14 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v11 1/5] usb: dwc3: core: Add HS phy mode variable and phy poweroff flag
Date:   Tue, 22 Mar 2022 12:37:52 +0530
Message-ID: <1647932876-23249-2-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add variables in dwc3 structure to check HS phy mode which is
used to configure interrupts and phy poweroff flag to check
the phy status during system resume.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 drivers/usb/dwc3/core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5c9d467..f11a60c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1154,6 +1154,9 @@ struct dwc3 {
 
 	bool			phys_ready;
 
+	unsigned int            hs_phy_mode;
+	bool			phy_power_off;
+
 	struct ulpi		*ulpi;
 	bool			ulpi_ready;
 
-- 
2.7.4

