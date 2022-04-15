Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C5AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 12:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353834AbiDOM4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353483AbiDOM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:56:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77155BF51A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650027239; x=1681563239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLw1mhSx4JnJWY7T9B+yYOnuF2rUPtAaGFAVz/XWDdQ=;
  b=NDkzkC/qo4ldW/qfWKIyveB9/I2Hs4qKNcOWuSOZezqPX0JuOTYcKvkM
   UTYkAfend0HcvJVnIq0GS+szTHVsFLXle21c96IHbA28jHipjspJY2zVQ
   kH/QwoxgtKaGpUjcsvhuUFC8FY9uGlrXsrSrzjRFwR9PucpzuKO5Vk0k5
   jTUByUYnvRO7HNEWgd/qZHG3N/ntg3qNjYBzQED4HyvJ9x40pO8ilpnBe
   WxW8fEvY+MqPdfy9ZUJBT5i1dyMUYyLNMzZx/ApZTfzPEnLJ8zBUw2CL9
   TitSVyJgtqdz+9Sw1FIkdOjJagZAN6bOYk1H5dAacYW6PjhWOwDizW4sv
   g==;
X-IronPort-AV: E=Sophos;i="5.90,262,1643698800"; 
   d="scan'208";a="155680097"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2022 05:53:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Apr 2022 05:53:58 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 15 Apr 2022 05:53:56 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1 3/4] riscv: select vitesse phy driver for polarfire soc
Date:   Fri, 15 Apr 2022 13:52:21 +0100
Message-ID: <20220415125221.2871991-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415125221.2871991-1-conor.dooley@microchip.com>
References: <20220415125221.2871991-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a Vitesse VSC8662 on the Icicle Kit, until a better option
exists, select it in Kconfig.socs for SOC_MICROCHIP_POLARFIRE.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

---
Palmer: You said to put in a comment, but I have no idea how Kconfig
expects a mid line comment to look. kbuild didn't seem to complain about
what I did, but lmk if that's not what you meant.
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 7f93c729d51c..ff2b8b90db19 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -8,6 +8,7 @@ config SOC_MICROCHIP_POLARFIRE
 	select HW_RANDOM_POLARFIRE_SOC if POLARFIRE_SOC_SYS_CTRL
 	select PCIE_MICROCHIP_HOST if PCI_MSI && OF
 	select SIFIVE_PLIC
+	select VITESSE_PHY # present on icicle kit
 	help
 	  This enables support for Microchip PolarFire SoC platforms.
 
-- 
2.35.2

