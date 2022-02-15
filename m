Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5584EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiBOFi7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:38:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiBOFix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:38:53 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629EC14014;
        Mon, 14 Feb 2022 21:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644903521; x=1676439521;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ndUMctv6RUFJ6MTBZVT4QO3AbPfxMnqRottuMmn9rjk=;
  b=bMiG8wUsHrnSTBhJnQ9gWX5A1+eTOdsbNL5lmpxj0EEyCjoFpLgka+Yy
   5K2Z87+TMGPz6A9B/SBkXV70UJDZEeqj7P9cTmyzOfVwdO7/tLyPm1uRO
   W3vqOSWNwIl9pgY7ygl0FRrsYFX4tDwDGma6VqkKycKdL3RWjPX3AVyje
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Feb 2022 21:38:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 21:38:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 21:38:40 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 21:38:36 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        <quic_saipraka@quicinc.com>, <quic_schowdhu@quicinc.com>
Subject: [PATCH V1] arm64: dts: qcom: sc7280: Set the default dr_mode for usb2 to enable EUD.
Date:   Tue, 15 Feb 2022 11:08:08 +0530
Message-ID: <1644903488-20557-1-git-send-email-quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the dr_mode for usb2 to 'otg' from 'host' to enable role switch for Embedded USB
Debugger(EUD) Node.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index a7be133..6d3ff80 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -90,7 +90,7 @@
 };

 &usb_2_dwc3 {
-	dr_mode = "host";
+	dr_mode = "otg";
 };

 &usb_2_hsphy {
--
2.7.4

