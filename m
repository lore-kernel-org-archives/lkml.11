Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61876C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 20:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346964AbiEZUhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbiEZUhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:37:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B4E47072
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:37:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id wh22so5134813ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hg06tVmHTGmvTkX9STmRxlYvOy+LhDedrqKSWo2gyI=;
        b=lJPilBSquWM7s47NAc3O16CBERq0ozOKQsiYG8/j/cx9w0ot3yA1k5M7wkQjZ7EGjp
         MWyPCMLC8LUtp+2rES9sdNS7OqXpKCDEsSLJd6AKuxuRbsKGKIubKY3md/gYjfuGuk9/
         +vHpB4rFaBGE8ZlCIZ9asTembc+cADoBmLeC90d6jz2VQmCiprJ1lTO68hO2UMUPyq/M
         ehLzWevmo6r1614M/sRzmXsNibVKp3we39QXmPhrtfgW01lNkxAYBdz1O1bKzyrXIumq
         qn8eL9C2n7xN9Y3jcCgmI+9Haq0QOeJgfzlKhD3bJYOTiAsS7/5uMxb8+Sr1xzIXEjfU
         l6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hg06tVmHTGmvTkX9STmRxlYvOy+LhDedrqKSWo2gyI=;
        b=tTAXaBQuYw7QImHHuYrA3DjTGtB20rCZQxqJZCsBPBcBV763kVdc/JBAEpGTqhL5vA
         lIzaxDsnSJLXZq+bCanbf8IhRPGPlLytacewo9WH/va7kaHmIKq+8ZG/HoTAXbRpGLl9
         tm9X3dHZy+F4xTqSA6tcVF3wppJEyMgIs1sQ0yTvXTec9F5GfPc9Z1WFyxgDGSvE69Cu
         pSjKbqmNB8Y5uOksgkEfg0yp1GVIz1wuvrtp8j4RjbMIVz8rZSkqeNgFcIZtYvntsujC
         So12FLU4BRdwJ17rb1ADPiW8llkF72TnoNezkUsQFUSuyicmKA14VufK1V7JwIz+jvn+
         jasA==
X-Gm-Message-State: AOAM530LOtVGO0Als/puG1psMVsztgThf2X2yalbySi1ztdKLUahHHjD
        IzpnetWFxuGOqRXFjOfSaCEDVQ==
X-Google-Smtp-Source: ABdhPJxWEvDHhUj30DZZnB1pVu5jV8QXoWBhyBf5gTQrJfav1eDL6DrmUZMI+33dF5WRF6+6EVrjcQ==
X-Received: by 2002:a17:906:99c5:b0:6fe:b069:4ab6 with SMTP id s5-20020a17090699c500b006feb0694ab6mr28023511ejn.436.1653597438684;
        Thu, 26 May 2022 13:37:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v27-20020a50d59b000000b0042aae307407sm1175020edi.21.2022.05.26.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:37:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: sd: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:37:14 +0200
Message-Id: <20220526203714.831177-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/sd5203.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sd5203.dts b/arch/arm/boot/dts/sd5203.dts
index a61a078ea042..69381819e07b 100644
--- a/arch/arm/boot/dts/sd5203.dts
+++ b/arch/arm/boot/dts/sd5203.dts
@@ -15,7 +15,7 @@ / {
 	#size-cells = <1>;
 
 	chosen {
-		bootargs="console=ttyS0,9600 earlycon=uart8250,mmio32,0x1600d000";
+		bootargs = "console=ttyS0,9600 earlycon=uart8250,mmio32,0x1600d000";
 	};
 
 	aliases {
-- 
2.34.1

