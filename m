Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 14:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiCDOIO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 09:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiCDOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:08:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC721B98A2;
        Fri,  4 Mar 2022 06:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646402838; x=1677938838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h9w5rLlIgRL6Mreid8VITmayzPDrxYRkE0AGDM00690=;
  b=jCU8wgwiGrGNTstL0sDdGIjVFFLz/n3TDnIx0L9bnbJOt7/xMAR+hoI6
   ZfEkN/RCErcdyGO5PaTZvQQeSBceG3knV/KYO5mb7XdHIXL5lJC5C4hYv
   MHNUqxNATqGe1CaPfoUvbCJO8GI5ZbXozabOxjTYzDrIuLoMjur8ED6+o
   DP6URGzlEvz4qGZdxaGg4Z+4TQc4YObs0riOI+Vulx6Hj1bxC/cfJDFx9
   ogrHzip5Aij8k4J8cnknhlxrs4vwB6rhSeo2Ad0S/S3sRKVagZXfg3ON7
   Qm8C/hhHNzyOIjf4YwpaxX4z1rCR6lxqQAOh8gKR41ixyDOfYWksXwAnZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="155731531"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:07:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:07:17 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 07:07:15 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: sparx5: Fix initialization of variables on stack
Date:   Fri, 4 Mar 2022 15:09:18 +0100
Message-ID: <20220304140918.3356873-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables 'res' inside the functions sparx5_ptp_get_1ppm and
sparx5_ptp_get_nominal_value was not initialized. So in case of the default
case of the switch after, it would return an uninitialized variable.
This makes also the clang builds to failed.

Fixes: 0933bd04047c3b ("net: sparx5: Add support for ptp clocks")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index fa377f6e7e08..cd110c31e5a4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -32,7 +32,7 @@ static u64 sparx5_ptp_get_1ppm(struct sparx5 *sparx5)
 	 * (1/1000000)/((2^-59)/X)
 	 */
 
-	u64 res;
+	u64 res = 0;
 
 	switch (sparx5->coreclock) {
 	case SPX5_CORE_CLOCK_250MHZ:
@@ -54,7 +54,7 @@ static u64 sparx5_ptp_get_1ppm(struct sparx5 *sparx5)
 
 static u64 sparx5_ptp_get_nominal_value(struct sparx5 *sparx5)
 {
-	u64 res;
+	u64 res = 0;
 
 	switch (sparx5->coreclock) {
 	case SPX5_CORE_CLOCK_250MHZ:
-- 
2.33.0

