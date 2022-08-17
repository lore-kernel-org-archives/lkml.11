Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB002C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 20:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbiHQUMm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 16:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiHQUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:12:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A32A61DF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so1444501wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1R6UrF0Wsbj6EmcSlPWRzTAwonFDames2nGAVyANWlQ=;
        b=PwR33To0N5ui/sX2vHA5vGOkVP5CwIp7cjsA3PN3/adE8gVsnwKwcA8MYb7gioCksg
         ahw0LIbslkzwkpF5jej+bp4Yf0eOt17d57rj6NZDdo2SwIe+S6QwHLjSHV2P1MzSZIBc
         SYx4JQvjJaj8YXXwnSVR4gMkDl8Q0JCp8oTckDnqWMsTdK5gI0pMdfXPPzjOTaFzzLMQ
         12YILMe1gQQ55rA8mLmVO7Cvz9oVG8YaFarhPLW/UC6wwUTSAdaNVhcSQfB/LksZ2ARG
         6gYZLDZVb5Wsbi12Ll5V36MnebMaEECTDL38Z4MC7mvuhjAl2WJjonXIZ/KRs1DxNILj
         o4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1R6UrF0Wsbj6EmcSlPWRzTAwonFDames2nGAVyANWlQ=;
        b=Lvdb/iUMqW0JALRWzPVU6Cr/wSoI8soEoPR1WYCI2bPzY1GmklnFGYpWgquOHmmLfO
         tPoVAu1vR5nWC8p7u13a7Ez40keqGHYLPJoSoFL+nYUC6JcNgz0OEKguvvz/YFqwtHbC
         F2AM42BcFnXLyniHYD6YStR0HN1qYGw7IyHx/vHC1AQmN5oIliN/CkYqoRj7DCGexbpc
         2cXS7dVSoqEtzhumQmUP9bvpXvRHbYlSYBuHRquMai+UIHWlDIdSUo0/qiZZP0KwKjWO
         58LoFIIPlCnrYWRvR9uz2pimDCVrr7jjOaFlcauLMfxrUMbPtDBphM9Z1j5MZMhpI5FE
         iSNw==
X-Gm-Message-State: ACgBeo1o2IiOvoyTC4Pgy3cVZX5H7imdcOw0lX//zUi+gwzf/XEEB2Yp
        LwCdy9+cOw8qA98kFhkWqea/Xg==
X-Google-Smtp-Source: AA6agR6lJ1JCJSrjpa59CdkKTqHzSw7FSFRvF0du7bAKFhB5DFjPBDZy5X6POzzhjKmao4BdhzICzA==
X-Received: by 2002:a05:600c:4f8f:b0:3a3:4612:6879 with SMTP id n15-20020a05600c4f8f00b003a346126879mr3121447wmq.84.1660767157797;
        Wed, 17 Aug 2022 13:12:37 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b003a5dfd7e9eesm3029371wmq.44.2022.08.17.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:12:37 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: timer: sifive,clint: add legacy riscv compatible
Date:   Wed, 17 Aug 2022 21:12:10 +0100
Message-Id: <20220817201212.990712-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817201212.990712-1-mail@conchuod.ie>
References: <20220817201212.990712-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

While "real" hardware might not use the compatible string "riscv,clint0"
it is present in the driver & QEMU uses it for automatically generated
virt machine dtbs. To avoid dt-validate problems with QEMU produced
dtbs, such as the following, add it to the binding.

riscv-virt.dtb: clint@2000000: compatible:0: 'sifive,clint0' is not one of ['sifive,fu540-c000-clint', 'starfive,jh7100-clint', 'canaan,k210-clint']

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/timer/sifive,clint.yaml           | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index e64f46339079..bbad24165837 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -22,12 +22,18 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-clint
-          - starfive,jh7100-clint
-          - canaan,k210-clint
-      - const: sifive,clint0
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu540-c000-clint
+              - starfive,jh7100-clint
+              - canaan,k210-clint
+          - const: sifive,clint0
+      - items:
+          - const: sifive,clint0
+          - const: riscv,clint0
+        deprecated: true
+        description: For the QEMU virt machine only
 
     description:
       Should be "<vendor>,<chip>-clint" and "sifive,clint<version>".
-- 
2.37.1

