Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AFEC43217
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 12:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347980AbiC3MIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbiC3LxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:53:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B96260C7D;
        Wed, 30 Mar 2022 04:48:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z92so24062875ede.13;
        Wed, 30 Mar 2022 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2thFVVxt8iOgZ/77vqKjkxGRR5i4huEJbYJ2HtMw6Bs=;
        b=QvmXvaXA67wdW5gKoKXNCL4TrnmKgs7pGbyP6N9v0oh8qzX1AhkIdDVPvFuw/qv525
         7pVNXYdL/cPx7qUNvqkDFdGvf1vvLIdjSIQ1qXPfP4i2YY1Gy42ahLVroGE5fMXVmBGo
         ZAPtdBGvLHFD0rL3yJTkZDxPxDKcLb+EmcFJfi1J3OtSnF9FgE2tsoErNYbKvfHPN773
         g5ePXpc+OpB0ZhPnBY3FKwEx/gsbCL53UGhmOpb015zFg9aSVw/EyNVazcCovhA+5dP2
         CZl7R6kQFCOhgLZ4KT+x5Z5Lmf56EwyV5w0wgpTcPkdR7tSCcD0kdZ/AymL4NGqCOnjK
         waSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2thFVVxt8iOgZ/77vqKjkxGRR5i4huEJbYJ2HtMw6Bs=;
        b=obyE8AFNk9R187cjztaSjdHHFCKlfu+ZW1cesc0zjy1Wf6X1RUVFpSHD8RtfRrK3+5
         y5ap/gnMPO13BEc2VmlVj6UiSw37/095gsSD4o+lzekOAvFQNYMFwFLDcYBhC0g21fUH
         cbzRUNV2FHtf9VUHrBXlIwx6VQRZWV8EEGZrANlqqcsgFgO+wFo/KPY8Vvdh97R0ZWGt
         zZeJJyL70b+xPt+kfXJ0wAycZCHp3zVCYEeUj/72tnu7IEZjP8eaSChmCOIR/j5okRtZ
         9ITHbiFgyK3Y3dQqDdbbfVYXLvMtvP2DokLOiIxhLqp8s/CijkOsLJOvQSpG/WRldRPq
         UmZw==
X-Gm-Message-State: AOAM532uveyFf0Olq0SeN/65dvCEPBlWh4JEAG60McfKHr/eho1NPCz3
        uEhiwylOnqQxuBtW2TOqbqc=
X-Google-Smtp-Source: ABdhPJw5YR6043SIYfTA+1UGWgg8uUODu5z2wYnauw+5pAB14UK9my7jiZRCsaGr1TAkDz5GfX0nag==
X-Received: by 2002:aa7:cac8:0:b0:410:cc6c:6512 with SMTP id l8-20020aa7cac8000000b00410cc6c6512mr9938016edt.408.1648640935405;
        Wed, 30 Mar 2022 04:48:55 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm9934442edt.80.2022.03.30.04.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:48:55 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: rockchip: rk3036: use generic node name for dma
Date:   Wed, 30 Mar 2022 13:48:47 +0200
Message-Id: <20220330114847.18633-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220330114847.18633-1-jbx6244@gmail.com>
References: <20220330114847.18633-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic, so fix this for the rk3036 dma node
and rename it to "dma-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 3894b8d2e..c5aa1636a 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -558,7 +558,7 @@
 		status = "disabled";
 	};
 
-	pdma: pdma@20078000 {
+	pdma: dma-controller@20078000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x20078000 0x4000>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.20.1

