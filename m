Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 21:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiGGVEn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 17:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiGGVEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:04:37 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4902B601
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:04:36 -0700 (PDT)
Received: from localhost.localdomain (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id C10801F564;
        Thu,  7 Jul 2022 23:04:33 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF
Date:   Thu,  7 Jul 2022 23:04:28 +0200
Message-Id: <20220707210428.30382-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses generic genpd OF APIs and with a very minimal config
where nothing else selects them, this driver will not probe, as
of_genpd_add_provider_onecell will return -EOPNOTSUPP.

Make sure to select these in Kconfig to prevent that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
As Intel's kernel test robot pointed out, the v1 was faulty, as
I somehow didn't think about making it depend on PM (it's required
for PM_GENERIC_DOMAINS/_OF)...


 drivers/soc/qcom/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e718b8735444..7e714327018f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -129,7 +129,10 @@ config QCOM_RPMHPD
 
 config QCOM_RPMPD
 	tristate "Qualcomm RPM Power domain driver"
+	depends on PM
 	depends on QCOM_SMD_RPM
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
 	help
 	  QCOM RPM Power domain driver to support power-domains with
 	  performance states. The driver communicates a performance state
-- 
2.37.0

