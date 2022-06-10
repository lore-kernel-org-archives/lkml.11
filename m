Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D12BC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 13:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbiFJN0T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbiFJN0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:26:11 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98B15A3DE;
        Fri, 10 Jun 2022 06:26:05 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c144so17361229qkg.11;
        Fri, 10 Jun 2022 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ow44vJixTJI3bDLbO6IuQAgGyjbFuK55tv6KHdA7yKE=;
        b=mlTLGiRQqGAqZUXhGPc9iKwdlZB0ss78nnQ8j03HInq0uIUB98UynOy2B/ZNvV/Y/N
         X2h5Uh8tnxYia6rUZqlhfoR9fI0ipHP0GFy1zLRw/gvoWjv2M/myc/cYmoBMgEVrbaLA
         B1olK1qQB65AuFPKiA/5OayHIYJKZTD0jxadaqxkCpAIbCbaxIoO5M/iwZg9pcIgnlVc
         gPjc0XLZvEI2CeRF/9CdKWV+BHS3kPiS4cM6ib/oaaXaC3g9uv8vnkj1MrVqV1aniZO6
         ztmA5psXbfaulM6yvIE1BxqpgC8ZR9bXeyg6lzmmKgTCsh6mwk1MiBGHnZ02i3Ked4dN
         c9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ow44vJixTJI3bDLbO6IuQAgGyjbFuK55tv6KHdA7yKE=;
        b=qFgwIfHc/NZDMP95I04BozrcsjTbWW52nyHbkSMRtOufsdhPniMrxdlS2d843EpZtE
         1xC1j9hQRFyt+yEdzS/Pmyu3lnyfb/P8IP2BJiN3Ot4rv+AQTYgmVjoIVrQ3cLijSp8X
         Ki51qSVA1Cyc0w0OEOx5fN988Qdw1P8LmvbPIFgFtYYRAPtlxPROwbXOM8LVpMPfaNeg
         D1ZubQ8RlhiiUGdtXtA6BAF0KNjVvweu9+IDl09cYlWBZI461vHcu6HJRriMu2fXdDpn
         Jy6YaipLrQWEIghNuWTI+IXuQi8mvIvehg3JOXZo7ch3njYvcdQQvGsvhOdNKmCNj0X+
         RPnQ==
X-Gm-Message-State: AOAM533OAuHFQEbOq69Yydj+s85rGzwx/unb44kF7PbW5xxAug/3AFWX
        iQxz+vJZtyJJX/IJO5GG0O1KFzWarzaKzQ==
X-Google-Smtp-Source: ABdhPJzdF9S6OSps6LldwbWkRol9JBXWt5aJOVrTn8JJEeavL0ZEONRe2Eo3CfToQROOPOUB1v4uQg==
X-Received: by 2002:a05:620a:4726:b0:6a6:d207:7a3f with SMTP id bs38-20020a05620a472600b006a6d2077a3fmr15475207qkb.239.1654867564570;
        Fri, 10 Jun 2022 06:26:04 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w184-20020a3794c1000000b006a098381abcsm21509546qkd.114.2022.06.10.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:26:03 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix SoQuartz CM4IO usb
Date:   Fri, 10 Jun 2022 09:26:01 -0400
Message-Id: <20220610132601.160088-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoQuartz CM4-IO should support otg mode, however it currently
defaults to device mode when otg is enabled. Force it to host mode to
retain the previous behavior.

Fixes: bc405bb3eeee ("arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index e00568a6be5c..56764fae9f9d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -169,6 +169,7 @@ &usb2phy0_otg {
 };
 
 &usb_host0_xhci {
+	dr_mode = "host";
 	status = "okay";
 };
 
-- 
2.25.1

