Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E5C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiHWJOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349061AbiHWJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A8974E10;
        Tue, 23 Aug 2022 01:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93A6D6148E;
        Tue, 23 Aug 2022 08:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C17CC433C1;
        Tue, 23 Aug 2022 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661243454;
        bh=G2K9/tvgzYCsdb49HzRkvEhTlNWWJDNeuDTwoROSywg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3wc+hB08ue3tH/ZJFTojNt4XKLsWwa82dlRAAVLUnU8J/EeB2bOKQGM0Ep8MhCmq
         L55DLDYG0e8ItmrecMyXOqMEQZ2/XUN8hQbcbyT4+lDoE70EvVbdQVL1jrlj7WZhqi
         JRZ/9uJEaPsAqNbmYR2utW0elNARlTu9+VdILNqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 283/365] clk: qcom: clk-alpha-pll: fix clk_trion_pll_configure description
Date:   Tue, 23 Aug 2022 10:03:04 +0200
Message-Id: <20220823080130.010599436@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 94bed9bb05c7850ff5d80b87cc29004901f37956 ]

After merging lucid and trion pll functions in commit 0b01489475c6
("clk: qcom: clk-alpha-pll: same regs and ops for trion and lucid")
the function clk_trion_pll_configure() is left with an old description
header, which results in a W=2 compile time warning, fix it.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220701062711.2757855-1-vladimir.zapolskiy@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4406cf609aae..288692f0ea39 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1439,7 +1439,7 @@ const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
 
 /**
- * clk_lucid_pll_configure - configure the lucid pll
+ * clk_trion_pll_configure - configure the trion pll
  *
  * @pll: clk alpha pll
  * @regmap: register map
-- 
2.35.1



