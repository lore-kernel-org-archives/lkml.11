Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF042C4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 13:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbiBYNE1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 08:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbiBYNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:04:24 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C11DA032;
        Fri, 25 Feb 2022 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645794232; x=1677330232;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=tLTi208t9PkSrFC828ZdMyJbU0Jlyi2aKs/bqY+wFKI=;
  b=mwumVu94efXK5F6BUwUY7mkkqHgECU5YrJmd+RWCmRkBS3zieEThmsNj
   ZfGC2iHfPqtzBHGP72q4dhJa7Q2u/9jUC1cQYM4f1Q/76c7En1xYX7krN
   5kpOY0vrCXoFwdJRJT/NgQCJXFo3oJBRuHanjZc0DX5ewu01gPZAjRu4e
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Feb 2022 05:03:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 05:03:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 05:03:50 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 05:03:47 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        <quic_saipraka@quicinc.com>, <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 0/2] Revert device tree changes for EUD
Date:   Fri, 25 Feb 2022 18:32:59 +0530
Message-ID: <cover.1645793187.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the device tree changes for Embedded USB Debugger(EUD)
from the usb tree to avoid conflicts as device tree changes
for EUD are supposed to go from qcom Tree.

Changes in V2

*Added the reason in revert statement.

Souradeep Chowdhury (2):
  Revert "arm64: dts: qcom: sc7280: Set the default dr_mode for usb2"
  Revert "arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector"

 arch/arm64/boot/dts/qcom/sc7280-idp.dts |  4 ----
 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 36 ---------------------------------
 2 files changed, 40 deletions(-)

--
2.7.4

