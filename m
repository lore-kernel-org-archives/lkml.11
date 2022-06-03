Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE61C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 07:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiFCHCa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 03:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242340AbiFCHBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:01:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08E73914B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:59:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j10so11155951lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxT3KDDIuP0W5p/TaOOy3SJFNBVULLGo5ttCHUhyJ/0=;
        b=qMhv3GRM38nJp0iMW7/Gk0VA7jUEvTUNhvx5Du9L6srVhHzf8oyfJSN3u14OoG36bc
         z3DJ3LvkTtW9usWKeMGmDCQy/F9QJMQ8XXBnjQALMAOuJ2/1gWnPUOg8XRxBVvH7GzTh
         Vh4gEuqUVnNrPfl+qK3OxK2nAJNbokKG++IQOwrzz+JdARp7Dxv7xu8Qdv0lvJRoh3kB
         u0ibqHpucV2Gp3CUQjsjrqhOwppPI1XJyJwbem7eIyLSHdfiZOpKpXzrs/l6QRTvraoo
         lVujhnmphDh83r7ljd0dNTJyAErExao7mOpMBYqn95n5hhgqN+NWOBGI9Qz1eauEkJNi
         7+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxT3KDDIuP0W5p/TaOOy3SJFNBVULLGo5ttCHUhyJ/0=;
        b=f3bez9jR7KQ7f6gHbLfPG2daOuPztigst9RJ/788h6bXUuFzh/JGYDsWeLhwev3NBk
         MKed56hWtEyCqZczvjx4Pk+07svwihGOUas/NuFvGBFFF/59i5n8pBucJSFFb1uK7rAU
         /CQrRfxdcM1ks9SYsPtU2of+Af99lIf7CU3XeKvWb692BnAsk7r/h1QJPtCSEMV2aSFp
         rbi6I60nDVDf27IKCcfKDgvT0cbvatp9k15McuSwcYYxoHaQEsj6BT+4/eIGkIN2h88m
         GCcZsLgNd5qEOEoQF/ygq9QbxqHfmCOAfeOAMiWZ8gbc/sucBBlDbNlIFJ7MM97fuc4b
         Ceig==
X-Gm-Message-State: AOAM5321FAEV6ncaX2EZbTDZgj1ooRPkXfSLZ3p+PJKsWxQ08epcguPd
        bAOm67moxGOFch6vLmBaWLXxkA==
X-Google-Smtp-Source: ABdhPJweB1ZHcShDaaZlkRucmwAHJ8LEVtnvQo+YMFFfDYwIsXgYKrOnRDLWVSdlkhHdUvF7/9xrKQ==
X-Received: by 2002:a05:6512:228f:b0:478:735c:caab with SMTP id f15-20020a056512228f00b00478735ccaabmr5866521lfu.83.1654239570280;
        Thu, 02 Jun 2022 23:59:30 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id b8-20020ac247e8000000b004786321c697sm1056447lfp.138.2022.06.02.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:59:29 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v3 5/5] dt-bindings: altera: Add Chameleon v3 board
Date:   Fri,  3 Jun 2022 08:58:16 +0200
Message-Id: <20220603065816.87952-6-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603065816.87952-1-pan@semihalf.com>
References: <20220603065816.87952-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mercury+ AA1 boards category, together with the Chameleon v3 board.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 5e2017c0a051..4a08c082dbdb 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -29,6 +29,14 @@ properties:
           - const: altr,socfpga-arria10
           - const: altr,socfpga
 
+      - description: Mercury+ AA1 boards
+        items:
+          - enum:
+              - google,chameleon-v3
+          - const: enclustra,mercury-aa1
+          - const: altr,socfpga-arria10
+          - const: altr,socfpga
+
       - description: Cyclone 5 boards
         items:
           - enum:
-- 
2.36.1.255.ge46751e96f-goog

