Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4799DC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 08:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbiHSIcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiHSIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A6E97F8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v4so3930081ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6FLutlicVxq1Eylj1yL55Y7bSA/DlQwN+QgsgZ9t/2A=;
        b=PWcHt65aAoGwEhBAaZGPnnKHKEWxzbdiwsXah20/c2ZQmoonFDUwKNARazQMKqspcQ
         sP39UpDeaeTrx1rLBB3kCfHSRRzYKXosGg0MI/YjUNaat4L50rIv7SLq+XA+UI/PE5Wc
         f/5j7qA59Uc/04B5vqT/FS95TYEsfSza4RrQJaa9/rC8KLmu15MJcdinDL7RIXHT4PaM
         vKVP7Idb8HzT5IDLgcNibaNNyl1gsLlHVxgWOG1VRHG557iP6PgC0G49XVq1c3NU9BwP
         t9enCJofTc+N5J3zsCRMa/ZhDWdaVu3CNVoRe6P8tQbc6k9YDvUywrj1qQQOL0arsgGt
         /7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6FLutlicVxq1Eylj1yL55Y7bSA/DlQwN+QgsgZ9t/2A=;
        b=ZKEy+yWh238uV/90s7aNwzJdkY6VJKg8lTRpVfsmKDMMHV5jVlFJvc+RRyB57Nt2hY
         PyIQ/7lEnw1xdVvpjJzCfpmrCLreIIFvn+wToK/JYZLJzmxV8JOp7ZVZhb0JpJf/wcaC
         VDJgC3eEsymMG0BEgJp5geW45J+MMitHuPe7XsSpg0OkQ0h3IL1HuD//udKcwugxYIGS
         UbENW/2nzsYR6FiHNfEX1D9/dIRIqu4ZaGGBTaHg7gIZ+OjQ48LifLxxxh8ZoVPTWCVu
         UF21am4oDYSk8JhEN9CFkBY2BYjdwzHrh3OZ9t5nRYxcxKiTu6gfrvs85wUoVD/dpuoP
         Ezmw==
X-Gm-Message-State: ACgBeo3YYw90AlSrgXbcHNWd5Mf4Dt0JUriopMzVjkAweZA+dzKJ8Fdi
        x17bnvMFN0y6/B9qOVGl+ck4wg==
X-Google-Smtp-Source: AA6agR4DCCR0xm0UOzwOV6TNToo14ekjr4pxv29FzDc7rz18UCbI9tAt+vY8bcGI/IZ0FEpMZtpR2Q==
X-Received: by 2002:a2e:b88d:0:b0:25f:f179:3837 with SMTP id r13-20020a2eb88d000000b0025ff1793837mr1989305ljp.357.1660897934217;
        Fri, 19 Aug 2022 01:32:14 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 00/16] arm64: dts: qcom: improvements to TCSR mutex in DTS
Date:   Fri, 19 Aug 2022 11:31:53 +0300
Message-Id: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2
================
1. Patch 1 (bindings): add more compatibles.
2. New patches:
   arm64: dts: qcom: sdm630: split TCSR halt regs out of mutex
   arm64: dts: qcom: sm8150: split TCSR halt regs out of mutex
3. Add Rb tags.

Correct order of compatibles in the binding.
Changes since v1
================
1. Correct order of compatibles in the binding.

Description
===========
Set of improvements for TCSR mutex to match the bindings after conversion to DT schema.

Tested briefly on SDM845. Please kindly test on other platformss (therefore RFT).

Best regards,
Krzysztof

Krzysztof Kozlowski (16):
  dt-bindings: mfd: qcom,tcsr: add several devices
  arm64: dts: qcom: msm8996: split TCSR halt regs out of mutex
  arm64: dts: qcom: msm8996: switch TCSR mutex to MMIO
  arm64: dts: qcom: msm8998: split TCSR halt regs out of mutex
  arm64: dts: qcom: msm8998: switch TCSR mutex to MMIO
  arm64: dts: qcom: sc7180: add missing TCSR syscon compatible
  arm64: dts: qcom: sc7180: split TCSR halt regs out of mutex
  arm64: dts: qcom: sc7180: switch TCSR mutex to MMIO
  arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
  arm64: dts: qcom: sdm845: split TCSR halt regs out of mutex
  arm64: dts: qcom: sdm845: switch TCSR mutex to MMIO
  arm64: dts: qcom: qcs404: switch TCSR mutex to MMIO
  arm64: dts: qcom: sdm630: split TCSR halt regs out of mutex
  arm64: dts: qcom: sdm630: switch TCSR mutex to MMIO
  arm64: dts: qcom: sm8150: split TCSR halt regs out of mutex
  arm64: dts: qcom: sm8150: switch TCSR mutex to MMIO

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  8 ++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 24 ++++++++---------
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 20 +++++++-------
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 11 +++-----
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 26 +++++++++----------
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 19 +++++++++-----
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 18 ++++++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 20 +++++++-------
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 18 ++++++-------
 9 files changed, 86 insertions(+), 78 deletions(-)

-- 
2.34.1

