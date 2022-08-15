Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BC3C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 22:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiHOWTM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbiHOWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:15:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2B11F754;
        Mon, 15 Aug 2022 12:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91E1D611F9;
        Mon, 15 Aug 2022 19:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89969C433D6;
        Mon, 15 Aug 2022 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660592360;
        bh=gYJQV0CYwkY4S0gra6WnEjPpMfpNO/F+S1Ngd2WqFcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxdayhxdAPNXDwvA1bR+DW2uYai+tQdDCtd7gyN/Et30i0yrE0zh33cYQh0ZAknIS
         V9nAhkVaz/J64fDuqCOJRMX9HdnOeupp7QceU5I7CTRjAxpKVfIMHfKBD+zYqz7AoW
         +COZGFCBJcoCrjKXCDs6xDe5rhWQJLIweO4RxcRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0775/1095] clk: qcom: gcc-msm8939: Fix weird field spacing in ftbl_gcc_camss_cci_clk
Date:   Mon, 15 Aug 2022 20:02:54 +0200
Message-Id: <20220815180501.323380876@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit 2bc308ebc453ba22f3f120f777b9ac48f973ee80 ]

Adding a new item to this frequency table I see the existing indentation is
incorrect.

Fixes: 1664014e4679 ("clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock Controller")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220712125922.3461675-2-bryan.odonoghue@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-msm8939.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
index c7377ec0f423..de0022e5450d 100644
--- a/drivers/clk/qcom/gcc-msm8939.c
+++ b/drivers/clk/qcom/gcc-msm8939.c
@@ -1014,7 +1014,7 @@ static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
 };
 
 static const struct freq_tbl ftbl_gcc_camss_cci_clk[] = {
-	F(19200000,	P_XO, 1, 0,	0),
+	F(19200000, P_XO, 1, 0, 0),
 	{ }
 };
 
-- 
2.35.1



