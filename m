Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88791C6FA82
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Sep 2022 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiICWlt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Sep 2022 18:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 18:41:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7537D474F1;
        Sat,  3 Sep 2022 15:41:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 9so2001774plj.11;
        Sat, 03 Sep 2022 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=koGSFeL8YK66YnxxoLTJOiqK09bB1eXPLPZIIXte/UA=;
        b=ZXlItbIUXZJeBZNi4fNoOofx++nkBztOPswlufi7hsJZuOvgl9SqtGtwpAdeFYlYBk
         Xe10dyBgBbpZJxD27CP9QLpvKwUWTyCj9VUTj9ZL47QtWZULNg54LFBwryD1qjcnHw+j
         7OIHR3kbmDGdP5rf0TVsEZWWtvkyXvf/i8FOsts0U66noZp6g31LEyl0oVN4k6UDDyn6
         tjeiFz62s8NnaJg2MzWofok2qg1GITaAFY+wsFSTQehv2ZiYx+Ty5kr6elofC1NNAjNW
         6mkcFhQUGgmEHwlS8uKX3Ao27jjJR3bnKA3Jwv6QQw+1phsLAM3FdqrG31ZiwZdJrpdr
         hbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=koGSFeL8YK66YnxxoLTJOiqK09bB1eXPLPZIIXte/UA=;
        b=gYEBVp3E1Ap+ssC3zieQWZiOoFyRkmj6HtKAg6PmF2y/Ryv0SNWEdym3tSKeWexAIQ
         5/BuD/sGsivXbypG9tpHetgaXlO2ucxQJ3AnzxkI4ZfBzH1PArazhe7jtLDtJHDG8QlO
         NSBovVABsVMTUO+JTylS/Hubh2KryjjZqw+QSn+AFngBc4yylDxLH5CK5i4JWYjOMazA
         qfNkzV0MBRB3kj8lUMHGDFlxEz1AoP96Olojl5HbfVy5hiIn34R7qTL47+MIknIWaDrZ
         bGCaswyW3iekV0F440MgaEkcI0UCEeKe1rae1TPzdlvSrdd8WnE/1pFJ9a+m29AdS6ye
         3rkw==
X-Gm-Message-State: ACgBeo3mOYO9RP33bHvVn2aLdaxLLYtFF9PnFKEcv7wt3br2fR6b7AWc
        2m+uPTSWJsnU7XAUT5AjCXdTW+gfIYyExA==
X-Google-Smtp-Source: AA6agR7xv/T1Al2kzbEb0TtlJsWkZsw68moEA8j2FQ+m61VOwRRMvmO56czT0JY0t3aWBR/opjHQJw==
X-Received: by 2002:a17:902:8307:b0:172:e611:491f with SMTP id bd7-20020a170902830700b00172e611491fmr41752428plb.111.1662244904427;
        Sat, 03 Sep 2022 15:41:44 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id i15-20020a17090a2a0f00b001fddb3a5481sm7502193pjd.49.2022.09.03.15.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 15:41:44 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v2] drivers/clk/clk: check return value of clk_pm_runtime_get()
Date:   Sat,  3 Sep 2022 15:41:25 -0700
Message-Id: <20220903224125.2276690-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_pm_runtime_get() could fail. Check the return status.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/clk/clk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7fc191c15507..09353f7bf052 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2981,8 +2981,12 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 				     int level)
 {
 	struct clk_core *child;
+	int ret;
+    
+    ret = clk_pm_runtime_get(c);
+    if (ret)
+        return;
 
-	clk_pm_runtime_get(c);
 	clk_summary_show_one(s, c, level);
 	clk_pm_runtime_put(c);
 
-- 
2.25.1

