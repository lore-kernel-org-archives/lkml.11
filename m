Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA0C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 18:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiFWSYE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiFWSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC768C79;
        Thu, 23 Jun 2022 10:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4FD61DC6;
        Thu, 23 Jun 2022 17:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA58C3411B;
        Thu, 23 Jun 2022 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656005123;
        bh=G8RvLNKUb/5NcSJr+pWqANeKbiDipPRXt8onOMoUFNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVWavz+i9wBxZBsRbl2Zfygn4y9zAZ3xnubHA2IqyymPneVmGBuoJyDBMXYW+2Wow
         v0DKa9Rcxs3F/qQiBf0181hBlr3o1gZuDz8QCBDfvppSATYTmB7wDHYf3FhvlEQqc8
         lD6QrcYr5uH0SCGaBoBvvN9VA7XUx7+crgFJ+9uU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 5.18 11/11] dt-bindings: nvmem: sfp: Add clock properties
Date:   Thu, 23 Jun 2022 18:45:23 +0200
Message-Id: <20220623164322.643045783@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164322.315085512@linuxfoundation.org>
References: <20220623164322.315085512@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

commit 8cb0cd68bef75af5ac8ef93f3314d4f8dc8767a3 upstream.

To program fuses, it is necessary to set the fuse programming time. This
is determined based on the value of the platform clock. Add a clock
property.

Because this property is necessary for programming, it is made
mandatory. Since these bindings have not yet been present in a stable
release (though they are on track for 5.18), it is not an ABI break to
change them in this manner.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20220429162701.2222-13-srinivas.kandagatla@linaro.org
Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml |   14 ++++++++++
 1 file changed, 14 insertions(+)

--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -24,15 +24,29 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description:
+      The SFP clock. Typically, this is the platform clock divided by 4.
+
+  clock-names:
+    const: sfp
+
 required:
   - compatible
   - reg
+  - clock-names
+  - clocks
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
     efuse@1e80000 {
         compatible = "fsl,ls1028a-sfp";
         reg = <0x1e80000 0x8000>;
+        clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+                            QORIQ_CLK_PLL_DIV(4)>;
+        clock-names = "sfp";
     };


