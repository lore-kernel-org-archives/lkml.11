Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F315C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 21:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbiFJVeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349954AbiFJVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:34:43 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C09289A2;
        Fri, 10 Jun 2022 14:34:36 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id i16so347356ioa.6;
        Fri, 10 Jun 2022 14:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Q8zSIChJx7LG2al/fQn8LasZmwY8w3RdpQIxdEMIJ8=;
        b=Qtw+sVfNWKW3HkJ9t2hwE7A9rkoq8H1oA0CW5QJO2Kxfi/LaHLNIS4InRVzEL4D3Wj
         CgllqpjtrO1MboVfmG2jomb8bY7i5VjEYMwbrIURhI4xCgCnlDI9AkQhID8/o5ETKAAa
         REMK3eVmjpaE/DuSR289cr63o8Ws2lShqYypn4c9LOgKRYDIWHQ43TGcxsNan69QM7OP
         63kt/MIImsykkzx7rZRBd6ln9HnjRTwvyVGj8roi6gDe40yf3I1yk46OucUNisNlPLai
         nd2D8KKOfAmjtLNhG84enoFKpGFBc0yPH3kfIoo522RS7rgxSSeFQvtgJIe9HArW1vRZ
         FE6Q==
X-Gm-Message-State: AOAM530DpMgkEvhANH9wLIzqK/tM6nztMVq8jHdLu1/oSzdRILuhq9io
        Mr9qJOuMjAEhbljbqgMLWAKXeZZ0EQ==
X-Google-Smtp-Source: ABdhPJwkkQVxue9edvzvtGaVE+mJGQceYKq3+VMtv7e8Qzhq4xKR/Aqe1DDaqI0g3b2TYz6wslDAOA==
X-Received: by 2002:a05:6638:2711:b0:332:1030:d6c2 with SMTP id m17-20020a056638271100b003321030d6c2mr3528986jav.263.1654896876000;
        Fri, 10 Jun 2022 14:34:36 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id y17-20020a056e02129100b002d191911e59sm38631ilq.52.2022.06.10.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:34:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: arm/juno: Drop erroneous 'mbox-name' property
Date:   Fri, 10 Jun 2022 15:33:07 -0600
Message-Id: <20220610213308.2288094-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'mbox-name' property in the Juno mailbox node is undocumented and
unused. It's the consumer side of the mailbox binding that have
'mbox-names' properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/arm/juno-scmi.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
index 4135d62e44a2..ec85cd2c733c 100644
--- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
@@ -187,7 +187,6 @@ &gpu {
 &mailbox {
 	compatible = "arm,mhu-doorbell", "arm,primecell";
 	#mbox-cells = <2>;
-	mbox-name = "ARM-MHU";
 };
 
 &smmu_etr {
-- 
2.34.1

