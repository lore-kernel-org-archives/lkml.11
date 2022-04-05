Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC8C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358323AbiDEUXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349457AbiDEJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3225FE;
        Tue,  5 Apr 2022 02:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 605E9B81B7A;
        Tue,  5 Apr 2022 09:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A02C385A2;
        Tue,  5 Apr 2022 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649151989;
        bh=jQPU+iVWdRJO/Zf9E9j5Fx4xuwiHUlqhxnNThXYz8Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEW259Ll+fAMDXZNdNeH4P14pwjN3tK5lQRp7cQqSbKYpga1YH5zlqqnaQ7VlBD/u
         6V+SHLDGeVff5mVaUbLCl5vdHVg+SSBMBX3k6y33KRe3R/sVpPQanXKk6NfCcUrPpl
         Pt65z9snhqvtZh5Vcnxv5ITCYnzkshBGFwJryxkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 613/913] clk: qcom: clk-rcg2: Update the frac table for pixel clock
Date:   Tue,  5 Apr 2022 09:27:55 +0200
Message-Id: <20220405070358.215951115@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

[ Upstream commit b527358cb4cd58a8279c9062b0786f1fab628fdc ]

Support the new numerator and denominator for pixel clock on SM8350 and
support rgb101010, RGB888 use cases on SM8450.

Fixes: 99cbd064b059f ("clk: qcom: Support display RCG clocks")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220227175536.3131-2-tdas@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-rcg2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index b831975a9606..f675fd969c4d 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -729,6 +729,7 @@ static const struct frac_entry frac_table_pixel[] = {
 	{ 2, 9 },
 	{ 4, 9 },
 	{ 1, 1 },
+	{ 2, 3 },
 	{ }
 };
 
-- 
2.34.1



