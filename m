Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4D0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345690AbiC3NGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345674AbiC3NGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:06:09 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F782F385
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:04:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c135:3663:5a9:d10a])
        by andre.telenet-ops.be with bizsmtp
        id Cd4J2700F0037nA01d4JE9; Wed, 30 Mar 2022 15:04:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZXzm-007OGr-Ah; Wed, 30 Mar 2022 15:04:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZXzl-003utp-Sf; Wed, 30 Mar 2022 15:04:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: power: renesas,apmu: Fix cpus property limits
Date:   Wed, 30 Mar 2022 15:04:16 +0200
Message-Id: <9ece1a07bbcb95abc9d80e6a6ecc95806a294a11.1648645279.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make dtbs_check":

    arch/arm/boot/dts/r8a7791-koelsch.dtb: apmu@e6152000: cpus:0: [6, 7] is too long
	    From schema: Documentation/devicetree/bindings/power/renesas,apmu.yaml

Correct the minimum and maximum number of CPUs controlled by a single
APMU instance.

Fixes: 39bd2b6a3783b899 ("dt-bindings: Improve phandle-array schemas")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/power/renesas,apmu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.yaml b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
index 540e6fe1b7430fcd..f5d97d651e828981 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
@@ -36,7 +36,8 @@ properties:
   cpus:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      maxItems: 1
+      minItems: 1
+      maxItems: 4
     description: |
       Array of phandles pointing to CPU cores, which should match the order of
       CPU cores used by the WUPCR and PSTR registers in the Advanced Power
-- 
2.25.1

