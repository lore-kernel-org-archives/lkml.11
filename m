Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24820C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiCIUYi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiCIUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:24:35 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E7AADB859
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:23:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,168,1643641200"; 
   d="scan'208";a="113004005"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2022 05:23:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F1C48400F7BE;
        Thu, 10 Mar 2022 05:23:33 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RESEND PATCH] platform: goldfish: pipe: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 20:23:27 +0000
Message-Id: <20220309202327.16627-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
original patch [0].

[0] https://lore.kernel.org/lkml/20211224161334.31123-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/platform/goldfish/goldfish_pipe.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index b67539f9848c..7737d56191d7 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -896,11 +896,9 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r)
-		return -EINVAL;
-
-	dev->irq = r->start;
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq < 0)
+		return dev->irq;
 
 	/*
 	 * Exchange the versions with the host device
-- 
2.17.1

