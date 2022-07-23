Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02022C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jul 2022 10:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbiGWKLf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jul 2022 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239314AbiGWKJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:09:33 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1EE80500
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:02:41 -0700 (PDT)
Received: from localhost.localdomain (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id B2255408A4;
        Sat, 23 Jul 2022 12:02:31 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: qcom: socinfo: Add PM6125 ID
Date:   Sat, 23 Jul 2022 12:02:25 +0200
Message-Id: <20220723100225.92053-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220723100225.92053-1-konrad.dybcio@somainline.org>
References: <20220723100225.92053-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM6125 has the ID 45. Add it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index fdaa56d3b79a..aa37e1bad095 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -104,6 +104,7 @@ static const char *const pmic_models[] = {
 	[36] = "PM8009",
 	[38] = "PM8150C",
 	[41] = "SMB2351",
+	[45] = "PM6125",
 	[47] = "PMK8350",
 	[48] = "PM8350",
 	[49] = "PM8350C",
-- 
2.37.1

