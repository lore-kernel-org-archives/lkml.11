Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E03C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 11:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiB1LTG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiB1LTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:19:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5C33E0E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646047098; x=1677583098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f4Nrz9dIH23N9eynJ8+1s6zi/1CqtZ4Uc7jqZDael5k=;
  b=RqXD0QttI2GoQNRff1+2iU8baYkI0J670bD+FVT7dBIkDSDJ2RY20wTW
   B6sRaJU8+Dcs0A5ahPGxlj3qz2dfNz/4VXD8FNsNFbDTMVKrWt0okeXYg
   mBC1eFJcvc0+k0l2KLkTIVgy78E1hLvLuPxR/Qs7KClCnZlok8NTImpsE
   wDux8ITC7JGGxmNHkN/0I2Dkfsmwd7UaNT3WBz+CAyUm/JMIqGAsdK791
   ZQxgrcSAEXP55sQPlmNhxrrQCh/7iBUOmJvnSVWf9E4EYW0M33aHB7OeY
   SqVVTabu+nKq3ZTcjW26NNO7JS2g8m0qjAPThlKtOTo/FKbi5Ryno/Kmm
   A==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="150223316"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 04:18:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 04:18:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 04:18:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/7] clocksource/drivers/timer-microchip-pit64b: fixes and improvements
Date:   Mon, 28 Feb 2022 13:19:16 +0200
Message-ID: <20220228111923.1400049-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series adds one fix and few improvement for PIT64B timer. Patches 1/7
and 2/7 were initially posted at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210707054415.92832-1-claudiu.beznea@microchip.com/

Claudiu Beznea (7):
  clocksource/drivers/timer-microchip-pit64b: remove mmio selection
  clocksource/drivers/timer-microchip-pit64b: remove timer-of depenency
  clocksource/drivers/timer-microchip-pit64b: use notrace
  clocksource/drivers/timer-microchip-pit64b: use 5MHz for clockevent
  clocksource/drivers/timer-microchip-pit64b: add delay timer
  clocksource/drivers/timer-microchip-pit64b: remove suspend/resume ops
    for ce
  clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
    resume}

 drivers/clocksource/Kconfig                  |  2 -
 drivers/clocksource/timer-microchip-pit64b.c | 67 ++++++++++----------
 2 files changed, 35 insertions(+), 34 deletions(-)

-- 
2.32.0

