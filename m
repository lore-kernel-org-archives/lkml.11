Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 16:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbiECQg3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiECQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:36:19 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6973C48C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:32:46 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-deb9295679so17704639fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jp8Z/hUeLP23KvvSUAkBlWhJEZRAAaKOAZwprobHvBo=;
        b=ZWNTtDvt05fyhSOqHVAlqD562SO5r0AjFz08VS431jt2+vWW4mV6o8/q4xujLAqptP
         E/8fYNIuddQGoanfU6R90qJA8YSRndiRv+9f0k6g4Rf0LFlmT55Isdb5U3hLfG0OG6/O
         e2yowjegUn0jUc0Kt7sE2u7vOU9TJcyZT3HvjlMFphSpN1tPJvpURJ2EeSv1jYwaAjeO
         Pj7KJ/RfNa0CmmZygAVZn8ZfSoX1YNK2NE6iOmGBkFEDtwqg6KRLQMX3xVDOrcHTcaOa
         lSQQijHxSSfKK6xbqci9QWCksqS82afezFNqGgWnZAPb0LcuKYM+aUT840WFeRSZ7VyW
         3Wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jp8Z/hUeLP23KvvSUAkBlWhJEZRAAaKOAZwprobHvBo=;
        b=kN4GstDCcolJyX6MMjLvfZJsaaU5MnP8sgNo/qyKeOgsffZQ5DlODOjW3NMDGFz5rD
         eA+097lyBhlO9Od1yASkFb/wYdDn7p8yAfCmSatuE8pIxyM66gwkZAffyqdjBz3Vs/yZ
         qiopD77GqUeP8ckSFteYXUGkNU5aAUaQHtdHyz5LNRyDHQh+A/zfxIvYBCv0miH5F7cl
         AD0A8FiqXyt38nzIsiVjV5385WKkkknaa3qJvumTkVVk2o6OIIWJPqfujUo/fKhop2gL
         uQKo2pWczi+Hk7VrVtLUf/APddBP7N9M/tuICEzsQgUmPo5Ns49njh/a5u6MCDUaxkX9
         +DpQ==
X-Gm-Message-State: AOAM531YSIICsr4+VRw08+Hjb4PJ/aX5VnTm63tRSnDN3ikMA548Uax8
        K50PdGSFZBOm/77/QqBVfcc+tQ==
X-Google-Smtp-Source: ABdhPJwReRtrO6xB097gOrPSYR+neB6cLjmKw2HS51B9RII40zRWisxMt/uRLJTu3w5yH67xiBwsDA==
X-Received: by 2002:a05:6870:a2d0:b0:d9:ae66:b8e2 with SMTP id w16-20020a056870a2d000b000d9ae66b8e2mr2021333oak.7.1651595566241;
        Tue, 03 May 2022 09:32:46 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v15-20020a4ae6cf000000b0035eb4e5a6cdsm5027404oot.35.2022.05.03.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 09:32:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
Date:   Tue,  3 May 2022 09:34:28 -0700
Message-Id: <20220503163429.960998-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503163429.960998-1-bjorn.andersson@linaro.org>
References: <20220503163429.960998-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Qualcomm SC8280XP platform to the ARM SMMU
DeviceTree binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index da5381c8ee11..ba38ce054062 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
+              - qcom,sc8280xp-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sm6350-smmu-500
-- 
2.35.1

