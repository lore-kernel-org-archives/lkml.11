Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC21C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 11:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbiFILnv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244200AbiFILmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F231F0FCD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v25so30826431eda.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPYY8cZvI30w8ER/fK+cOf14ZzGBA9BCHkD+gscMWkQ=;
        b=ba9tS/9yDx6p3YctOfdOomzEOyFpkCTwCXlVq0NRt81wXewc1jKS5ajKfPid1M4iPA
         f0bRz2+goebpQ9JpwqlNmkBvRJB7jj5PKZnuyKgZCKOrFPO11bJD08rjnJajtTG82Kr1
         9+/a50S9k9hX8nY5V/RPuxknmTRSTMZpDOYnlym30cZ6f6dSOZqcboNVKHqOBYlBKBBS
         wHXzXlwwo5guqKlI0LzZgeKO07x2IxAm4SRz8/nN+vLCm2DZtXuGJ28n+7CPPcqd8DLJ
         tgdS2Dte0d9q9H4HFx1W5q3kIqT6P4l5saj1WjNH+h1a1msGx8F8tnWJehzKsc2tcnv7
         J5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPYY8cZvI30w8ER/fK+cOf14ZzGBA9BCHkD+gscMWkQ=;
        b=2Z9Hxh8Bou905oQ05uOFxSshMZLXCXiepehPx1En0sAnuAZ989ebyBPNa1EVTR+cgS
         jHT4zc1GtMA99zE+mW53l44orGUDtZ9VPDt2IjeFgqEfALeEsxuSwQZngl6XT1UrN9KC
         whIy7rmaZ0fJBbS4YQfNkGhXhSsI2hvqiUvDoJF02JeK+5NZPq69zE3uXxGfQGsm+8yF
         rra47XY66Mco6wvOg1BZmlEjLiDJe0eNARejZ7+JdMBkE/5cvSicmaz6ggSnBTxn7Rj8
         I7ZOH0/Vc2pyQoZFl+Lvv74A/oE9aVqMVwAwpOps6P8Xe9wb5AVsT/tetMoCLcNohvKY
         j4dQ==
X-Gm-Message-State: AOAM533NgP4Zow0wM8ug5f0KKiBXbQyGxMH1Haa0BJE+QfGwB7wtcPx/
        dlN1fvuimzK0VktS2kouXIZGJg==
X-Google-Smtp-Source: ABdhPJw68zqypVGGfQ1a4rssxPK/TfiBKSa4tSC0UkP1YZyhup+4T8pJBHl+SQ0ffRoqFi/7DjvqiQ==
X-Received: by 2002:aa7:c54b:0:b0:42d:be18:c261 with SMTP id s11-20020aa7c54b000000b0042dbe18c261mr44708606edr.267.1654774856916;
        Thu, 09 Jun 2022 04:40:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm10498662ejb.80.2022.06.09.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 43/48] ARM: dts: aspeed: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:40:42 +0200
Message-Id: <20220609114047.380793-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 2 --
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 2 --
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index afad8d732cc3..a6a2bc3b855c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -189,8 +189,6 @@ vga_memory: region@bf000000 {
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		event-fan0-presence {
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index fc8222ea2dd0..bf59a9962379 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -179,8 +179,6 @@ pcieslot-power {
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		event-fan0-presence {
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 6f6a35fe2caf..3f6010ef2b86 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -65,8 +65,6 @@ event-ps1-presence {
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		event-fan0-presence {
-- 
2.34.1

