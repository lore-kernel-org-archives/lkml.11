Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA54C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiBZVmX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Feb 2022 16:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiBZVmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:42:22 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2844993F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:41:47 -0800 (PST)
Received: from localhost.localdomain (abxh33.neoplus.adsl.tpnet.pl [83.9.1.33])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 62EE43F344;
        Sat, 26 Feb 2022 22:41:44 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: clock: qcom: rpmcc: Add RPM Modem SubSystem (MSS) clocks
Date:   Sat, 26 Feb 2022 22:41:24 +0100
Message-Id: <20220226214126.21209-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing clock definitions.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 include/dt-bindings/clock/qcom,rpmcc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
index fb624ff39273..015db95303d1 100644
--- a/include/dt-bindings/clock/qcom,rpmcc.h
+++ b/include/dt-bindings/clock/qcom,rpmcc.h
@@ -165,5 +165,7 @@
 #define RPM_SMD_PKA_A_CLK			119
 #define RPM_SMD_CPUSS_GNOC_CLK			120
 #define RPM_SMD_CPUSS_GNOC_A_CLK		121
+#define RPM_SMD_MSS_CFG_AHB_CLK		122
+#define RPM_SMD_MSS_CFG_AHB_A_CLK		123
 
 #endif
-- 
2.35.1

