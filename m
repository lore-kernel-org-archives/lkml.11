Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D376C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 04:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356655AbiFVEKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiFVEKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:10:21 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1E33E22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l9-20020a056830268900b006054381dd35so12203906otu.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKIz5tnMbAzg2NTgeo3md9ebE7cBvAVZ/cPgDeboDYc=;
        b=vnUfKCyey+9D47t4+fBJNDpMiXQmXk52knlTD60xh/r1aWgbpk6QNFQvnVfIi8baWT
         nlogEZBGYb5XZGB/4BAEucIqkKW04aMSvzJLa81SgyGF09TYxv4nt2BHeRRdRmadRoIJ
         I/IUYa/OJMEA5oRx1OINg+mPjgA4/UpHRceIO9PKqmnW6NwOv87Psc1eyG11rV/UmAeN
         uu/QCPXmyjY53Am0o0Xy7KD4ajmeu73duPDWksp5KecgNjmGyYpO6RsmnqKk5y2LumHe
         9bZ3mpN50LHSnfRirzE/hkhidANsLd8xBYk64LXTFOrnGzohmdg0h5KbA8COvS375jEX
         EbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKIz5tnMbAzg2NTgeo3md9ebE7cBvAVZ/cPgDeboDYc=;
        b=tw949ZyK/x7fIbqApqkoOVxIyH7et6rcqI/TGxjq02la4dh+Pka54T395j/1aHzmvS
         faluGIxaPqF5UVwo4bg28/yg9FpFQq3cOvNR7Us/S8hkzyWT9SmH+FmUVDBHQEpltNWn
         jiJGF2qr5ROSxqxn9epKLZvTzDI09RdjOHYDMDUUONBA5pykwb12bZ9lWYfZwV7+96Ij
         TKqyvM3biKpLxtqIj5pDmB7Dph6xE4Qq/yndlKO5DaoUiqJZqoFcaM8Tw++cZEPC/t3D
         WU7a4NXRp+TWLfbxvWwHSYI8jMGmi+hwgBadKbNmgW8cut7dOlbNlvexNdX8pDS6fkGg
         Sy/g==
X-Gm-Message-State: AJIora9kgUd8xAWSGsgVqSx/+qEK8O8eEv+vdgVv2lef5i352ddm877i
        0IL0DyDOU8LuT4QTG9HoeOWGsw==
X-Google-Smtp-Source: AGRyM1sWT0gOCuqBLlvADMHlst9VYSq5f2w5tIFcioSWUzKDFU8DOoqY4cd6CePeFZGAP2deC2pa/Q==
X-Received: by 2002:a05:6830:6306:b0:614:c6db:9d3e with SMTP id cg6-20020a056830630600b00614c6db9d3emr714330otb.60.1655871020116;
        Tue, 21 Jun 2022 21:10:20 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b7-20020a056870918700b000f2455e26acsm2314718oaf.48.2022.06.21.21.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:10:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: arm: qcom: Document additional sc8280xp devices
Date:   Tue, 21 Jun 2022 21:12:19 -0700
Message-Id: <20220622041224.627803-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622041224.627803-1-bjorn.andersson@linaro.org>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CRD (Customer Reference Design?) and the Lenovo Thinkpad X13s to
the valid device compatibles found on the sc8280xp platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added the two missing board compatibles

 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..6ec7521be19d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -238,6 +238,8 @@ properties:
 
       - items:
           - enum:
+              - lenovo,thinkpad-x13s
+              - qcom,sc8280xp-crd
               - qcom,sc8280xp-qrd
           - const: qcom,sc8280xp
 
-- 
2.35.1

