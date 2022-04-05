Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCCBC43217
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377963AbiDELbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbiDEIvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:51:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615DD1CC8;
        Tue,  5 Apr 2022 01:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FE95B81BBF;
        Tue,  5 Apr 2022 08:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF6C385A0;
        Tue,  5 Apr 2022 08:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147963;
        bh=kHivgI89ExcwhIzHs0s0eahszGcG5QZveN98bO2rNkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmIbB7ctzsKRE5xMdffszgApwDnkdrIXHN65XTfJMQ/6ifVEM2L3X0WIxUgd9Z5KZ
         0GTFh26Uru7JQGhn5MvyXvpXtDiautFnLtjjy6e84w1CqiNAnIjugmNFlQfN4sIq3b
         MQvLLu/DnbAxNWE7J2b8iXofbqq/TYaTFvChIy2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 5.16 0158/1017] ARM: dts: exynos: add missing HDMI supplies on SMDK5420
Date:   Tue,  5 Apr 2022 09:17:51 +0200
Message-Id: <20220405070358.906688065@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
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
@@ -124,6 +124,9 @@
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
+	vdd-supply = <&ldo6_reg>;
+	vdd_osc-supply = <&ldo7_reg>;
+	vdd_pll-supply = <&ldo6_reg>;
 };
 
 &hsi2c_4 {


