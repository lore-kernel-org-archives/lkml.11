Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86335C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiF3PJp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiF3PJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:09:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E9A23BE6;
        Thu, 30 Jun 2022 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656601783; x=1688137783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=490UQ/S4WPhQztK6/L27SCK5QtW6XY8LWsmZNaqG4es=;
  b=dLh5SXhNuIjio7HZwzOxObDfY7wZz2emFVccO7ZGsovBWU8GMg9fwGMe
   dFXo8iwPUlgisBgRz69+SAUX6FyT1kIifATNasxZpAqiYwWr+jCYO5b9L
   hqLd6ztPkMDiRyHOcQOU9PpDG2hRnQy3QEilRyLRu1oBQUIOlHgJGMPBw
   P5iON+4OvBvOiOEZNAnIa6DNSLalKJ9/GwChBfFxBAm8mpCzSDpksZKPq
   +zYqDD4/D5HM+8DydEQlT6tz7A6JkQu4ptABTfRsLemGEVCva1ky+5WJg
   KYBJAGIl2sWYqTxmoSlQKmgK2v9t64JdEhN0kZ6r/n7EZ1JPwVViV60Nu
   w==;
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="165854325"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 08:09:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 08:09:39 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 08:09:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] clk: remove extra empty line
Date:   Thu, 30 Jun 2022 18:12:04 +0300
Message-ID: <20220630151205.3935560-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra empty line.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7fc191c15507..1cff79a7f8a4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3672,7 +3672,6 @@ static int __clk_core_init(struct clk_core *core)
 
 	clk_core_reparent_orphans_nolock();
 
-
 	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
-- 
2.34.1

