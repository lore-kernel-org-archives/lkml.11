Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F476C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 13:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356626AbiFVNjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357683AbiFVNjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:39:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6B06579
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655905141; x=1687441141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NOtcLQjYTnNg3cztWyQoeInOB4wkg5FDxYvL8BwSdPY=;
  b=koXm/QFb8ioA/zLBxw2VYGUzeneuJxfJNfqAR9yHcJUVrYcoX5JranwN
   wCS1XIjnuNiQDpKV/Tx/Kc40HkN4+qCSr3orm6u/1zZhtiYhEAqrYDcZ+
   /QFGlGn8lnlNDf8l9jMsbasF0i98UB4R20E0smivpIwRUezoJZjVhmZj/
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jun 2022 06:39:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 06:38:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 06:38:57 -0700
Received: from ubuntu.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 06:38:57 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] arm64: defconfig: Select ARM_CMN=m
Date:   Wed, 22 Jun 2022 09:38:27 -0400
Message-ID: <20220622133827.140979-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm cmn driver is fairly common on servers, so select it as a
module.

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 55811436adb8..55093bf341a2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -68,6 +68,7 @@ CONFIG_ARCH_VISCONTI=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_ARM64_VA_BITS_48=y
+CONFIG_ARM_CMN=m
 CONFIG_SCHED_MC=y
 CONFIG_SCHED_SMT=y
 CONFIG_NUMA=y
-- 
2.34.1

