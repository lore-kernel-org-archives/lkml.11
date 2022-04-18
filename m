Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiDRNnQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbiDRNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C23AA41;
        Mon, 18 Apr 2022 05:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B633561287;
        Mon, 18 Apr 2022 12:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF746C385A1;
        Mon, 18 Apr 2022 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650286280;
        bh=uyKI9NfuAsg1H7QgPgrX80qRQkedSTzgCAc8mfglP2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jfj/535+N2UrLqDo7EDwnEMs26JqMi6YWMzgTcG99h4+UoDJDCqUQL+TVrEbmXigw
         C4DYAvG0ex0+4dVmnBkbNXH3kN4PfS8lI4OrsfK44EMaM+lQu7IRIsIyqEeArIBLJJ
         R3QRHIXNb1SqOryz9To15wcvACT8z+JDZTddcmwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 4.14 044/284] ARM: dts: exynos: add missing HDMI supplies on SMDK5420
Date:   Mon, 18 Apr 2022 14:10:25 +0200
Message-Id: <20220418121211.948260093@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121210.689577360@linuxfoundation.org>
References: <20220418121210.689577360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

commit 453a24ded415f7fce0499c6b0a2c7b28f84911f2 upstream.

Add required VDD supplies to HDMI block on SMDK5420.  Without them, the
HDMI driver won't probe.  Because of lack of schematics, use same
supplies as on Arndale Octa and Odroid XU3 boards (voltage matches).

Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20220208171823.226211-3-krzysztof.kozlowski@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -133,6 +133,9 @@
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
+	vdd-supply = <&ldo6_reg>;
+	vdd_osc-supply = <&ldo7_reg>;
+	vdd_pll-supply = <&ldo6_reg>;
 };
 
 &hsi2c_4 {


