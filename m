Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC2C4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 12:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356582AbiCYMjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 08:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359139AbiCYMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:38:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B921804;
        Fri, 25 Mar 2022 05:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8961CE2900;
        Fri, 25 Mar 2022 12:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593C8C340F5;
        Fri, 25 Mar 2022 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648211840;
        bh=h5t3lHDxilF2die7J3nsNMpIGBfRLhFJI3qeoIHgotE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evxYEBywQrDAhv8dH2eKjnt+4aJ9yPhhyn0uoGeuhEFc6AP5nIb39GG+PdeyOAlBt
         AbH1Un3lfQbh6FAhzMWYqXteTLEADvkidMG59m8VFI21tEV0LVv2qvPiohFbSAAgAr
         LFzVw6nO6xZBxsdiA14ZgP2xDHjWm9hyj4SnCE+6pdgYrhhLrFyBNrwMChmPN2nBo3
         osQ1i92+61CmDkybjnWJmQyH+rMz21cE1LL5D36JvIkvz1GJ/ocIhrUVQ5JX1W8AEJ
         v+3UA7wOOidY4kHy73hPBD3rplAT8RmzXB8R72YM7C/P7Orv90MW4ZRQXNcls4bBkv
         MC9nBLoxg/wWA==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, robh+dt@kernel.org
Cc:     richard@nod.at, krzk@kernel.org, vigneshr@ti.com, kishon@ti.com,
        nm@ti.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Date:   Fri, 25 Mar 2022 14:37:06 +0200
Message-Id: <20220325123707.22020-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220325123707.22020-1-rogerq@kernel.org>
References: <20220325123707.22020-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's AM64 SoC has the Error Locator Module. Add compatible and
related properties to support ELM on AM64 SoC.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 .../devicetree/bindings/mtd/ti,elm.yaml       | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
index e36452b742c0..967c87f32c71 100644
--- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
@@ -16,7 +16,10 @@ description:
 
 properties:
   compatible:
-    const: ti,am3352-elm
+    items:
+      - enum:
+          - ti,am3352-elm
+          - ti,am64-elm
 
   reg:
     maxItems: 1
@@ -24,6 +27,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description: Functional clock.
+
+  clock-names:
+    items:
+      - const: fck
+
+  power-domains:
+    maxItems: 1
+
   ti,hwmods:
     description:
       Name of the HWMOD associated with ELM. This is for legacy
@@ -36,6 +50,18 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am64-elm
+    then:
+      required:
+        - clocks
+        - clock-names
+        - power-domains
+
 additionalProperties: false
 
 examples:
-- 
2.17.1

