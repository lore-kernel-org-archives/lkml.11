Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F1EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 11:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiDKLU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343721AbiDKLUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:20:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34D427D5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649675912; x=1681211912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b8MRCdA9KkHqlIOxp7L+60IpEhaonoO7aCn57xUekUA=;
  b=YfqAEq2Re7Y9V1+2NnkWsJHMz3NgVZB4giRi5gZL8royePRxUgT8OJVt
   rEDQmvYOZ2e2xybv30CTAvgFRONpdTtj52B0qFifgbGN8EBb1hh6EFchU
   IE7UU/MRp73bsZ/L1W+CD6qUY/wl9mUyT/X16sJ+YRuXZ7MDNwqPDDyG2
   6wM+AkKqPZMHs5PT72BRmGSxaOPSigxCkisY2I2bTDb0lB9rJCPZpwOpT
   4YM3Hhvxj2Mg4qdWX4qJAmpfDKIGRTDcjEbnF0TkpNWMbrloN9ijHA0Ft
   VzG6937lY6O9Zqz3RS3w++iqoehhbpB2f4RsV9pFs+O6I35hZhy8F/cUy
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="159637089"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 04:18:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 04:18:30 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 04:18:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/4] ARM: at91: pm: add quirks for ethernet
Date:   Mon, 11 Apr 2022 14:20:53 +0300
Message-ID: <20220411112057.35369-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As described in patch 3/4 when receiving WoL packet on Ethernet
interfaces of AT91 SoCs and being in ULP0 or ULP1 AT91 specific power
management modes some SoCs may block other may have Ethernet interfaces
broken after resume. Workaround for this would be to disable clocks
for these Ethernet interfaces. As the MACB driver is common to multiple
vendors and multiple architectures and ULP0, ULP1 PM modes are AT91
specific the fix has been implemented in arch/arm/mach-at91 to avoid
having AT91 specific code in MACB driver.

Along with this patches I took the chance and added few comment style
fixups.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  ARM: at91: pm: keep documentation inline with structure members
  ARM: at91: pm: introduce macros for pm mode replacement
  ARM: at91: pm: add quirks for pm
  ARM: at91: pm: use kernel documentation style

 arch/arm/mach-at91/pm.c | 367 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 334 insertions(+), 33 deletions(-)

-- 
2.32.0

