Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF11ECAAD4
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Sep 2022 17:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiICRma (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Sep 2022 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiICRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:42:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987451A1D;
        Sat,  3 Sep 2022 10:42:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 29so1452537edv.2;
        Sat, 03 Sep 2022 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LiCUxZdYLa2Of1DNqQYrl2eGe/pmnbwIvotetEM5Z2E=;
        b=RriP5YsUUr8sTJic9u0ObZgjVl9Ko9DW/aBbZ8c5oGaZq3/XUk4CiulZFulnyZhF/G
         CVupWTuzwW6sv+s6qWt9VCrXKUo395LUPTupmVzaaGkoxbWOVjJKpA0TZdKyJN54uD4x
         M6j3rUUvuCGmuRXT7OtnDmAbTJhl4ZmrI7QiiYR+AZMRSutFkMDw+Cow9LFlIQcRvgBQ
         B9VkPGODe5bwfOumHKOkDFehJnncxSJJmwZKKB1Zp2cK+/c+xGdW2eH+6Z4HQ3nzgbbH
         kjDoOxeVxdvgVAvOsVwhvHsNSRcIpuGHOUezvASPQ1/fkG4Nznwsu2bMgN75nHjhqSbc
         P0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LiCUxZdYLa2Of1DNqQYrl2eGe/pmnbwIvotetEM5Z2E=;
        b=03DY6hBvaHIB6EoQKXkUTdeHe1ieZ/uipOsn1BIRVRv6sN3fcMIg00iqOoG744Wmk9
         G/9J8K+8Aks+JV9QxmHAnwEsp9E6sX/LmVriIl6n4yL2C0LklW1c1pkIfzOfm3AmHbgn
         gXhqs+6B1+aLCIYYwWSDjdv5N51bHc6yk0te32vH1vjRJdF/Vy0GtvBd8dZq3GWZ4vJn
         P8KrTUyAI0hkkThAbh08gg3ziE+qBLHoVVRjx3DBcpdXpLNeJCXucC0R36C4+uXNyRbN
         M32OmfQn+UAvjNIoKWzTNbIsSXZZzagP1UuA3/VLtuEKdQPtju7cJMZTMk9mUHV6zezs
         FfDg==
X-Gm-Message-State: ACgBeo134UFyiOYWL18yINXdUk53PvyRMWMRRXthshMgZFde3dyTq1D+
        E8tzfh/It5EBSc6w28ofEz4=
X-Google-Smtp-Source: AA6agR4nnz4enbxMuJD36RW+xEJMyZPRe/w5XSKaS+tFONKi0VzodqTT0gjITpf+ZoeKJM6NW3vI6w==
X-Received: by 2002:a05:6402:14c6:b0:448:e27:5974 with SMTP id f6-20020a05640214c600b004480e275974mr31127791edx.53.1662226943292;
        Sat, 03 Sep 2022 10:42:23 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id az24-20020a170907905800b007385e929344sm2714168ejc.55.2022.09.03.10.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:22 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: firmware: document Qualcomm SM6115 SCM
Date:   Sat,  3 Sep 2022 20:41:43 +0300
Message-Id: <20220903174150.3566935-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for Qualcomm  SM6115 SCM.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 9fdeee07702f..c5b76c9f7ad0 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -44,6 +44,7 @@ properties:
           - qcom,scm-sdm845
           - qcom,scm-sdx55
           - qcom,scm-sdx65
+          - qcom,scm-sm6115
           - qcom,scm-sm6125
           - qcom,scm-sm6350
           - qcom,scm-sm8150
-- 
2.37.2

