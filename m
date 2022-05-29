Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB84C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 May 2022 11:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiE2LOt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 May 2022 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiE2LOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:14:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D062980A2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:14:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gi33so16137126ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGhstKLsyi2KJ+CtRUGYDx9gAOcoBt1ORpXxBhyJ8eY=;
        b=rhxV0Z1V3zfgBPgVVe7tv/AAiK+DBDDaEkHv94ZUbrB648F2ZB3DSr5iKqOPw2ro1H
         MQx7LFkJXU6LnLfrt9CyoIo74GtkJgmQuYUheoxin73O52csTjjQEjal86Qe5UCVPnN6
         qh/eA6sZZ7gIGVFKb/WWM4zFkdpZIXtCXIlM9D0VeQRmwaC1bVm2MiPXzVajeuFn6g0I
         jjKCWfaElOuqCfu3RxCbdXPToPZrfEg3LfGHgbRhmaWhoWwTJhjsrHWWcQ/15jNbPmIj
         rsOWAupXYfk2YQErqdnu90NRds7ejSw55TZKFkpDPggXqxxWuShcoqa1Cxculjw89YYc
         u54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGhstKLsyi2KJ+CtRUGYDx9gAOcoBt1ORpXxBhyJ8eY=;
        b=sdQBwftMmhxqLzBw5YvGL3ucKIHUEIBe2vHcHzVe9oXlVka0L7YEFAEz6f3srsJcys
         cAZ27hvXz555YTksCLoE5ayEYieLt7VbBEhHU9gcajBFpxaRq+9fg4P+ZN4VZmleaXuE
         ihfQfBCX3w3WlKXeKWHgz/S5eag+IDJctGMiGGruiUqjI94UJLRXim0b8cHN5XVxLBAF
         6XfYS6jBgxkXCbfaqPBbPTeaKv57wBNHd8dVT87iHGzkadnHnP98I4fcZRRfP3EbHG83
         lROJ9l2Jwv0LOG+siu/DN3Ecd/kma38Y9zoba4Qm22f0wH9GENq8au5LwTzv0i2wLqcz
         JUQw==
X-Gm-Message-State: AOAM533vd6pNzfLokAS6wMId0ZRZB+I3U7grPD0vG+yCNBu8TaVro5JO
        nIhG0iqPi8S+utPKPbHo1v+OHg==
X-Google-Smtp-Source: ABdhPJwqfJO8L/+sv/ODyACstbNznQsCsqUfk45ZMaUmJejvzc8E1H5Mro8SHweV6EA3FC1iq9ujKg==
X-Received: by 2002:a17:907:9805:b0:6fe:c719:f45d with SMTP id ji5-20020a170907980500b006fec719f45dmr31475165ejc.43.1653822885846;
        Sun, 29 May 2022 04:14:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hp17-20020a1709073e1100b006fecb577060sm3086313ejc.119.2022.05.29.04.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 04:14:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: aspeed: vegman: drop unused fttmr010,pwm-outputs property
Date:   Sun, 29 May 2022 13:14:42 +0200
Message-Id: <20220529111442.182722-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fttmr010,pwm-outputs" property is neither documented, nor used in
Linux kernel driver, so remove it.  This also fixes warning like:

  aspeed-bmc-vegman-n110.dtb: timer@1e782000: 'fttmr010,pwm-outputs' does not match any of the regexes:

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-vegman.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
index 1a5b25b2ea29..43af63910571 100644
--- a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
+++ b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
@@ -166,7 +166,6 @@ &sdhci1 {
 };
 
 &timer {
-	fttmr010,pwm-outputs = <5>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_timer5_default>;
 	#pwm-cells = <3>;
-- 
2.34.1

