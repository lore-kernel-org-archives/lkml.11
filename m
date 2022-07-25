Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 02:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiGYCQc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jul 2022 22:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGYCQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:16:30 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 498199598;
        Sun, 24 Jul 2022 19:16:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 9EEDC1E80D0F;
        Mon, 25 Jul 2022 10:11:30 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BkgryQaiO_vd; Mon, 25 Jul 2022 10:11:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CEBA91E80D05;
        Mon, 25 Jul 2022 10:11:27 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kernel@nfschina.com,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] clk/qcom/drivers/sm6350: qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap) is assigned an extra semicolon
Date:   Mon, 25 Jul 2022 10:16:23 +0800
Message-Id: <20220725021623.3910-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this semicolon could be deleted.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/clk/qcom/gcc-sm6350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index a4f7fba70393..69412400efa4 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -2558,7 +2558,7 @@ static int gcc_sm6350_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap);;
+	return qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap);
 }
 
 static struct platform_driver gcc_sm6350_driver = {
-- 
2.18.2

