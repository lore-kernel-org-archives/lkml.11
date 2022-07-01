Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 03:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiGAD5g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 23:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiGAD5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:57:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E4565D5D;
        Thu, 30 Jun 2022 20:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656647851; x=1688183851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=klSCldDs6cMnRSDmczHw93+5saZgm5dnsNrQZ/blOHE=;
  b=ctTT9TsOCN/HsXOqz1BDERVPZLeQBzVqxVbR2TpPQekgOBKpoXIg2qzs
   ufbNdbL40HiF0RAD6KVWRGMq+PbycCC3AyA+BQ43tPr+6GC0E9nT6n/wD
   DhCG8InjXwJIvVAh7eu27ghuhet3ALM5waUH524WAWYIo4lA+3BKUX7vR
   1SZnD9pNVkLMI2Mka0KUZazp7Mtv5yOozT5yv4O1girPBRC5rLMfTtXbC
   ApiE1PWyxTFN/ny+tOCDpSwg2JjfRAsq+iOq+Lty0yenhSiQTWk4AJ8pY
   E5VWtj1iVB12f2YZWx84XD/UKAO/jMscmAvZ5mC38e7uqKSjFECuKBrvB
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="170630192"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 20:57:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 20:57:30 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 20:57:25 -0700
From:   Divya Koppera <Divya.Koppera@microchip.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <Madhuri.Sripada@microchip.com>
Subject: [PATCH v3 net-next 1/2] dt-bindings: net: Updated micrel,led-mode for LAN8814 PHY
Date:   Fri, 1 Jul 2022 09:27:08 +0530
Message-ID: <20220701035709.10829-2-Divya.Koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220701035709.10829-1-Divya.Koppera@microchip.com>
References: <20220701035709.10829-1-Divya.Koppera@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable led-mode configuration for LAN8814 phy

Signed-off-by: Divya Koppera <Divya.Koppera@microchip.com>
---
v2 -> v3:
- No change

v1 -> v2:
- Updated micrel,led-mode property for LAN8814 PHY
---
 Documentation/devicetree/bindings/net/micrel.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
index a9ed691ffb03..a407dd1b4614 100644
--- a/Documentation/devicetree/bindings/net/micrel.txt
+++ b/Documentation/devicetree/bindings/net/micrel.txt
@@ -16,6 +16,7 @@ Optional properties:
 	KSZ8051: register 0x1f, bits 5..4
 	KSZ8081: register 0x1f, bits 5..4
 	KSZ8091: register 0x1f, bits 5..4
+	LAN8814: register EP5.0, bit 6
 
 	See the respective PHY datasheet for the mode values.
 
-- 
2.17.1

