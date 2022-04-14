Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 06:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbiDNGpA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiDNGox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:44:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683BE4D272;
        Wed, 13 Apr 2022 23:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12884B827C9;
        Thu, 14 Apr 2022 06:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A44C385A1;
        Thu, 14 Apr 2022 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649918546;
        bh=d16Tn2NDvqIzk6Djg9zPYjwP38rjcDx0WGDiCayJvwg=;
        h=From:To:Cc:Subject:Date:From;
        b=QTBoBL/FPCLbQpgxj+0kUta0B62BHHQJcFfa43St2iyzU1ngrTs0DdEheDaO3TzjO
         Vx4l4dLfnEqnTHcVBH8wLOjzFaEx/eufpv4Wt3RWs1J4aPWHa0nQV4vQk9mX93VnSN
         MwXQgMsiOShbMQw2xen6fgjStwMF/4rHCsN5eoP42O5oVHZIFATgEXl1iXkvQ+bwpU
         TM/HcGj457H3iBgKZyrMdHmseAR8CYo0ban2ikrxLhlkcO9Tu+9fha1Tkj3TzgCl2P
         SItdyETZqYpArEpgazxveIFBt/Ogiz3AocHaAtYshgh5WoXf61WFFuTIuoOfWQwTrc
         VMDlGfMIBl73g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dmaengine: qcom: gpi: add compatible for sc7280
Date:   Thu, 14 Apr 2022 12:12:16 +0530
Message-Id: <20220414064216.1182177-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for GPI DMA controller on SC7280 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 67f046a4a442..8a790ffbdaac 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - qcom,sc7280-gpi-dma
       - qcom,sdm845-gpi-dma
       - qcom,sm8150-gpi-dma
       - qcom,sm8250-gpi-dma
-- 
2.34.1

