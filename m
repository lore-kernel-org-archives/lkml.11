Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12768C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiCRKky (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiCRKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F22DC009;
        Fri, 18 Mar 2022 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZphuoB39pL6xZZufQxzdnxdgS8zf0Im5X+oikwRjYcw=;
  b=g3CdAdWY9bJEc6RFC6ktvT1UJeVslcaFff1EvGy51J0tzj/mA/jo0+4f
   3/6EkUOcZLqmK7xbr+4N6PUQ0WHSoarPfLXbfSLWzyVexLj2WGIQUL+w5
   sqORu/9mIJDTZxaKZGj8ckd6aWYqOpyACFbDi8mVgRCNgBhdU2kBjcJXP
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935662"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:39 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Linus Walleij <linusw@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM/ixp4xx: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:21 +0100
Message-Id: <20220318103729.157574-26-Julia.Lawall@inria.fr>
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
 arch/arm/mach-ixp4xx/ixp4xx-of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/ixp4xx-of.c b/arch/arm/mach-ixp4xx/ixp4xx-of.c
index f9904716ec7f..f543e2adae0c 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx-of.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx-of.c
@@ -46,7 +46,7 @@ static void __init ixp4xx_of_map_io(void)
 }
 
 /*
- * We handle 4 differen SoC families. These compatible strings are enough
+ * We handle 4 different SoC families. These compatible strings are enough
  * to provide the core so that different boards can add their more detailed
  * specifics.
  */

