Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E58C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 11:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiDKLFP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbiDKLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:05:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6E443CD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:02:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so30047068ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrhjMPDWVMpnH0vGXH4JML8AsEUrRppRhTIbZkMHMtg=;
        b=q1AEI5QMqWZueRnKCNAHimfoWg6UCP9Lk1hEQEEaN2ub7v0Eajkt0P2lExv6gx/IEX
         AH3uYloLfAb8KySJP4wayKgaeRV8eqAjlsxzVSFpV/nPl4Bd9HEc3vaBa513BlsAcJvM
         SeJlsBUJsXCKWgoT8OhDcfybWtY8ix2Da9fUm/KXudI3nq2Kp4+5Vo7Jp/B3OpKAA8iz
         s3/q/u/itZS9+slHeFvkO7BaC+I85xtSx3g5bpunXKchMaSF3eTq7m9OhcXdfH65d14c
         LCLGU2RxHE2z0nCFXgnNdn/euRRLNjES3fBvFBIpuXazsk+JtjkQKSCS1FonVuLH3s3Z
         4g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrhjMPDWVMpnH0vGXH4JML8AsEUrRppRhTIbZkMHMtg=;
        b=r54F5U0dpsDGQjQY2k8x1eJWNTRHiITs/FUUBN3mMSk7wuLnyxwtfLwQDZeAAEXcZL
         RcgzKmfR+dJDr5ZhHDd6Gdg3pW27ZcpdhYeDXmyvGaFP4lN0NH5K5kMHXdtKKghvSev5
         2RwTp7w0HtuLL6KGLdsN2dPrJ5mgs1C4yGVWq6SpKSF9UyPcm2U6m3aeq3QnaFvIEYX2
         T22t3fsMd7t3QJNbFzYQo6YKrsXNPdO0MN7kCkF2DZjGgP2sZ++Qn/RC1hUjpgh+z32M
         7bwSFMZmoCJRrLHQBvbbHhJlTxsyu8tAVcBm4YXXwn5aaUFOLMYxlNrzqLqWAkoIbXHT
         N/wg==
X-Gm-Message-State: AOAM533rzZk4lGoPxTZlu9dKmab3cTSpeNmxz/je2INf3BGRmFlUmKT+
        8nxhj5Rgc725v8k7W2lWroDuNA==
X-Google-Smtp-Source: ABdhPJzs5WUk5RcgDGjmx05qg1LQX8CHENqcYVHEYQ8+118ck5dW3vjDXr/APWGQaUFxBkmhW0L6cQ==
X-Received: by 2002:a17:906:4795:b0:6e8:7121:3c80 with SMTP id cw21-20020a170906479500b006e871213c80mr9235700ejc.352.1649674976100;
        Mon, 11 Apr 2022 04:02:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006e891c0b7e0sm1231664ejc.129.2022.04.11.04.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:02:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] regulator: dt-bindings: qcom,rpmh: update maintainers
Date:   Mon, 11 Apr 2022 13:02:53 +0200
Message-Id: <20220411110253.231745-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Collins' email bounces ("Recipient address rejected: undeliverable
address: No such user here").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 2714a790ff83..842ccef691b8 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. RPMh Regulators
 
 maintainers:
-  - David Collins <collinsd@codeaurora.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 
 description: |
     rpmh-regulator devices support PMIC regulator management via the Voltage
-- 
2.32.0

