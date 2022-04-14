Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81817C47082
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiDNNmw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245249AbiDNN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:28:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1560939E7;
        Thu, 14 Apr 2022 06:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23ADEB82989;
        Thu, 14 Apr 2022 13:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752B2C385A1;
        Thu, 14 Apr 2022 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942524;
        bh=g7u5c46HTzhJpUCUks5jtvsMOJEsJAjDWy0qYcMkP10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qESZyBMu3gKuTYQmckKySUj1XdtKY16gEDR0rBSBfz89C3nAGpvVind9NXxRv9y6L
         A3UAwUk+K/R/zoAK6IJoLYIu81leYL0U+q3HGq0a/nLTM5G+jvvXfvmCOTTD5YHKSP
         5weaJLDlE5p6zdrz225awFla8Jh/NEMgWYmpKO4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 168/338] clk: actions: Terminate clk_div_table with sentinel element
Date:   Thu, 14 Apr 2022 15:11:11 +0200
Message-Id: <20220414110843.681575567@linuxfoundation.org>
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

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

[ Upstream commit d8a441e53e2434b1401e52dfd66b05263e442edc ]

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div = 0).

In owl-s900.s, the { 0, 8 } element was probably meant to be just that,
so this patch changes { 0, 8 } to { 0, 0 }.

Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/20220218000922.134857-2-j.neuschaefer@gmx.net
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/actions/owl-s700.c | 1 +
 drivers/clk/actions/owl-s900.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index 5e9531392ee5..aa76b0c10373 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -160,6 +160,7 @@ static struct clk_div_table hdmia_div_table[] = {
 
 static struct clk_div_table rmii_div_table[] = {
 	{0, 4},   {1, 10},
+	{0, 0}
 };
 
 /* divider clocks */
diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
index 7f60ed6afe63..460b33fc6c54 100644
--- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -138,7 +138,7 @@ static struct clk_div_table rmii_ref_div_table[] = {
 
 static struct clk_div_table usb3_mac_div_table[] = {
 	{ 1, 2 }, { 2, 3 }, { 3, 4 },
-	{ 0, 8 },
+	{ 0, 0 }
 };
 
 static struct clk_div_table i2s_div_table[] = {
-- 
2.34.1



