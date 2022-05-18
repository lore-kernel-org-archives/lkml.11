Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2558EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 16:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbiERQpt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 12:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiERQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:45:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB41FE1C7;
        Wed, 18 May 2022 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652892326; x=1684428326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a/+b7pV2Bo1HIRQnpM4Y15NOBUEBq9pVgDGvjKkqQtY=;
  b=gdA5kF/OBSCGL5lbbaJawtm0ywDnyH28akklNjxqCLaQ/58KSe51b6XV
   Hy5BHUQS8EtmQxMSb9XuRSlR3MZY44MFbgc16tvXfEbN89o0mT9+wXnIj
   wOI1IHbJjKy7LWC/klBq5fKESTSIuLOZka5AVbf8laYuV8lcBE0IWV4tp
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 09:45:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:45:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 09:45:25 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 09:45:20 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>, <suzuki.poulose@arm.com>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCHv15 8/9] serial: qcom_geni_serial: Disable MMIO tracing for geni serial
Date:   Wed, 18 May 2022 22:14:17 +0530
Message-ID: <2db93219cdeabe1c267c7f627e26b8d7fc7caa23.1652891705.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1652891705.git.quic_saipraka@quicinc.com>
References: <cover.1652891705.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable MMIO tracing for geni serial driver to prevent excessive
logging. Any access over serial console would involve a lot of
TX and RX register accesses (and few others), so these MMIO
read/write trace events in these drivers cause a lot of unwanted
noise because of the high frequency of such operations and it is
not very useful tracing these events for such drivers.
Given we want to enable these trace events on development devices
(maybe not production devices) where performance also really matters
so that we don't regress other components by wasting CPU cycles and
memory collecting these traces, it makes more sense to disable these
traces from such drivers.

Also another reason to disable these traces would be to prevent
recursive tracing when we display the trace buffer containing
these MMIO trace events since writing onto serial console would
further record MMIO traces.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 1543a6028856..75272585c3c3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
+/* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
+#define __DISABLE_TRACE_MMIO__
+
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
-- 
2.33.1

