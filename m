Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E92BC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 14:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiF3OTV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiF3OSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:18:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6DC5072F;
        Thu, 30 Jun 2022 07:02:49 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9D0F42224D;
        Thu, 30 Jun 2022 16:02:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656597767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12Z1dZv/k/yp4l3O9HLH7NjySFJLvOxGysIjdKUevr8=;
        b=AKQpvAMWVQwCaE1ZFZAXrVaId7Qck7dGHqzTvkcDIcjrhcLRnIvEO9vNg0yGsISkBs9+BN
        P6L1CYp2ULKGDaSvQMVyjNpjiFIEpxQmfV9VA6DFKdyQlxpUn2NHSHFDnMgvIMn3Pf/pQW
        D/+h+G//ZN11p1qUyNEUJQoDU17NXSw=
From:   Michael Walle <michael@walle.cc>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH net-next 2/4] dt-bindings: net: lan966x: add specific compatible string
Date:   Thu, 30 Jun 2022 16:02:35 +0200
Message-Id: <20220630140237.692986-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630140237.692986-1-michael@walle.cc>
References: <20220630140237.692986-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a specific compatible string for the LAN9668 and deprecate the old
one.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../devicetree/bindings/net/microchip,lan966x-switch.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
index dc116f14750e..efd6bbd51d68 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
@@ -20,7 +20,10 @@ properties:
     pattern: "^switch@[0-9a-f]+$"
 
   compatible:
-    const: microchip,lan966x-switch
+    oneOf:
+      - const: microchip,lan9668-switch
+      - const: microchip,lan966x-switch
+        deprecated: true
 
   reg:
     items:
-- 
2.30.2

