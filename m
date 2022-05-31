Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3541C4167B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 21:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348225AbiEaVwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbiEaVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:52:32 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7244FD9A;
        Tue, 31 May 2022 14:52:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654033459; bh=p4MJ2MU5aVvrjpywhfF56B/Ig6lZU/rzO12jN2Ev3Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g5Jk/uciX7gjDxDE1DUzZ7qIrovVAY+pyxKg1sRDyCwXPgbsgdVqo6ec9DzSCrfer
         RHQ/pa8RV8Z0WaGMF+b3L7nDzIK99qtT98YvlTUod+guMo+aGqhoSiK8TjCJp41+SL
         9Xj0YQr3rHBJExSTCGpOxusSTWFVpq+y9WDsm6I4=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH v4 3/3] MAINTAINERS: Add ADMAC driver under ARM/APPLE MACHINE
Date:   Tue, 31 May 2022 23:36:15 +0200
Message-Id: <20220531213615.7822-4-povik+lin@cutebit.org>
In-Reply-To: <20220531213615.7822-1-povik+lin@cutebit.org>
References: <20220531213615.7822-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the driver source and binding schema.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6850d079f012..8cd1b4484746 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1835,6 +1835,7 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
+F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -1848,6 +1849,7 @@ F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
+F:	drivers/dma/apple-admac.c
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/iommu/apple-dart.c
-- 
2.33.0

