Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E059DC28B2B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352237AbiHSQUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352220AbiHSQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C8A107ACA;
        Fri, 19 Aug 2022 08:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA046175A;
        Fri, 19 Aug 2022 15:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A59C433C1;
        Fri, 19 Aug 2022 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660924747;
        bh=MdB3PvHOk2GIdsHwS3dREinhxK0gOcwEJ8wSaf7lMCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFdVquZIgFUgD8cCF1MmsbKQj2wzwN6lAmm2heOMnYK4Wf8D3LXrN0qhEVHsARfa9
         VFErkoBM+iF3yh7OX61IZ2xiZtngAgFOm/3Dw2ToFna1xGf7EyCAPrezGeiLbCbKFV
         O6zNNf2QLYNeXRWPWUKDrcg1Z6H5q02nBCx+Bc6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralph Siemsen <ralph.siemsen@linaro.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 269/545] clk: renesas: r9a06g032: Fix UART clkgrp bitsel
Date:   Fri, 19 Aug 2022 17:40:39 +0200
Message-Id: <20220819153841.365051576@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Siemsen <ralph.siemsen@linaro.org>

[ Upstream commit 2dee50ab9e72a3cae75b65e5934c8dd3e9bf01bc ]

There are two UART clock groups, each having a mux to select its
upstream clock source. The register/bit definitions for accessing these
two muxes appear to have been reversed since introduction. Correct them
so as to match the hardware manual.

Fixes: 4c3d88526eba ("clk: renesas: Renesas R9A06G032 clock driver")

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Reviewed-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220518182527.1693156-1-ralph.siemsen@linaro.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 892e91b92f2c..245150a5484a 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -286,8 +286,8 @@ static const struct r9a06g032_clkdesc r9a06g032_clocks[] = {
 		.name = "uart_group_012",
 		.type = K_BITSEL,
 		.source = 1 + R9A06G032_DIV_UART,
-		/* R9A06G032_SYSCTRL_REG_PWRCTRL_PG1_PR2 */
-		.dual.sel = ((0xec / 4) << 5) | 24,
+		/* R9A06G032_SYSCTRL_REG_PWRCTRL_PG0_0 */
+		.dual.sel = ((0x34 / 4) << 5) | 30,
 		.dual.group = 0,
 	},
 	{
@@ -295,8 +295,8 @@ static const struct r9a06g032_clkdesc r9a06g032_clocks[] = {
 		.name = "uart_group_34567",
 		.type = K_BITSEL,
 		.source = 1 + R9A06G032_DIV_P2_PG,
-		/* R9A06G032_SYSCTRL_REG_PWRCTRL_PG0_0 */
-		.dual.sel = ((0x34 / 4) << 5) | 30,
+		/* R9A06G032_SYSCTRL_REG_PWRCTRL_PG1_PR2 */
+		.dual.sel = ((0xec / 4) << 5) | 24,
 		.dual.group = 1,
 	},
 	D_UGATE(CLK_UART0, "clk_uart0", UART_GROUP_012, 0, 0, 0x1b2, 0x1b3, 0x1b4, 0x1b5),
-- 
2.35.1



