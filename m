Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03669C3527D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349169AbiDNOw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbiDNNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:45:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F839AE60;
        Thu, 14 Apr 2022 06:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4BCEB82984;
        Thu, 14 Apr 2022 13:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024C7C385A5;
        Thu, 14 Apr 2022 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943712;
        bh=AdvVmCIdrOgXqw+YRL1khi95cYKRNTPGjWol261pppE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjPiO9uhmS35KZqlwsFWPgIAd92jz0d6geh9Sg0N2rARO1WAkD7o2MGHOfliJL3We
         I/mjBHWcnXNSjpb783AvHMQCpkzNBOvDZqp+NlOBdwl6JwUgLOb76c+N9Qb9hJef1H
         P8rMIK93FYJGsa5VO0uoMmPsQRHV/W9AFrG96qSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 253/475] pinctrl: nomadik: Add missing of_node_put() in nmk_pinctrl_probe
Date:   Thu, 14 Apr 2022 15:10:38 +0200
Message-Id: <20220414110902.192567034@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
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
index 2a8190b11d10..9f00adfefba8 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1923,8 +1923,10 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
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



