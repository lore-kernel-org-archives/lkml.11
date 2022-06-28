Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8137FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 07:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiF1HKQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiF1HKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:10:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46362715A;
        Tue, 28 Jun 2022 00:10:12 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 177E922238;
        Tue, 28 Jun 2022 09:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656400210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hI1N+58h3v2qQDIx3pFvKLdYmLIkz3PRy8MDOW/QKAQ=;
        b=trK3jS0NekTSZyUApYuRpAox2op308hN6Fnfrd25RoO1w+tTsthQ12Iz8NvD0XXgieiWZ0
        LYor0Fnh/b+JRtMMKKdBF6L3B7fLYV4iPXaM+ZVRyy/XJKThT6AnHkG/e28UPUYnaE0Z0+
        p+zRXg0XBK4ieGlNcyT12X0CX8+T8pc=
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] dt-bindings: nfc: nxp,nci: drop Charles Gorand's mail
Date:   Tue, 28 Jun 2022 09:09:59 +0200
Message-Id: <20220628070959.187734-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mails to Charles get an auto reply, that he is no longer working at
Eff'Innov technologies. Remove the entry.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
index e381a3c14836..b2558421268a 100644
--- a/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: NXP Semiconductors NCI NFC controller
 
 maintainers:
-  - Charles Gorand <charles.gorand@effinnov.com>
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 properties:
-- 
2.30.2

