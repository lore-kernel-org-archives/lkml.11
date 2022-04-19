Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00051C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 14:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353458AbiDSOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353351AbiDSObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEAD36E00
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u18so21520321eda.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6s86ztZ9i4gltSTfmmUOVyO/MGpMN4qkvOmSz3AXdzw=;
        b=yR5vGZwXVsBJoNIX63D+VCdWL5RJu4muJ1qC3RlsisXdrCXpHZ7wG/ag4NCcNPkq3g
         X16rqQ+cZans+oIxR974kvdYxeXyG80fGUlF8u4uWN7uG4WZ9A1xeBjZqbKU22LydNz6
         LVZzZVJJdw+wpd2J3RqAJbvmeoihVhpgao0DBQ9gWNbDFKAl7vpjB2V6PW7H7rKdROL/
         xxO2xfycGca+G6V/q+bCHhq7fh/y7bn5WKyovaod4dauPezkoHAe2nquJ0XMzb4qwhOE
         WO5Zq/+Qxw65Kyclyff/WFUDjBbxSN8A3T1KrPkoly6yBgauK2oPH9r7Y/W4ucrlvBRM
         iCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6s86ztZ9i4gltSTfmmUOVyO/MGpMN4qkvOmSz3AXdzw=;
        b=v+0lYer/w+jjNq9IEwcqtDJDMCtZ+HGcDYSNnmlS4PVtU2PBXUnSRsYE5UXGwyeyZ6
         Owd7cs1PzR+2qLGX2skM6o9LSFBPJGpndB36SAaUmChdkH/BqwG7/EGG9nzi4mi27xaq
         gVr/Yo8bD8DElhHUJb3KOtnyNPRce8bqolLFu/CjReMdEAPe+KujORuuerKj6WXRnApL
         hwCTcD8Y30gaplX3or0og7YOwlP76AjVZ6PmBD1iDdU1/XP+ym5lkQxKhZfBNfTmiHco
         Et0LNVFSU/g8rDrXGq7KZx6s+e++QQXS4dfpbA1arxHxqrpQiXgQdxuYcBQfzFHiITlQ
         A1sQ==
X-Gm-Message-State: AOAM532BtvNUmWLFuHwU38wxpyIMvlOAaFOOW3vUbIXJMpKBGk44F2oB
        6Siq0wlFzLWQZ6JrsKL1a14g5w==
X-Google-Smtp-Source: ABdhPJwTSq4nyJkaO1GJYSQFpLEjq/23ZwGJlORTN7uwO0J7XP1+AtB4AGKFfzY2vcHpRLpabgtqtw==
X-Received: by 2002:a50:9e61:0:b0:419:d8e5:6236 with SMTP id z88-20020a509e61000000b00419d8e56236mr17660959ede.327.1650378547924;
        Tue, 19 Apr 2022 07:29:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm5761884ejy.93.2022.04.19.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:29:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/7] memory: da8xx-ddrctl: simplify platform_get_resource()
Date:   Tue, 19 Apr 2022 16:28:53 +0200
Message-Id: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() instead of
platform_get_resource() and devm_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/da8xx-ddrctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index 872addd0ec60..b32005bf269c 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -115,8 +115,7 @@ static int da8xx_ddrctl_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ddrctl = devm_ioremap_resource(dev, res);
+	ddrctl = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ddrctl)) {
 		dev_err(dev, "unable to map memory controller registers\n");
 		return PTR_ERR(ddrctl);
-- 
2.32.0

