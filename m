Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0A7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 12:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbiF1MXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345596AbiF1MXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EB21208B;
        Tue, 28 Jun 2022 05:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E61160FFD;
        Tue, 28 Jun 2022 12:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468ECC341CB;
        Tue, 28 Jun 2022 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419002;
        bh=qYPfnzTqV+BxctBlh0HulqRk4JegMdUP1qyxoejHvUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Khf4igej+0j3Ni7xatEFL0AMD2MMQoFYj+Xd85iYQghPGkG99zWk4VCmswSQ32CoL
         NJTH8ntIj3Qiz8UFwckFrLpmxzLRHzYbwSooyxo/wKtdQ+4e/FziDAgxd/92M8X/bS
         VQO7rW0+rWDvmbHRMIroszel5s+mRVVRv3bYYoSyFcJp5Ni12zou+vCVTXLpnpkDBc
         xUHviytXvaCFQVigAwz+aCXVfbmnIas7uXNKnmjIit9Lo1DIr82wDlSbMJJs2MH/PN
         Rbo1IMJI4y2EOnaW+NuebuJ5SdYe1HJnjHLwAVQfkhK5P0g1MV0HqlcEXkXY1TC7xc
         pzVS1jb+dtkhQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4/7] dt-bindings: phy: ti,phy-j721e-wiz: deprecate clock MUX nodes
Date:   Tue, 28 Jun 2022 15:22:52 +0300
Message-Id: <20220628122255.24265-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark "pll[0|1]-refclk", "refclk-dig" and "cmn-refclk1?-dig-div"
as deprecated. The clock muxes are provided by the device driver
so not required in device tree.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index dcd63908aeae..3127bb648427 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -83,6 +83,7 @@ properties:
       WIZ node should have subnode for refclk_dig to select the reference
       clock source for the reference clock used in the PHY and PMA digital
       logic.
+    deprecated: true
     properties:
       clocks:
         minItems: 2
@@ -111,6 +112,7 @@ patternProperties:
     description: |
       WIZ node should have subnodes for each of the PLLs present in
       the SERDES.
+    deprecated: true
     properties:
       clocks:
         maxItems: 2
@@ -136,6 +138,7 @@ patternProperties:
     description:
       WIZ node should have subnodes for each of the PMA common refclock
       provided by the SERDES.
+    deprecated: true
     properties:
       clocks:
         maxItems: 1
-- 
2.17.1

