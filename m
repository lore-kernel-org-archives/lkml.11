Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 06:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiCBGu0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbiCBGuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:50:24 -0500
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D360FB2D47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 22:49:41 -0800 (PST)
X-QQ-mid: bizesmtp85t1646203776tsb0g33c
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2022 14:49:30 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: k0yT7W7BRd3MzEiYMTxrG2j/y88AhpCDT+sqVUh1avdCEIRjXGoPWiinn5Vv2
        WnDqa5/UO5PnzAX60YMdeg8ZeADZD+STq4TvOE++xJM4IzrpTwx3m1EQsTyBjudyLDtGCeS
        6E4AudBW6D0Wd6/O9nysdaiw/qi94++aJ+MJMfr3qgNoTbdPP1dLEvu4/HC8j4i4d7WjaZQ
        wmMQynnRoABzTdSUfyjp5ctIYxKJAzqy4nGK7PwyeECUMG9xm+iP/QZbwg1EoqE1i5UYAS8
        T8JC5LhxTJ2PIOA/R6XxTi/fsF6q5t0NUdi52kZKasP63vmDuh7cxwHPgkHeFBLnbMARaJP
        Uu0DZGFq5GXJTjQbX4DTzJE0u/8zHuiSkddl8+M
X-QQ-GoodBg: 1
From:   sujiaxun <sujiaxun@uniontech.com>
To:     jack@suse.cz
Cc:     ira.weiny@intel.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, sujiaxun <sujiaxun@uniontech.com>
Subject: [PATCH] goldfish_pipe: Use platform_get_irq() to get the interrupt
Date:   Wed,  2 Mar 2022 14:49:28 +0800
Message-Id: <20220302064928.21840-1-sujiaxun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index b67539f9848c..0256f76dfe5d 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -896,12 +896,10 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}

-	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r)
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq < 0)
 		return -EINVAL;

-	dev->irq = r->start;
-
 	/*
 	 * Exchange the versions with the host device
 	 *
--
2.20.1



