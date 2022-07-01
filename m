Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 07:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiGAHhK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 03:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiGAHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:37:08 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA16D551;
        Fri,  1 Jul 2022 00:37:07 -0700 (PDT)
Received: from localhost.localdomain (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id CD3E83F7BC;
        Fri,  1 Jul 2022 09:37:05 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF
Date:   Fri,  1 Jul 2022 09:37:00 +0200
Message-Id: <20220701073700.17124-1-konrad.dybcio@somainline.org>
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
 drivers/soc/qcom/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e718b8735444..a750714d5714 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -130,6 +130,8 @@ config QCOM_RPMHPD
 config QCOM_RPMPD
 	tristate "Qualcomm RPM Power domain driver"
 	depends on QCOM_SMD_RPM
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
 	help
 	  QCOM RPM Power domain driver to support power-domains with
 	  performance states. The driver communicates a performance state
-- 
2.37.0

