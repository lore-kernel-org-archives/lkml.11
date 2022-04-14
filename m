Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC1C4167E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346157AbiDNNzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245418AbiDNN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D043BE0;
        Thu, 14 Apr 2022 06:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76C5619EF;
        Thu, 14 Apr 2022 13:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D32C385A1;
        Thu, 14 Apr 2022 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942567;
        bh=ONVrsDX9luGxtvHXfM9RH5hOjSyNdgMQabC4i6/1Woo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YehMOWE/1KZEWizY3JWDKhZK3e5gPN0Ty0g6zQD4iqZu17UWfoZ53f3Gwc949dZ1F
         wslOvlRV0HOfd12tS0SaevihnZlIHVvdJnNrK/1EGA2AK/aWCeVXo4Ei7aG2/NB34K
         TxBpLvWUZYK9YKokvI0VTaV266cve25Ce/XD5Nhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 181/338] clk: qcom: gcc-msm8994: Fix gpll4 width
Date:   Thu, 14 Apr 2022 15:11:24 +0200
Message-Id: <20220414110844.049387319@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

[ Upstream commit 71021db1c532c2545ae53b9ee85b37b7154f51d4 ]

The gpll4 postdiv is actually a div4, so make sure that Linux is aware of
this.

This fixes the following error messages:

 mmc1: Card appears overclocked; req 200000000 Hz, actual 343999999 Hz
 mmc1: Card appears overclocked; req 400000000 Hz, actual 687999999 Hz

Fixes: aec89f78cf01 ("clk: qcom: Add support for msm8994 global clock controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Link: https://lore.kernel.org/r/20220319174940.341137-1-konrad.dybcio@somainline.org
Tested-by: Petr Vorel <petr.vorel@gmail.com>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-msm8994.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 53f0f369a33e..4ec481efedc8 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -115,6 +115,7 @@ static struct clk_alpha_pll gpll4_early = {
 
 static struct clk_alpha_pll_postdiv gpll4 = {
 	.offset = 0x1dc0,
+	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.clkr.hw.init = &(struct clk_init_data)
 	{
-- 
2.34.1



