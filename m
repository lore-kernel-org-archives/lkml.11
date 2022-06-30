Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EEAC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 12:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiF3Mxf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 08:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiF3Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:53:33 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713E2DAB0;
        Thu, 30 Jun 2022 05:53:27 -0700 (PDT)
X-QQ-mid: bizesmtp72t1656593552tbed00zi
Received: from localhost.localdomain ( [182.148.13.66])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 30 Jun 2022 20:52:29 +0800 (CST)
X-QQ-SSF: 0100000000200090C000C00A0000000
X-QQ-FEAT: 3uawQE1sH+1idMrgYZkQZYmgnB0Oe1InJoUgnZDAyhloS9Kj2+cIyY4wWO1Qj
        BAwAZb0xdjyYp9mUp7eedIeDvNo4VZuvgDnTa87G/f22InURrB+hd7vRR/RAjQryeX9Psv+
        5pLfUU0eBEaw1wP0RLa+WgrQZUj6VbTF4jM3IqvIa4KPzlpwNkTub0KKklZfTmF/xUNb0WU
        LDzaNzjC0hvkrs9adLW8HohWvTOz+Q0afx0KybKO01f8ZCra5wm5Qg4a2r9/Az8FUM6m8Ow
        035h/B90UOshGQRIpO6g6RIjQmTmSxxvK+q8/bjJbhNTHhDlE4ijjH+pQB1gYDg0xHvmZBs
        EOYm43oWHIF0edFeJT/BSodGGMZYQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] stmicro/stmmac: fix repeated words in comments
Date:   Thu, 30 Jun 2022 20:52:22 +0800
Message-Id: <20220630125222.14357-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'all'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index a57b0fa815ab..ea4910ae0921 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -197,7 +197,7 @@ static void dwmac_mmc_ctrl(void __iomem *mmcaddr, unsigned int mode)
 		 MMC_CNTRL, value);
 }
 
-/* To mask all all interrupts.*/
+/* To mask all interrupts.*/
 static void dwmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
 	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_RX_INTR_MASK);
-- 
2.36.1

