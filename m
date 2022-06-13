Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8606EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiFMPhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbiFMPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:36:49 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA520193
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=k2/EGuG8SaS4N9bPQn1lwA6rR4D
        xpryQq6eDqkQAtL4=; b=OoTPRgyjGFHwh521dCXTeAvh2O+caoJj9/zecZen1Ca
        1PaR/0bX1O+sizEXGCg13p6pFO7gByD44Atuda+Q/PmNjkRQJcxrNp6HbNseWf12
        jR/TQCRLYlgkq4SugHOiN4DBW0WjZmCiGsreFdJ433IWOvlEgXFdvJ7zuk6dsZCI
        =
Received: (qmail 1304294 invoked from network); 13 Jun 2022 15:09:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2022 15:09:59 +0200
X-UD-Smtp-Session: l3s3148p1@3itJAVThEwVZD+yY
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: renesas: r8a779f0: Add HSCIF0+1 clocks
Date:   Mon, 13 Jun 2022 15:09:49 +0200
Message-Id: <20220613130949.10001-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those have been successfully tested. HSCIF2+3 still need verification.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index 0aec5e8ffd96..a7c16e72515f 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -118,6 +118,8 @@ static const struct cpg_core_clk r8a779f0_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a779f0_mod_clks[] __initconst = {
+	DEF_MOD("hscif0",	514,	R8A779F0_CLK_S0D3),
+	DEF_MOD("hscif1",	515,	R8A779F0_CLK_S0D3),
 	DEF_MOD("i2c0",		518,	R8A779F0_CLK_S0D6_PER),
 	DEF_MOD("i2c1",		519,	R8A779F0_CLK_S0D6_PER),
 	DEF_MOD("i2c2",		520,	R8A779F0_CLK_S0D6_PER),
-- 
2.35.1

