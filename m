Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 16:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGLQJk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:09:38 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D32627FEE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:09:35 -0700 (PDT)
Received: from localhost.localdomain (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 93CCB1F5EA;
        Tue, 12 Jul 2022 18:09:30 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: apple,aic: Document A7-A11 compatibles
Date:   Tue, 12 Jul 2022 18:09:18 +0200
Message-Id: <20220712160919.740878-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatibles for Apple A7-A11 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../bindings/interrupt-controller/apple,aic.yaml          | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 85c85b694217..1d754bc3e8ef 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -37,7 +37,13 @@ allOf:
 properties:
   compatible:
     items:
-      - const: apple,t8103-aic
+      - enum:
+          - apple,s5l8960x-aic
+          - apple,s8000-aic
+          - apple,t7000-aic
+          - apple,t8010-aic
+          - apple,t8015-aic
+          - apple,t8103-aic
       - const: apple,aic
 
   interrupt-controller: true
-- 
2.37.0

