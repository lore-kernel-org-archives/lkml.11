Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2786C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 13:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiFGNZN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiFGNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:25:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1CBDA2E;
        Tue,  7 Jun 2022 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654608305; x=1686144305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MOFAIB4idNl1d6FFDW2qmFiKFnGtOntEzXMoocV2Urs=;
  b=eeD6DozYrczuDSXMDPeBKiUfn0Bds6oE9ZdJJ9hDkyQtQzpwCBR06BiG
   wAqiDw4WEwtgiTyP7HgdA9RAyxLPV49N62LT+2cz7itHM7TMoqaQJfmfN
   Kfb41Y85vjNWUlQruNCtUdWbCJBEQof+jnGYn4IhfwKjuCP/2DwwFGWR/
   imkb07QRR8E7Qxn0IgrdYuetczP7nvbIsdP8KxCgqajsIPL2+9wJXqLBx
   8j6v15p/W0i3A8Jm4UWIazNqYfwHC2KM6+LyWu+cqw4/vHcot60zRqjop
   LtT6sbevNOngqT/wEY/IvSqXIarUoBU9d2jB54Y+Tp48yBm0rkKPH4NN8
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="98929239"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 06:25:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 06:25:00 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 06:24:58 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 0/3] Add support for PolarFire SoC's musb controller
Date:   Tue, 7 Jun 2022 14:22:01 +0100
Message-ID: <20220607132204.746180-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bin, Greg,
Short series here adding support for USB on Microchip PolarFire SoC FPGAs.
The kconfig dependancy for INVENTRA_DMA has become a bit of a mouthful,
is there a better way of dealing with that?
Thanks,
Conor.

Conor Dooley (3):
  usb: musb: Add support for PolarFire SoC's musb controller
  MAINTAINERS: add musb to PolarFire SoC entry
  riscv: dts: microchip: fix icicle kit's dr_mode

 MAINTAINERS                                   |   1 +
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |   2 +-
 drivers/usb/musb/Kconfig                      |  13 +-
 drivers/usb/musb/Makefile                     |   1 +
 drivers/usb/musb/mpfs.c                       | 285 ++++++++++++++++++
 5 files changed, 300 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/musb/mpfs.c

-- 
2.36.1

