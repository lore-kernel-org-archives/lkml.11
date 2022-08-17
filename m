Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90957C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 12:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiHQMdU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiHQMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:33:07 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261D1EA;
        Wed, 17 Aug 2022 05:33:05 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7637F1C0009;
        Wed, 17 Aug 2022 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660739584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMXi6tOgQ+Hza2wQKmYRJpoHYy7nWj7ZNMRDGHNfuhs=;
        b=Hrj3b4duKFd2X8gyFGwbdzXCDDLkREjlA0tvQjyvzpint+7hzfOJjJHNUf5AwNYdEaN9Ax
        MkJu1D4+PcbOB7oFPpPzACypPLWhRT3OZWjwz0JZYBpm56CNNn4h2SGBX3ZhQX9vs3gDyA
        HcVu3mw8YU9UA1bYI2xvFdD7ykkXHZiJWoGFtqdon4iprp7nv3FcxPqf7DC+xG0yoZsf9n
        rJIckEdfZJOz+lqSKt3Uk7t7kG8kDC2V0aEX7gpLYaDeOiIN5KzuiKSWRQ6DrOHgo3JRbo
        BPyEp2yPQ6IngUscoPr7KVt5SkLIlkfsxEuBLr8IkWuK0y9mvImSl9EJRmxEFA==
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Cochran <richardcochran@gmail.com>,
        Horatiu.Vultur@microchip.com, Allan.Nielsen@microchip.com,
        UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>
Subject: [PATCH net-next RESEND v4 2/4] dt-bindings: net: ethernet-controller: add QUSGMII mode
Date:   Wed, 17 Aug 2022 14:32:53 +0200
Message-Id: <20220817123255.111130-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817123255.111130-1-maxime.chevallier@bootlin.com>
References: <20220817123255.111130-1-maxime.chevallier@bootlin.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
V1->V2 : Added Rob's acked-by
V2->V3 : No changes
V3->V4 : Added Andrew's R'd-by

 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index c138a1022879..4b3c590fcebf 100644
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

