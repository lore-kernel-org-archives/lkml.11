Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47946C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 15:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiEYPMO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiEYPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:11:50 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E4B0A50
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=IxNuk27AOBJI8YqPCZRwZ+KdvyF
        sVujNqAFYumeASkc=; b=DHmofkLbcNshOGlzIeXSba5GKBiXzRFkSRHo2kbqnYE
        0n5BSzM3rjpFQcyBNhILbFpPEO2hvmMOd7DXaTJrAFgQxpTEGYKbKbOCT5GYNKyA
        rJF7J/UiZ5dZhtZDAz1XGH9JNvtH8WmSYMF2HchLtmRFCLTKAUkJIdWjwv1o84po
        =
Received: (qmail 1644403 invoked from network); 25 May 2022 17:11:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 May 2022 17:11:37 +0200
X-UD-Smtp-Session: l3s3148p1@gZlMfdffvVVZD++C
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: renesas: r8a779f0: Add thermal clock
Date:   Wed, 25 May 2022 17:11:30 +0200
Message-Id: <20220525151130.24103-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index c17ebe6b5992..0aec5e8ffd96 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -132,6 +132,7 @@ static const struct mssr_mod_clk r8a779f0_mod_clks[] __initconst = {
 	DEF_MOD("sys-dmac1",	710,	R8A779F0_CLK_S0D3_PER),
 	DEF_MOD("wdt",		907,	R8A779F0_CLK_R),
 	DEF_MOD("pfc0",		915,	R8A779F0_CLK_CL16M),
+	DEF_MOD("tsc",		919,	R8A779F0_CLK_CL16M),
 	DEF_MOD("ufs",		1514,	R8A779F0_CLK_S0D4_HSC),
 };
 
-- 
2.35.1

