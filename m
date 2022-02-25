Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA43C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 10:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiBYKQF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiBYKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:16:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA41C2DAD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:15:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k10-20020a056902070a00b0062469b00335so2769706ybt.14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TMc1aLeSvLUW9Q6PJZCnvwn8m1uacpQ0WBS9kTBwjyQ=;
        b=bGXKNU9bb9JweWEkdjzqQzDk8+ztQWRpC2gfebrn0Gdn0ETQfRAQK2apC6JCRdjFPJ
         O8wsQRiJcaR5IQAWymEuH02lmGt3qBwda2aMfatI1ArJ2FgqmdOuthNnZXVw2ZffMaYf
         SbhyiNVOalyrbgRitmjdP7sT0SSROcvAcAIi2gXph450X17MIcs8fIIzpDlrAujuP/2w
         /B0XkEO10Kcr8k6w6YHN8XSwWKIXryruQe8YN6BVkAHQnDdC2vGNGNmApxgIZT6H+tgQ
         mx7EzZCoOpAfYGFpBdA9R12jki6ywp8U/P5WSijGfOvY6jHLKGS4xgaOslSXElGht8cd
         SUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TMc1aLeSvLUW9Q6PJZCnvwn8m1uacpQ0WBS9kTBwjyQ=;
        b=2xuIlRlOjlObQqlbS9Ai4SFNSo8/rr0ZnsVACgDfmw5pCx+fS6tef0bC1u0QbuTuZA
         XsgxpdYoP14hbUtw5NLHMzuMN+Po8R2SGAP7rvgyD9bFzpkGvHPl3aTD7dVc5fDRpkFV
         mOH3bdr4M88vutgutx0oGETovmjEnvW/5o2ddI3yDSH74OQk3tcwXH+vd9aXUvJbj81S
         0DYQ9qMkWVYTtSoPFuU9lD9H2FSkiCKonsmZgNvMofhI/dp8AperU2HUBcAsv/bRbygF
         RVn0dct/rEeazyaOW3xT3rkjxRxFowizdgjFndJrZfzadVGnThyKWvQvQ00uETofhtl4
         Rj4g==
X-Gm-Message-State: AOAM5326ma4XXVgA6BGtTtpJD/zqvmSZUFNeZA/dXpY0AG32Z/eHW3yX
        h1AUpWr7F5caKyeNu0SMfjwA7LfA1GBS
X-Google-Smtp-Source: ABdhPJwZ/1M8EXldTXVv593QFcBOkD9OzETX+tNBpiUAarODOXuVza4Hit9s9vYcPJ+I7by3B5o7oehglJ7M
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a81:a14d:0:b0:2d6:8052:31b9 with SMTP id
 y74-20020a81a14d000000b002d6805231b9mr6617561ywg.241.1645784126564; Fri, 25
 Feb 2022 02:15:26 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:45:20 +0530
Message-Id: <20220225101520.3188373-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] mfd: Avoid unused variable 'atmel_flexcom_pm_ops' warning
From:   Aashish Sharma <shraash@google.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, Aashish Sharma <shraash@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this kernel test robot warning:

drivers/mfd/atmel-flexcom.c:108:32: warning: unused
variable 'atmel_flexcom_pm_ops' [-Wunused-const-variable]

The variable atmel_flexcom_pm_ops is unused when CONFIG_PM
is not selected, so marking it as __maybe_unsed.

Signed-off-by: Aashish Sharma <shraash@google.com>
---
 drivers/mfd/atmel-flexcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 559eb4d352b6..33caa4fba6af 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -105,7 +105,7 @@ static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops atmel_flexcom_pm_ops = {
+static const struct dev_pm_ops __maybe_unused atmel_flexcom_pm_ops = {
 	.resume_noirq = atmel_flexcom_resume_noirq,
 };
 
-- 
2.35.1.574.g5d30c73bfb-goog

