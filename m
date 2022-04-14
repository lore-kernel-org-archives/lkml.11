Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E11C352AA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbiDNNnV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbiDNN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:28:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE879A988;
        Thu, 14 Apr 2022 06:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAD12B82987;
        Thu, 14 Apr 2022 13:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2708FC385A9;
        Thu, 14 Apr 2022 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942530;
        bh=XdxmLBFvxH+2a1PCMVWvLDgA3hrE3fluzsZWPW7qf8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w2JL09BW+Rn45kd7McTA4NJpOxBb1tQsqcuy02jQwaAFESlvz64FdVk2UzCplUtEc
         OQnNWxPFvmV4BjuImy7TlhwiHajHZziSH6HImSsIAl/05okOfPfjUFLn4DUgmXiy2k
         eL7QERM4icprGQeLqUr7UmQjhJ9b2KKrlvzA9BDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 170/338] clk: clps711x: Terminate clk_div_table with sentinel element
Date:   Thu, 14 Apr 2022 15:11:13 +0200
Message-Id: <20220414110843.737325742@linuxfoundation.org>
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

[ Upstream commit 8bed4ed5aa3431085d9d27afc35d684856460eda ]

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div = 0).

Fixes: 631c53478973d ("clk: Add CLPS711X clk driver")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Link: https://lore.kernel.org/r/20220218000922.134857-5-j.neuschaefer@gmx.net
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-clps711x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index 2c04396402ab..50b42e91a137 100644
--- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -32,11 +32,13 @@ static const struct clk_div_table spi_div_table[] = {
 	{ .val = 1, .div = 8, },
 	{ .val = 2, .div = 2, },
 	{ .val = 3, .div = 1, },
+	{ /* sentinel */ }
 };
 
 static const struct clk_div_table timer_div_table[] = {
 	{ .val = 0, .div = 256, },
 	{ .val = 1, .div = 1, },
+	{ /* sentinel */ }
 };
 
 struct clps711x_clk {
-- 
2.34.1



