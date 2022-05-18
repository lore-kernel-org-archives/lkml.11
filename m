Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF4C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 11:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiERLtN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiERLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:49:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF263179C19;
        Wed, 18 May 2022 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652874549; x=1684410549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d9QZeZd2/xhOso7dWnKP7HbWb4p7FSS+gP0Yr1dxXPE=;
  b=2Fnye8GT2IwDRrc2mJpNP4eaFGygTEA/zVmqmHY8yVcFcjIhVhTxGoHn
   yA57sU1i3vVrC996BPFB03A0CT8BpU2d+yq6XCnjpKrqXXaf0h/of5oLR
   5Z35jGp35KD44JaAJ0RprWnKYxzIrzy5pEF/G1iWsnwtZqqPLGREjMyTf
   T8ZNdlDH7tbjwn7+l4HOlQjerz1tDb0sP9+tyCZU7dSafsf88DtYonL+7
   zr+QEWKVhepIdAbE55VSayC1dBe75wKLwDESxpDmqUyAxzUI2qgTQuzCC
   5lUvLzmoA5zZkcVoG0pvoJfkBjBm3Vb1jvVpKxmBQZksrLx6u/SybR93o
   g==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="164583728"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2022 04:49:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 18 May 2022 04:49:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 18 May 2022 04:49:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/2] nvmem: add Microchip OTP controller
Date:   Wed, 18 May 2022 14:51:27 +0300
Message-ID: <20220518115129.908787-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Microchip OTP controller available on
SAMA7G5. The driver gives access to a non-volatile memory which
keeps (at the moment) information like booting media and temperature
calibration data used for thermal measurements.

Thank you,
Claudiu Beznea

Changes in v3:
- fixed Documentation and binding files names
- used __maybe_unused for mchp_otpc_ids

Changes in v2:
- updated the bindings (patch 1/2) as follows:
	- included the device name in files names and updated binding
	  content accordingly
	- updated the description
	- removed address-cells, size-cells
	- removed clock include
	- use GPL-2.0 OR BSD-2-Clause license
	- removed OTP_PKT_SAMA7G5_TEMP_CALIB_LEN and keep hardcoded
	  value in examples
	  
- updated MAINTAINERS file with new naming of bindings

Claudiu Beznea (2):
  dt-bindings: microchip-otpc: document Microchip OTPC
  nvmem: microchip-otpc: add support

 .../nvmem/microchip,sama7g5-otpc.yaml         |  50 +++
 MAINTAINERS                                   |   8 +
 drivers/nvmem/Kconfig                         |   7 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/microchip-otpc.c                | 288 ++++++++++++++++++
 .../nvmem/microchip,sama7g5-otpc.h            |  12 +
 6 files changed, 367 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 create mode 100644 drivers/nvmem/microchip-otpc.c
 create mode 040000 include/dt-bindings/nvmem
 create mode 100644 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h

-- 
2.34.1

