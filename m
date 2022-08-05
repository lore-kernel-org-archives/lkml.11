Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B949FC25B07
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 09:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiHEJX2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiHEJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857EB78203;
        Fri,  5 Aug 2022 02:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2ED6181A;
        Fri,  5 Aug 2022 09:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C628C433D7;
        Fri,  5 Aug 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659691399;
        bh=DAxKUz0LlJb4IegCrjgY4Md5USCcmXrIxdb4ljvc8co=;
        h=From:To:Cc:Subject:Date:From;
        b=PfKtlMjOlT8zzvd9fyqZZQ3IKWRHBzrJaU1RWHFPCwzIddSmYtJnGe6ckjTiLuwbi
         jKz7wlW565rQRieSQAYioEIWkPZUWE1ZEWGkXStV1PlMfNMrBMEGQxa+78nrXzFkfh
         /DhDvq7PEuCjskgq9LBB1nppX+d6lAzPDMJg/B9zEof+TBLxAmSN24xLjfP2Qjke2m
         xCLoy0sVe1RF18aAL6a+d0r1nYJM/yLdQa2RWb9kJK2sYi7avLRjoDhNPM0sHPqYjl
         Z0YPpMntJHjXlBQtGmaarntrncLUh3/C2pQNtKyvRLMjCLqirgErt7CL9qk9gG9CGA
         +jzzWPZmW2coQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJtYU-0001J9-SX; Fri, 05 Aug 2022 11:23:43 +0200
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
Subject: [PATCH 0/7] arm64: dts: qcom: sc8280xp: HID wakeup sources and alt. touchpad
Date:   Fri,  5 Aug 2022 11:23:10 +0200
Message-Id: <20220805092317.4985-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series clean up the sc8280xp CRD and X13s HID nodes somewhat and
marks the keyboard and touchpad as wakeup sources.

Included is also support for the alternate (second-source) touchpad
found on some X13s laptops. Note that the node is disabled for now as
ideally the boot firmware should be determining which touchpad is
actually populated.

With some additional fixes it is possible to have both nodes enabled and
letting Linux do the probing, but let's wait for a conclusion to the
discussion about whether that is desirable before enabling them both:

	https://lore.kernel.org/all/YuJXMHoT4ijUxnRb@hovoldconsulting.com

Johan


Johan Hovold (7):
  arm64: dts: qcom: sc8280xp-crd: disable touchscreen pull-up
  arm64: dts: qcom: sc8280xp-crd: move HID pin config
  arm64: dts: qcom: sc8280xp-crd: mark HID wakeup sources
  arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: disable touchscreen
    pull-up
  arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: move HID pin config
  arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: mark HID wakeup
    sources
  arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add alternate
    touchpad

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 22 +++++++++--
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 38 +++++++++++++++++--
 2 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.35.1

