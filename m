Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B8C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 21:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbiECVV0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbiECVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:21:16 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC440925
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:17:42 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-ed8a3962f8so8391430fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWbhsf8P98l/EiH5gI2ubgolPhW/0b1/YN7RGLxWPF4=;
        b=vgurpuY/jnW3VAquoYo68gT2IDasRteb+8B5Ot20rlH7g1qC0K73nKWhGCaACAtKrL
         UC5J14kj4pnvxrI/VU0uCB8iz6lBfGs5bOf9fcv87+N3NJL0hUQcIF+dG4xQuexcend7
         JnkzWfUqUz1qjsreJfztWVjVqVBpG3uPBsUWEF6FCWrUwX0pPXrqY1BYQ7c42mOcrcmf
         Qc7mgFrfAs1H3cx4n4whLgpAPxz4Af4YvVBTOdeEBAJqPiAgsNw5ofkMMOH/m4E2pKQx
         gwSOc1NbnHhxDGeupZlyyo6UnlbfvVYZySpmUtu+NmFfJqf8OXZagMFfkcQqBl9HXpSs
         /4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWbhsf8P98l/EiH5gI2ubgolPhW/0b1/YN7RGLxWPF4=;
        b=wLPdEeNEr8R2DTKgvz695qNt0wjMXxkHbpEJdfGqP6jiBdawvAi6Pqkm/DBMiKQVun
         BaNMPehDH5G2IZG1Zjw0kmn+lR5IlsUmZhB4sak+gKZkP/ngJSITrYz7hwuIZb3JqtWL
         HPBL8TRdAmGKWAFL/n6QF6XYaCIlAGJt3Eeo8dsr7+d/00WFz/fcrAmAyriwYAIaBj/v
         JkUzjo6Pww1U9EDSpiBXjC1dpKA1IOMSI9vXvrzo8ebM9fT6/WrC7yltprtA3+59jjDR
         lo+2cXBEgdrXhJIgWI7F1icxtM4WEpV/VQPNV5t4nMJDGJH/o8+lsMA+qH6gPwSI23Jp
         KCFw==
X-Gm-Message-State: AOAM5302HntCblbG2+tgCNXvG1ppCPatQ6HJIk0yR4fmfqsiuJNv7zFm
        rODIQxD3Cso4T+wCxKYQxBLhAQ==
X-Google-Smtp-Source: ABdhPJzQFCROhKyiY4KKxw7AbEgDdlqk3c4Fy++A5wNWSRcnQUbUeP/RfPtsAFmlttK4wQomi2QTvw==
X-Received: by 2002:a05:6870:304c:b0:e9:8c5c:3c34 with SMTP id u12-20020a056870304c00b000e98c5c3c34mr2540190oau.169.1651612661997;
        Tue, 03 May 2022 14:17:41 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830104300b0060603221263sm4305906otp.51.2022.05.03.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:17:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: interconnect: Add SC8180X QUP0 virt provider
Date:   Tue,  3 May 2022 14:19:22 -0700
Message-Id: <20220503211925.1022169-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
References: <20220503211925.1022169-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the QUP0 BCM provider found in SC8180X.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index fae3363fed02..cf684640fe6d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -59,6 +59,7 @@ properties:
       - qcom,sc8180x-ipa-virt
       - qcom,sc8180x-mc-virt
       - qcom,sc8180x-mmss-noc
+      - qcom,sc8180x-qup-virt
       - qcom,sc8180x-system-noc
       - qcom,sc8280xp-aggre1-noc
       - qcom,sc8280xp-aggre2-noc
-- 
2.35.1

