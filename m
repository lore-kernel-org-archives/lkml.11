Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155DEC00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 04:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiHJEFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 00:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiHJEFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:05:09 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F57E6FA0F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:05:08 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10ee900cce0so16457246fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Vlw+TzWyPgd12y2oMgL4R4HJ50qc9vxXJ8xI2NT6Tgg=;
        b=Mk4YfbNfP4qekf3kspd/n/RA9L1SskyD7kfFxDIvLgVsj2TsbRdfY9nGNc329hUhxM
         eA770fwsJI+gDIGmLiCNVDI4QiLq09juBYN2Gg0yQaLti5RIWuYKIGRXUn5nzqhhEKp0
         eVvmNbyWIknpUporgF1/3gI8g2AxZuGpSNmrdn+DXZTjKC/D3HpET2yvcNmjLeYHVtn8
         0LOA6D4zDQxKayH5LiH56wboTQcGwYtKG+Wkmlf603G8zHCfU2Om2CggUrEGDE3ubMdY
         PJq7XIh/n7nrB5ke+cEDQ5/FhTlIzlV82aEOzs01o11XKmdRyhXUrSu8tUvhsX/dO4v/
         TOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Vlw+TzWyPgd12y2oMgL4R4HJ50qc9vxXJ8xI2NT6Tgg=;
        b=qTM8Aas2Mp8XeTsS7lbsp6n62w7XdSCL1+pDks8/LVgsBEdf2yVbd7D52raLEAwzVG
         yu6giQ3O/GWukr/LePSJx7PF2eISHx9m/0qGIBWJF3piZB8owckRQVlPH3hbQ+9OUmr0
         oaSg5RnDF5k3akEPNBw3nA3SgnMftC3fKcQ4UZAL3gnZdnb65OOjmDgCVls+TTVD6Uap
         3iD8XFwKGlTafhCOI+CY+5neUEMUjPK1gdef9RGxo+XCb+ayCH2OjYGrrUWwbwwg6rys
         5mYhjP/QGsGXTpA8C9OdzzE4MvQc6rLDCg6nBDfEyt/siW7kggbHjMVqMLu5ehAJyw7d
         MkBA==
X-Gm-Message-State: ACgBeo33ViCIt5IRQfnkdcWnSGCLFojW8Ruo975adYcsbE5X581e35RO
        MJMnfnYQV5dtDsDJH2rBexTBDQ==
X-Google-Smtp-Source: AA6agR4LektJYrndrjLttwdRSjj4K+7Ffy786YpK2tM5CGpnIvHPzcP5IYgpUzjroGVsdFZZ8NUYCg==
X-Received: by 2002:a05:6870:f203:b0:108:4a52:da42 with SMTP id t3-20020a056870f20300b001084a52da42mr663381oao.59.1660104307980;
        Tue, 09 Aug 2022 21:05:07 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q6-20020a056830440600b00616dfd2c859sm449027otv.59.2022.08.09.21.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:05:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] phy: qcom: edp: Introduce SC8280XP support
Date:   Tue,  9 Aug 2022 21:07:40 -0700
Message-Id: <20220810040745.3582985-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What the subject says.

Bjorn Andersson (5):
  dt-bindings: phy: qcom-edp: Add SC8280XP PHY compatibles
  phy: qcom: edp: Generate unique clock names
  phy: qcom: edp: Perform lane configuration
  phy: qcom: edp: Introduce support for DisplayPort
  phy: qcom: edp: Add SC8280XP eDP and DP PHYs

 .../devicetree/bindings/phy/qcom,edp-phy.yaml |   2 +
 drivers/phy/qualcomm/phy-qcom-edp.c           | 193 +++++++++++++++++-
 2 files changed, 184 insertions(+), 11 deletions(-)

-- 
2.35.1

