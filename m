Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88939C32792
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiHWIhB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbiHWIde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B067C91;
        Tue, 23 Aug 2022 01:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D97CDB81C3E;
        Tue, 23 Aug 2022 08:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8E4C433C1;
        Tue, 23 Aug 2022 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242572;
        bh=zaPYx1qAP/nUxRrxTuez+HrXGL97eJXktPJNjE8RN2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xiXon9YsqtPGq7NnYY7L24QGD2N3Baj8RpFkqMQSlO7rejEXelNdn/iNefBNH6/i9
         gt4oBLk10AM/Tmi+sWx8vVzODRc7kiVYIINkFmd5rcICTJnDUxQ+5punhNDpeHIf1B
         60gaNgPGc6sPh+hcahYy3RjVZ0wSCZLIoE92y300=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.19 130/365] dt-bindings: arm: qcom: fix MSM8994 boards compatibles
Date:   Tue, 23 Aug 2022 10:00:31 +0200
Message-Id: <20220823080123.624388026@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit c704bd373f58a84193eebe40bd271d6b73c138b0 upstream.

The compatibles for APQ8094/MSM8994 boards are different than specified
in bindings.  None of them use fallback to other SoC variant.

Fixes: 9ad3c08f6f1b ("dt-bindings: arm: qcom: Document sony boards for apq8094")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220520123252.365762-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -172,12 +172,15 @@ properties:
       - items:
           - enum:
               - sony,karin_windy
+          - const: qcom,apq8094
+
+      - items:
+          - enum:
               - sony,karin-row
               - sony,satsuki-row
               - sony,sumire-row
               - sony,suzuran-row
-              - qcom,msm8994
-          - const: qcom,apq8094
+          - const: qcom,msm8994
 
       - items:
           - enum:


