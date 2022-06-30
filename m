Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C150C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 08:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiF3IIu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiF3IIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:08:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6913541994;
        Thu, 30 Jun 2022 01:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656576481; x=1688112481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJyjWXL9c84MeJXb2RPk2+RjYUjKmqKhd+L3kczClrw=;
  b=efjihBmvNcddaX3OzHpx9OlYnoBlBKbiw4CH8j5G3fbMprZzRE2mvB+d
   GzN6AqGGXi+8wK5U7xlDGvIhy68xXJqeXXpyNZmwgB1KKoOJXVgHYmJeP
   mu25iOyOsLRg0Hq8rGtvHgZPYMMq3ZUpi2gFG41cnn4rbhbAhunLqIclt
   e0Fck/UyKRgn6bSuYJdQ0caB9EelWI7sXDviEZCeINH9CL9lXA6IV3/yi
   WK5qv6lxm6tEIGDdc1QTWs/vp3vu47XRx88DZtoKqmmzuf+RFZcOJvYhz
   qbxsBi4+WlLppKweIwbRUqdJSCQwDO4gmju1ia0/91s6D8SeAaDYdRQpC
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="180158552"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 01:08:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 01:08:00 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 30 Jun 2022 01:07:56 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v1 08/14] clk: microchip: mpfs: add module_authors entries
Date:   Thu, 30 Jun 2022 09:05:27 +0100
Message-ID: <20220630080532.323731-9-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630080532.323731-1-conor.dooley@microchip.com>
References: <20220630080532.323731-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself and Daire as authors since we were mainly responsible for the
drivers development.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index a93f78619dc3..c7cafd61b7f7 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Daire McNamara,<daire.mcnamara@microchip.com>
- * Copyright (C) 2020 Microchip Technology Inc.  All rights reserved.
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ *
+ * Copyright (C) 2020-2022 Microchip Technology Inc. All rights reserved.
  */
 #include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
@@ -605,4 +607,6 @@ static void __exit clk_mpfs_exit(void)
 module_exit(clk_mpfs_exit);
 
 MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Driver");
+MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.36.1

