Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B0C4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiDEJ3I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbiDEIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259AF6B;
        Tue,  5 Apr 2022 01:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F3D8B81BB1;
        Tue,  5 Apr 2022 08:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDC2C385A1;
        Tue,  5 Apr 2022 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146531;
        bh=di7Ywnyc7PQuSoaczewXq/7OS/GDikrcKHmRBrlnno4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3lnjFksrur3sCjth4vC8I5oTliF+Bg3v/0oS7TMbwofHZraCQS8ZZEjk3gTxA1BX
         tmnY//frA9+TjY76Y/YWV9PadIFijgmY8iqWOk4HlxeW4rrRNILKpZoLK6IXcdxQ9S
         PegI7/eD0BLMoHB53RkjHbNCQx1CYrEPKCoNRb7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0759/1126] clk: Fix clk_hw_get_clk() when dev is NULL
Date:   Tue,  5 Apr 2022 09:25:06 +0200
Message-Id: <20220405070429.861668196@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime@cerno.tech>

[ Upstream commit 0c1b56df451716ba207bbf59f303473643eee4fd ]

Any registered clk_core structure can have a NULL pointer in its dev
field. While never actually documented, this is evidenced by the wide
usage of clk_register and clk_hw_register with a NULL device pointer,
and the fact that the core of_clk_hw_register() function also passes a
NULL device pointer.

A call to clk_hw_get_clk() on a clk_hw struct whose clk_core is in that
case will result in a NULL pointer derefence when it calls dev_name() on
that NULL device pointer.

Add a test for this case and use NULL as the dev_id if the device
pointer is NULL.

Fixes: 30d6f8c15d2c ("clk: add api to get clk consumer from clk_hw")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20220225143534.405820-2-maxime@cerno.tech
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8de6a22498e7..fff5edb89d6d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3773,8 +3773,9 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *con_id)
 {
 	struct device *dev = hw->core->dev;
+	const char *name = dev ? dev_name(dev) : NULL;
 
-	return clk_hw_create_clk(dev, hw, dev_name(dev), con_id);
+	return clk_hw_create_clk(dev, hw, name, con_id);
 }
 EXPORT_SYMBOL(clk_hw_get_clk);
 
-- 
2.34.1



