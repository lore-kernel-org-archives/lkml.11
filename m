Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB9C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 00:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350723AbiFPA4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350827AbiFPAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:55:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14A583B0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 123so12908639pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPYY8cZvI30w8ER/fK+cOf14ZzGBA9BCHkD+gscMWkQ=;
        b=fAHr1q19jOvEfXjfJCwZZ4/weAqlt59BmiKJ21gmjZpttPLpDWSBub46saR0/kU8p2
         mordBF/8pL175BqG1XfItzcvqQK8qJhrtftqdrawzBwS4vfrhkHozzDKgXpFaF6kRmKQ
         OISl6nq60X09yYuuHrNOBKsysg16jauFtiXRhmVNJNu96t+Pj2MHbQT++qUeIPfB0DPD
         7ZG8jIcQ/hdJBLKqE/3QentP50DVxY6KmGTbr8KEQ6DHspUra4SwuMi/efIglpbIvUem
         DWgrMzn2e+JnFsCnvL/KqO5oQ9g77F4tHIj//uueN8PPALYxV5D1aKPzfLey0pWS43ny
         7o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPYY8cZvI30w8ER/fK+cOf14ZzGBA9BCHkD+gscMWkQ=;
        b=cNyJEgbrA09+0axpi3IUYqOKN3jAAzineXieZApIwpVfxI+p1TFQYK5MQ1AM62D29f
         zjcgbWqFE9Wmq4HEiN+i/VtDe4TdnPkgvnlnQ9JIMlYVlhepMmy7RKuH8QmrbjKErxhr
         meO4zk/Altp9Zub3taYUrA7rwVgnFOOxqtH7eDoa69akb7tLSBxcsOb1kMy1y2fu6Zo7
         df4oLLmQSav6DpZa611JqBdBJEL7r7gz4kmc1PqZTSTVFBWr6uZbyFzQ84QTbhn/vmQq
         /i0G7MC9JLiKbmPGcxQcWMosWyMJ4qDl0risoWvZJg108/xknJb9ermE5cLJgbr3f87N
         D+YQ==
X-Gm-Message-State: AJIora8k8qEzL9yens12NWSO93VOdUPS1YE/wYrzs6briVvocyKlVRMY
        tjmzBwBMXKcQEl3BgRbMVIaNcg==
X-Google-Smtp-Source: AGRyM1uvnLQUsVDSNQItG0K+yTguO+3RwCf4ArljnhzBEJnGMwmVLMrD7RgOmrRUPYMg1g+HCG89zw==
X-Received: by 2002:a05:6a00:4515:b0:522:cc82:79d2 with SMTP id cw21-20020a056a00451500b00522cc8279d2mr2118618pfb.61.1655340888304;
        Wed, 15 Jun 2022 17:54:48 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 37/40] ARM: dts: aspeed: correct gpio-keys properties
Date:   Wed, 15 Jun 2022 17:53:30 -0700
Message-Id: <20220616005333.18491-37-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

