Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849B6C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355588AbiEUQrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355463AbiEUQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE962CC8E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w14so18963590lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMIvDTZuqS/+po3VQFQJ9f+W1R+y8U0WI3D5yp7/eps=;
        b=IX9naaFCsIxfdej2NveuEzNIQwQXPGFrQFlYkGqJ6bVq/aFY9yYSk9MDd9lSFE/h+z
         WmSafFtqwgsr3RK36xhLjNKP0lRnozF3VMfWG3EnYYnXaqe/C2sIYzC/XetJQImqSXu4
         /c6Bgl12XIeBK8LzqOg2zIJ8SLk323XxU7Sdjo34g/pyM4zdXe1KPEs1tpVILhnHwbNj
         kkHeUETRu/d9/APtWBQk5nAYT4kbaOmEt6qIFwLP+YahXn2wM5mfeTVTYhAvzMRn92RQ
         iZHz9tXYKHuOsgr5dxWBON5Mf71mXM2A3zuL911RBUhUzPKT22NSYPPkYRTW/SF5sd7G
         0TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMIvDTZuqS/+po3VQFQJ9f+W1R+y8U0WI3D5yp7/eps=;
        b=221U9Tw3mWNim5hVMG6SthutDW50gRzd124qVlcberGiQLAfJyj8C5qeXrqej36lOu
         xUFHa5Pox6uSl3gTWrVnPc7yDD6oIex3iClgoYE0/9TWRe0H72HoqFWfDpfYVrBj4FlL
         ivPGaHL/Kn+wbzoIgwn9fvTRTT1Bt1VsSVW7HlMiltGRNITpuZv1kGY0JzuwbLJcIwMo
         wjCzBGAUvx7bV4oYSm2lsC5eddPHNpZ1iwzhIVZTOpsHiVK8E7P9PQ1lq4NvIPPgEsPm
         1ripijD4HBRPKvW+4360To/N7pTYDJhDdKvEz4SJpyspzd1PVVPUF58v7/b4ItnSEbb0
         p9XA==
X-Gm-Message-State: AOAM531Ppqw0s4XFYDpndNEv9xC40CEL/3XNWYyncCiBSHp1QWf3gfT1
        zaXP6IwluXnxojgewnRoe6nNXA==
X-Google-Smtp-Source: ABdhPJz7x8s8SRAwJThpaS1m/hqYbUOhZaRRyaWGPWIFKSIwxQNzOOaa5kGzrrIu4pUITtoFIrqspQ==
X-Received: by 2002:a19:6757:0:b0:477:b7f5:8845 with SMTP id e23-20020a196757000000b00477b7f58845mr10173121lfj.504.1653151588887;
        Sat, 21 May 2022 09:46:28 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j6-20020a2eb706000000b002509fcb66b8sm749787ljo.65.2022.05.21.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:46:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: firmware: document Qualcomm QCS404 SCM
Date:   Sat, 21 May 2022 18:46:23 +0200
Message-Id: <20220521164623.91322-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for Qualcomm QCS404 SCM.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 0f4e5ab26477..0eb9759d8d8d 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -23,8 +23,10 @@ Required properties:
  * "qcom,scm-msm8994"
  * "qcom,scm-msm8996"
  * "qcom,scm-msm8998"
+ * "qcom,scm-qcs404"
  * "qcom,scm-sc7180"
  * "qcom,scm-sc7280"
+ * "qcom,scm-sm6125"
  * "qcom,scm-sdm845"
  * "qcom,scm-sdx55"
  * "qcom,scm-sm6350"
-- 
2.32.0

