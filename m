Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD876C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiCRKlu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4732DB58F;
        Fri, 18 Mar 2022 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2DBVpcWqFxcFlEDwQiq6YPZcJSBswn4FE/keWJjPvpI=;
  b=p7ifbamivs9n+VS1mJlBehAZNZ4xHumjKtxWTiyX20VdZV6HgtUWb8sI
   6uawgaWBBasp612qGOZuPzbpnyqd5pfuyzT6VoH7XWspAGq/WMEuVwz83
   qFBdrP/hps4Xt3mdknJBhtQWbLjCFBH3K559rub3tgddQyOpV9XM7P6OZ
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935649"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:37 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Russell King <linux@armlinux.org.uk>
Cc:     kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: footbridge: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:12 +0100
Message-Id: <20220318103729.157574-17-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arm/mach-footbridge/netwinder-hw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index 5f7265b1b34c..8dfe5ea444f2 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -311,7 +311,7 @@ static inline void wb977_init_gpio(void)
 	wb977_wb(0xf3, 0x00);
 
 	/*
-	 *  - timer counting, disable power LED, disable timeouot
+	 *  - timer counting, disable power LED, disable timeout
 	 */
 	wb977_wb(0xf4, 0x00);
 

