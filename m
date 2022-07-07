Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79757CCA479
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 21:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiGGVWO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 17:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiGGVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:22:13 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C63831DFA;
        Thu,  7 Jul 2022 14:22:12 -0700 (PDT)
Received: from localhost.localdomain (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 4C1641F9A9;
        Thu,  7 Jul 2022 23:22:09 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kernel test robot <lkp@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc/qcom: Make QCOM_RPMPD depend on PM
Date:   Thu,  7 Jul 2022 23:21:58 +0200
Message-Id: <20220707212158.32684-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_RPMPD requires PM_GENERIC_DOMAINS/_OF, which in turns requires
CONFIG_PM. I forgot about the latter in my earlier patch (it's still
in -next as of the time of committing, hence no Fixes: tag). Fix it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a750714d5714..7e714327018f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -129,6 +129,7 @@ config QCOM_RPMHPD
 
 config QCOM_RPMPD
 	tristate "Qualcomm RPM Power domain driver"
+	depends on PM
 	depends on QCOM_SMD_RPM
 	select PM_GENERIC_DOMAINS
 	select PM_GENERIC_DOMAINS_OF
-- 
2.37.0

