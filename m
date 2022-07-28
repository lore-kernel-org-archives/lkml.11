Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D252EC04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 14:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiG1OxT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiG1OxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:53:09 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62A5D0FA;
        Thu, 28 Jul 2022 07:53:05 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ABBF56000B;
        Thu, 28 Jul 2022 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1659019982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfRFgIm9TD823qNLzMMh6i2HmzOFrr2qvhJOGCSLGw8=;
        b=LvInS2Igr/SwKW/LEc8udAuBQkdClSN/n/IysqCQ6t5P73M8SlYHqK6iBh/QT5BWb5LZMW
        yuWATT+wzFU2K7GVMQ/RlErmHItWsL3grrRdxaO+50sg0467qjDLW+8tzHRYBSohPXSaQs
        uc/rrZV3UWkSM9cciPc0Z6lY14TRs9tKw62fEPfhA2tMy2b8QcZKUU7RXCtLO6R4IFqtLn
        KXza+WxrPfRQWSJWCAhRVWwTZjh4/swlkwRDD8rI22BxPcWjj9eUOebT5U0H2V4w1ccQEa
        VK+LRY2zNPpTLzG3zFKu5cRJvZCk3+F0FKUeoF5wROP61KLsIeuW+0JGAlIfSA==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Horatiu.Vultur@microchip.com,
        Allan.Nielsen@microchip.com, UNGLinuxDriver@microchip.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH net-next 2/4] dt-bindings: net: ethernet-controller: add QUSGMII mode
Date:   Thu, 28 Jul 2022 16:52:50 +0200
Message-Id: <20220728145252.439201-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728145252.439201-1-maxime.chevallier@bootlin.com>
References: <20220728145252.439201-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new QUSGMII mode, standing for "Quad Universal Serial Gigabit
Media Independent Interface", a derivative of USGMII which, similarly to
QSGMII, allows to multiplex 4 1Gbps links to a Quad-PHY.

The main difference with QSGMII is that QUSGMII can include an extension
instead of the standard 7bytes ethernet preamble, allowing to convey
arbitrary data such as Timestamps.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V1->V2 : Added Rob's acked-by

 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 56d9aca8c954..eb69a720575f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -67,6 +67,7 @@ properties:
       - gmii
       - sgmii
       - qsgmii
+      - qusgmii
       - tbi
       - rev-mii
       - rmii
-- 
2.37.1

