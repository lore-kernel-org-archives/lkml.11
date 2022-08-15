Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15427C32757
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 00:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348519AbiHPAOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 20:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354935AbiHPAAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F434A83E;
        Mon, 15 Aug 2022 13:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6126160F71;
        Mon, 15 Aug 2022 20:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A77C433D7;
        Mon, 15 Aug 2022 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660594930;
        bh=Uwyp5EW6TYI61pBEDHY7/etR6TOT11hZlllBdjAsKrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTP846YyrBLJaRAgPjT3LgSHOLvaDJKbl3sTEbowTttIupkM5qsLjik5GZqdhamlz
         NCB7cesEF4z3RWmM/kWVEtvzOB/J0kU+73orbFNACNxidVS96hbmOfPKWjgM8rISxh
         n2VWJLqhr52ICGqehCf/9j+Px6uo14OG99ZULa9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 0603/1157] mtd: st_spi_fsm: Warn about failure to unregister mtd device
Date:   Mon, 15 Aug 2022 19:59:19 +0200
Message-Id: <20220815180503.791225435@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit cfa7847f150c4343903d8ff2cd219418c1768205 ]

mtd_device_unregister() shouldn't fail. Wail loudly if it does anyhow.

This matches how other drivers (e.g. nand/raw/nandsim.c) use
mtd_device_unregister().

By returning 0 in the platform remove callback a generic error message
by the device core is suppressed, nothing else changes.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20220607152458.232847-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 52a799cae402..a5a4b612480c 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2130,7 +2130,9 @@ static int stfsm_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(fsm->clk);
 
-	return mtd_device_unregister(&fsm->mtd);
+	WARN_ON(mtd_device_unregister(&fsm->mtd));
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.35.1



