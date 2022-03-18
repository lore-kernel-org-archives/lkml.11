Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905DCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiCRKjD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiCRKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:38:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5592B2D6CB0;
        Fri, 18 Mar 2022 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NOCVQhUNKqYuftcCpzIFBLFpAI3pFErVuvbVbXOBjdY=;
  b=nuM9xo79qDnHYFR+X74N64xZdR15CxdhMLTGuqsVRkrtwbeckfZa00wK
   fuKB1DWWje5jAukD9aTIzKqskWAE+XnbLIO8OUHWll9heT8sxR+1iG4OF
   tM+Y5GYWgFo/lh8QW/5fHCHr2b7We8GbUARXKLk4322lLJahw0+IOHgUc
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935631"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:35 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kernel-janitors@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ARM] orion5x: fix typos in comments
Date:   Fri, 18 Mar 2022 11:36:58 +0100
Message-Id: <20220318103729.157574-3-Julia.Lawall@inria.fr>
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
 arch/arm/mach-orion5x/dns323-setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 87cb47220e82..d69259b6b60d 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -696,12 +696,12 @@ static void __init dns323_init(void)
 			pr_err("DNS-323: failed to setup power-off GPIO\n");
 		pm_power_off = dns323c_power_off;
 
-		/* Now, -this- should theorically be done by the sata_mv driver
+		/* Now, -this- should theoretically be done by the sata_mv driver
 		 * once I figure out what's going on there. Maybe the behaviour
 		 * of the LEDs should be somewhat passed via the platform_data.
 		 * for now, just whack the register and make the LEDs happy
 		 *
-		 * Note: AFAIK, rev B1 needs the same treatement but I'll let
+		 * Note: AFAIK, rev B1 needs the same treatment but I'll let
 		 * somebody else test it.
 		 */
 		writel(0x5, ORION5X_SATA_VIRT_BASE + 0x2c);

