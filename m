Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2051C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 07:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbiHWHc1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbiHWHcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:32:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C763F34
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:31:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l19so9554698ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7YI1/mD3H5QF1O/Ij6koXffrhM7CpoDCp7KLGJ6O08c=;
        b=G00hZRHnUf2Hz3UvWhraxzEB0JU27Y0SFqnd5o1A18QbOAY7d/xlIN22REHnZfO1Dh
         7jprbbDtgbnLsIfJflevOAEYkZHOHTTgrFeJsuWeLFglnC1imgmANcRb8VDhUsMM1jHe
         u3xrNgozooLDNcpSmLiy+zztG1yrsRGbzmbJ5wP4Iph3jb7PTt/ZHGz14Qc+yQC3XZqC
         aUHzAuwxDwv1k6l7E6Qm+qzZAnTDqUqQ3JldMyPjGKiMUtnjeAST5hmJqXBSr21sAVMy
         Cyawd5b1H03v8bu9zYxwYSUjb6yM/WGTl0TjsnX+iYJSoqCUPwbLCXbYWewcgIT+0MUX
         cNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7YI1/mD3H5QF1O/Ij6koXffrhM7CpoDCp7KLGJ6O08c=;
        b=ukFIre378t7F+izpssJW4VAvylEcU1Xv7Cji7ocaC+JyPinA8dz+Tizti0M9YhhUzu
         oB6OFqzDExXG/FaydOVTS1zCRX3tFZx4ZArC6NGAl7yoa+BmMF0vHxqhuQ00RiMXlpDP
         O7lsapnQf0cQ0MNVv0kztbSvOk3aicYraRHFtax+bbVeX+nKofXMEbjjSyguLGRlPeEt
         Wj/E0E7knylijNpYewv/Hbzh+Q0wtEU5bVZ6BffZM7yzohWV9s6nbOUDNIfK9+tCJW5I
         TivU+fh7ORdy+sJ16kWDNx9gnZvJ24ixFgJtzu8SFyXLVFFEbM3NQQpkhhnr46+yHNga
         EIag==
X-Gm-Message-State: ACgBeo2HlvG2386/gttBgsOwuHBQqg0ZHf6DHB3356YJVuKsipexJDpV
        u712m2Xs5YiZSp9SFLt+SLredA==
X-Google-Smtp-Source: AA6agR67LH3YIXGRYOJYLyEPYICUo0sBRP/ptta4AAYJ64nephyTvVgVKF/3OT3Y7CTNH/7bXXCODw==
X-Received: by 2002:a2e:9d97:0:b0:261:bb31:4b6e with SMTP id c23-20020a2e9d97000000b00261bb314b6emr5479712ljj.59.1661239916815;
        Tue, 23 Aug 2022 00:31:56 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512370d00b00492f21c161esm398504lfr.123.2022.08.23.00.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:31:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clk: samsung: MAINTAINERS: add Krzysztof Kozlowski
Date:   Tue, 23 Aug 2022 10:31:54 +0300
Message-Id: <20220823073154.359090-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Krzysztof Kozlowski (already Samsung SoC maintainer) as Samsung SoC
clock maintainer to handle the patches.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Agreed with Sylwester who is recently busy. Let me handle some patches
as I already handle rest of Samsung SoC.

I plan to send pulls the same way Sylwester did - to Stephen.
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a72b303aed5..13d2b804dfa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18048,12 +18048,14 @@ Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/platform/samsung/exynos4-is/
 
 SAMSUNG SOC CLOCK DRIVERS
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
 F:	Documentation/devicetree/bindings/clock/samsung,*.yaml
 F:	Documentation/devicetree/bindings/clock/samsung,s3c*
-- 
2.34.1

