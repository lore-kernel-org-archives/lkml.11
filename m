Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3DECAAD4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 11:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbiHZL4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 07:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbiHZL4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:56:22 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D76F550;
        Fri, 26 Aug 2022 04:56:15 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1ECC483DD;
        Fri, 26 Aug 2022 13:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1661514973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJtzkM/VgLVC2uosVOZkAnvx/HDn2Y7Lpu2gaOOkJKc=;
        b=TRn5HCP+jkgDLTddCeUYv17oANOn0RGEvFLcBioHkYuhd+q6WSHJs1rVrpTfh2yZVQiXnM
        itBGlz9jb6ouX48VHMMEKZvbXAAR2KQdu4KMe3IfIROOQP/pvmkOf+m/4CCi4W3/XzZb/z
        jbVoVK/aXy/fBgqAEEdM4qdOXG0W0HaFDLiOTKE4uKjVyWzEQ1kYfAA36mBkxhumtO67nb
        S/bzQO2/UuAgltRLGqgCn1UrJVSYRg2aH3h/Ya+KNIhH++lBlINUfGYdon2RuujQAqQT+A
        5SXnZQE1C5ws7fZoFDf2jxCBb8M9Ykwix9Hy8Wkm2PeMYNeMuXO4unHnIUrj6Q==
From:   Michael Walle <michael@walle.cc>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/3] dt-bindings: net: sparx5: don't require a reset line
Date:   Fri, 26 Aug 2022 13:56:06 +0200
Message-Id: <20220826115607.1148489-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826115607.1148489-1-michael@walle.cc>
References: <20220826115607.1148489-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the reset line optional. It turns out, there is no dedicated reset
for the switch. Instead, the reset which was used up until now, was kind
of a global reset. This is now handled elsewhere, thus don't require a
reset.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../devicetree/bindings/net/microchip,sparx5-switch.yaml        | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 6c86d3d85e99..4a959639eb08 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -144,8 +144,6 @@ required:
   - reg-names
   - interrupts
   - interrupt-names
-  - resets
-  - reset-names
   - ethernet-ports
 
 additionalProperties: false
-- 
2.30.2

