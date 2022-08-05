Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB75C28B2B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 09:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiHEJXY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiHEJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8C78206;
        Fri,  5 Aug 2022 02:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1586183D;
        Fri,  5 Aug 2022 09:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85147C433D6;
        Fri,  5 Aug 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659691399;
        bh=S0yVGCrgMNr6x3Uzjjk6JhHX4OwT+7UD4sUKQW7juXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oz9LQ+Zm8O+HgDOF6DVqEjUJ4pcgrytcRhCml+yyf1MI3lROLbtp2YYwrGqA7a55w
         m1wEa5gxzyB65Syy5OR61mxd36kbK+krDPQygwGn+ocqDZQrT0dZA/FdNgpfjZlo2b
         9VYOnENYLi3swx+xp3Kfm2evoSBHOeyIECi+XlJvaI7HN3mkUBD6yxKG4rJAik5L2Z
         pLdepsVTCUPlFpOyMESVldkKfOeCLZXDGnRoJhVvDtFsXczA1bk9yCxItmdLEugC2d
         0t+5uqsoFIazfTuiRpOWpPDhpPZ+g8ce87MnVMPj1x4Q4zGJIemUyEALBiTmD5NtV5
         flxnHdtjkw1BA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJtYV-0001JF-Ss; Fri, 05 Aug 2022 11:23:43 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/7] arm64: dts: qcom: sc8280xp-crd: mark HID wakeup sources
Date:   Fri,  5 Aug 2022 11:23:13 +0200
Message-Id: <20220805092317.4985-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805092317.4985-1-johan+linaro@kernel.org>
References: <20220805092317.4985-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchpad and keyboard can wake the system from suspend so declare
them as wakeup sources.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index ae8be1b743ce..fea7d8273ccd 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -237,6 +237,8 @@ touchpad@15 {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&tpad_default>;
+
+		wakeup-source;
 	};
 
 	keyboard@68 {
@@ -249,6 +251,8 @@ keyboard@68 {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&kybd_default>;
+
+		wakeup-source;
 	};
 };
 
-- 
2.35.1

