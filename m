Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE477C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 11:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiEYLO6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 07:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbiEYLOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:14:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19789418D;
        Wed, 25 May 2022 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653477270; x=1685013270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ByRJ2FvKSQO1vckC/JD+7LN4M01SATLQONUjJBNZA7A=;
  b=OChZurHRfAK+FuXdqCLcBqEEDr2bSza5niZk57ivtqK7yt+NzMuX2NHd
   X2ABwxyvIMXiVqB9Hinre0S5o41x2+Na5ppu+N6Qij2qwZ8WOEZF/40/t
   vQfOuAhxmAOuLmkn1TR8B1EcnPNSxCFpOESSfbuxdC3gWJ0odN66v0PXt
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 May 2022 04:14:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 04:14:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 04:14:29 -0700
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 04:14:25 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V8 3/7] MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver support
Date:   Wed, 25 May 2022 16:43:18 +0530
Message-ID: <a97603aa29aaa829ebd6ee4ba1a345574253ca38.1653475467.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1653475467.git.quic_schowdhu@quicinc.com>
References: <cover.1653475467.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the entries for all the files added as a part of driver support for
DCC(Data Capture and Compare).

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3..e57d927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5146,6 +5146,14 @@ F:	include/linux/tfrc.h
 F:	include/uapi/linux/dccp.h
 F:	net/dccp/

+DCC QTI DRIVER
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-driver-dcc
+F:	Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
+F:	drivers/soc/qcom/dcc.c
+
 DECnet NETWORK LAYER
 L:	linux-decnet-user@lists.sourceforge.net
 S:	Orphan
--
2.7.4

