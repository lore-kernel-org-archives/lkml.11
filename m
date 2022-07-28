Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA55C04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiG1Vdi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiG1Vde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:33:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7C74E22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:33:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso3440731pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGZnlwTei/ZzhPPKyBsKYsctyA0v2J1Oq7FlaRHkiC0=;
        b=MBmpKNB7026bTVxYfXlRK9k4pKS9nLVwHoNfZAsAMcTcg/svGGR02m1rj5rY+/750d
         i0OpHdPRsd09HXyTXq2+SylxrUYxFtO3QyObum4qmKbH2eAaWg/d5SmvyburO3DvfE2g
         6CFXMlfRcC6HQkFpDAKgEMjCYZGwfygaTYXUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGZnlwTei/ZzhPPKyBsKYsctyA0v2J1Oq7FlaRHkiC0=;
        b=NJjQzF9uIkYKheeoaOtLyoYPWEi9uQZR/vFVJjxc46Xmyy2fH/ggxV13zAGwf2ZR3b
         SkHS33UXh7ndRQa85/CHHlP/MHqfx8dBZJtZJB0UMGzOHjNwfFwDh7V0iLx/zP1GZGcM
         YEFp69UZWtmzvSmGuTbFCArEiJo1HluizUSdaAdaBh/9vYADCu3VawDhO39tcNEgyaBq
         7DVrjKltEJwq8STkXSSNi2Oi7xR+8FHR38ME+aQivyQujwToQojKpFJQni/kkZPG/sjj
         U6EbgLyjYxqENecngzGsYUw/MdmyvUrwQyX6tVH6n+fv5dtBzZCGh6Q6tLYoNyAWxwHV
         gd9Q==
X-Gm-Message-State: ACgBeo0G48xDI7zHL6TTu8JRTIlOVqXIb1rBwVaTYKljYzr3r3T1tBXW
        ZtMFuRfUhCjo2QM8/bQrrc/ABEy2Byn+wg==
X-Google-Smtp-Source: AA6agR6bZq/Ocotiih0eHd8FKhNfBUdHpJ5zdhjB9mpln0C4dS7tPtoNELEb+0sIdl4sZKb2cMuD0A==
X-Received: by 2002:a17:902:e80c:b0:16c:28a6:8aa0 with SMTP id u12-20020a170902e80c00b0016c28a68aa0mr829420plg.119.1659044012578;
        Thu, 28 Jul 2022 14:33:32 -0700 (PDT)
Received: from moragues-cloud.c.googlers.com.com (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0016bf4428586sm1756930plf.208.2022.07.28.14.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:33:32 -0700 (PDT)
From:   Bob Moragues <moragues@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     swboyd@chromium.org, mka@chromium.org, dianders@chromium.org,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: qcom: sc7280: Add support for zoglin
Date:   Thu, 28 Jul 2022 14:33:21 -0700
Message-Id: <20220728143215.v3.2.I7d57fb9c4806a8b3fe3501c766b64f4987c271ef@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220728143215.v3.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
References: <20220728143215.v3.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
Zoglin is identical to Hoglin except for the SPI Flash.
The actual SPI Flash is dynamically probed at and not specified in DTS.

Signed-off-by: Bob Moragues <moragues@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Reset Author
- Fixed duplicate Signed-off-by

 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index 6d324ac2dda1..98d09187fc69 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
-	compatible = "google,hoglin", "qcom,sc7280";
+	compatible = "google,zoglin", "google,hoglin", "qcom,sc7280";
 
 	/* FIXED REGULATORS */
 
-- 
2.37.1.455.g008518b4e5-goog

