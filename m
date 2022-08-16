Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C2C2BB41
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 13:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiHPNVr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHPNVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:21:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FAE73911
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:21:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id v2so14900508lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yE7zn3+63TAoBI4QapAvwqAkJrBFU8gy8jfI0uwa9Io=;
        b=MDzvxydaTkVDEjoHMlvPvOnwvlr7ONZ2+VmBXkidWml+0GhHByNN6EWuo39IFC8yZ4
         4CbvNwRQuYmzzuwIB0kqA6keBCbjCiZg59ROuHLbpcXGUyVOn6GwQgA+dSn3f9kGCVrj
         +iWgLCl5YeyTgXVm0yzI89zqlenbzT/mODrQZon8JM1W/XtNcUj0eKf7JKBqzKY4NDtq
         N8PKaTLB1cNJqgDJkCnAtqQV9NYHQsqVWn6QyuEZU0egFpKBIA9yaWsAcGDIjJQTXPQ6
         6JtHdJ9wy8/vfI6svnRYpghzayyrCwMeNXciOKiV4MZ7AsAPEHBmDDqPoIAd59/bcDzI
         2vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yE7zn3+63TAoBI4QapAvwqAkJrBFU8gy8jfI0uwa9Io=;
        b=LzXUdNPWLacVOXdcrlohJ6n05wfRXXhLimp7kTfTjd/Wloj2uNdmIfOm+SV5GSCAgG
         4mfnM3xsEihSKdEsXwlYVQhvFq8PzIJyVtnO629Ml2Qv8ugbeBIFTgEc7BEakv9BZJRz
         k20XJW9RKvgPrJtjOjoAWnTaOp28yRd4Rq/AdZFNuNMoFcuIudUMws4lG1QvPzXxq0Oe
         6e/kaVWQAPJXhnCmM5jD/AvtD5Ys3lCAmTMqHMNF71rOJTufKFmKAzRVK60zKBXBpyzK
         IJVjuy+USJZqChGHGqwuVw4Z/RyDVjA8X2JRQ6sg+9HjPgwJ9PGl+7OLj+2UBQwkclFy
         KF1g==
X-Gm-Message-State: ACgBeo2NXGnrREg4bTmc3h/VbrsazThFECUL4Jx+8ozxmnLctVChf1n0
        L0vvG153f/lIZ1UxafqlG0za9NfZ6SLqHGAe
X-Google-Smtp-Source: AA6agR6XKqcse24maA6Z7f54Nlx/n9AiCKXjXCJKSey1kamKIawSJ0X2wWxzj59gOcgEC27vgTh/uQ==
X-Received: by 2002:a19:d611:0:b0:492:8e15:ba18 with SMTP id n17-20020a19d611000000b004928e15ba18mr2700922lfg.524.1660656101921;
        Tue, 16 Aug 2022 06:21:41 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id m17-20020a056512015100b0048ae518364dsm1387442lfo.148.2022.08.16.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 06:21:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] dt-bindings: phy: Update Pratyush Yadav's email
Date:   Tue, 16 Aug 2022 16:21:31 +0300
Message-Id: <20220816132131.75591-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Pratyush Yadav bounce ("550 Invalid recipient"), so update to
match one in commit 92714596cdbe ("MAINTAINERS: Use my kernel.org
email").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Update email instead of dropping.
---
 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml | 2 +-
 Documentation/devicetree/bindings/phy/cdns,dphy.yaml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
index 07be031d82e6..d24ec47c038e 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence DPHY Rx Device Tree Bindings
 
 maintainers:
-  - Pratyush Yadav <p.yadav@ti.com>
+  - Pratyush Yadav <pratyush@kernel.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
index f0e9ca8427bb..649e0b953df0 100644
--- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence DPHY Device Tree Bindings
 
 maintainers:
-  - Pratyush Yadav <p.yadav@ti.com>
+  - Pratyush Yadav <pratyush@kernel.org>
 
 properties:
   compatible:
-- 
2.34.1

