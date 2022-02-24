Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 00:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiBXAfU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBXAfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:35:13 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C39F3B8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y5so418800pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjlQPejglQ4l0/ZVVSaNpSupfbDyFF7DpYFPDOdJqWE=;
        b=c/jS859klS21fGUvkR4Gw/Q7uZQ4a3LJVJ6f4aao1Mo0O6PvBdAnTE6iW0WnKCyeg1
         lXS33l3mNaqClERlEyP8fOm7LMKI00NHSoXibHRN0cFkTJujdovuJu5WHRMueex4O0vZ
         MAjsmbSgavXKDi0bbSJIX17c/VxO1HObW+L3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjlQPejglQ4l0/ZVVSaNpSupfbDyFF7DpYFPDOdJqWE=;
        b=x/njET/L1GOyVreGSdxi2JvuQ6QwRudIsUUqcKthNfj0rpVS1Vh7L7px32PnpPRGzB
         TkwzvMAFZLafj90CiCQQm/up4zzXfoNAYdsS0+6leqrz/SSpTWZv0oQVBw+J8Ob7i+vA
         oyWIuyfxRZav592FT8VYEVV4F8ynleX62ZputxSuc7oOofaZA/deDfOxSxhATY3uV+Mb
         V+wIg34RUuDQMqfxXdFqKBsPmewmZBQGjgopLjm0uGsG0R6T8Im3pM9iILoh99Nf9AwS
         3oVIB3fch1/3UV78J2xXnmX5f5RQI4XP6yuGONnhmwqmiBES2HbR62K1OoQK8fKw6J+9
         G7rw==
X-Gm-Message-State: AOAM530Tf+pqaaWGlHplKjAchJVcwjXoHHPmZwH/iXSAhvud8+EKetIA
        62FuhUkXVsNtsIl8to7YAh82wf5j4E8Mog==
X-Google-Smtp-Source: ABdhPJwRH9RI9geNc69VQvb+Z2AsIzQqCH++UjnphZBy4Hyi/jD8hpHjdHngO6ZsCs9XInfCqjsMeQ==
X-Received: by 2002:a63:5fd7:0:b0:338:9599:f098 with SMTP id t206-20020a635fd7000000b003389599f098mr291528pgb.226.1645662880866;
        Wed, 23 Feb 2022 16:34:40 -0800 (PST)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:e321:1e1b:f71e:33c])
        by smtp.gmail.com with ESMTPSA id ms7-20020a17090b234700b001bc7e6fc01csm4100344pjb.40.2022.02.23.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:34:40 -0800 (PST)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 3/3] ARM: dts: Update jedec,lpddr2 revision-id binding
Date:   Wed, 23 Feb 2022 16:34:21 -0800
Message-Id: <20220224003421.3440124-4-jwerner@chromium.org>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
In-Reply-To: <20220224003421.3440124-1-jwerner@chromium.org>
References: <20220224003421.3440124-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the tegra20-asus-tf101 device tree to replace the
deprecated `revision-id1` binding with the new `revision-id` binding in
its "jedec,lpddr2"-compatible node. This was the only DTS in the tree
using this binding.

The revision-id2 (mode register 7) of this memory chip was not given in
the existing device tree, so let's assume 0 for now until it becomes
relevant.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 020172ee7340ec..c700f80e2a366e 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -756,7 +756,7 @@ emc-tables@3 {
 
 			lpddr2 {
 				compatible = "elpida,B8132B2PB-6D-F", "jedec,lpddr2-s4";
-				revision-id1 = <1>;
+				revision-id = <1 0>;
 				density = <2048>;
 				io-width = <16>;
 			};
-- 
2.31.0

