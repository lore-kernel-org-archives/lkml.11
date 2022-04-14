Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF80C47082
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbiDNNoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbiDNN2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DCAC052;
        Thu, 14 Apr 2022 06:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5908061670;
        Thu, 14 Apr 2022 13:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE48C385AA;
        Thu, 14 Apr 2022 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942544;
        bh=2vfym5BrCqtDL9t7Aho8GcBZIQcYmCDrudsuTyXMNBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLhiCruGTH1i8y/EZsPateb82HgxMqph6R4geYsBu7Sj+JQs9UR4Y+6wkpEGN4c5I
         8Y/ZxW/HUtXhlX2JmApIVcdtYf+T+Sn4fTw3xgC7ywZm5aSNAIv7RqIgmbUzNFvjS2
         mOuH4Ytz4qm8nsWF9GhJ6C+C+uixBPRJXobTRres=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 174/338] pinctrl: nomadik: Add missing of_node_put() in nmk_pinctrl_probe
Date:   Thu, 14 Apr 2022 15:11:17 +0200
Message-Id: <20220414110843.850157212@linuxfoundation.org>
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

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit c09ac191b1f97cfa06f394dbfd7a5db07986cefc ]

This node pointer is returned by of_parse_phandle() with refcount
incremented in this function. Calling of_node_put() to avoid
the refcount leak.

Fixes: 32e67eee670e ("pinctrl: nomadik: Allow prcm_base to be extracted from Device Tree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220307115116.25316-1-linmq006@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index f0e7a8c114b2..415e91360994 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1916,8 +1916,10 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	prcm_np = of_parse_phandle(np, "prcm", 0);
-	if (prcm_np)
+	if (prcm_np) {
 		npct->prcm_base = of_iomap(prcm_np, 0);
+		of_node_put(prcm_np);
+	}
 	if (!npct->prcm_base) {
 		if (version == PINCTRL_NMK_STN8815) {
 			dev_info(&pdev->dev,
-- 
2.34.1



