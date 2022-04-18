Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB22C43217
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 13:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbiDRNsR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbiDRN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C4B4091D;
        Mon, 18 Apr 2022 05:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E949961254;
        Mon, 18 Apr 2022 12:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCECDC385A1;
        Mon, 18 Apr 2022 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650286446;
        bh=MIc6Qg8gQ/Ha65kerfjhPUV40AaPn9yZ72gnUp8pj+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IW1UdWbPmTfJmdlCQn7FvzFjkYRGBdYmOwbrpgam9veH2/LAUzrURwQMwWkc5K7oq
         VMD6tgnLmNLqqZ1Bs6nfqnBzc+Rfj9uX999XRjnNjLlOGWzOappUar+ONSlc1OGE7i
         x/saU+/cLP+YZbnFbZCNFsmvYLJT2X5KOG564CXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 138/284] clk: clps711x: Terminate clk_div_table with sentinel element
Date:   Mon, 18 Apr 2022 14:11:59 +0200
Message-Id: <20220418121215.350394567@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121210.689577360@linuxfoundation.org>
References: <20220418121210.689577360@linuxfoundation.org>
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
index 9193f64561f6..4dcf15a88269 100644
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



