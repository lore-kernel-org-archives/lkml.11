Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A835CC00140
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 02:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbiHACXH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHACXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:23:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B312770
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:23:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so10973373pjh.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=44toAmeXFLVRg+CDUFpVxjmhxjEoa8U0u76RiZEMUIw=;
        b=VjWIYiMyJB50PKB6OAOhPxXMBKqW/a19igCONHcyniCbFXGxmyHAa9gYXAX87foVb3
         /U1/nWDhkn+D9VsfnxGBYFBnOctulIJjO0k5cISuwhRGkWi8UMoCP5G5YxYA5ce/JXRa
         NSgBTrkNTs5l+JiBpRV/SERHkcpSp6W+6S8LrlE0Ig999U8rAzbeLzIvn8qQsMpWL/LQ
         ExeSekN2AYzO0zEPTvWv4LBDn1FcFwoELfVKc7HuLparefpzUXeRuvqpAomF2bmmN6S+
         rcKNo1t+9a3bWbZ3B3w+jvKvOeKFO80YzplQZ8vVhWiFzkVSG697KJ0YVkgj+hO6VZ0U
         Ku8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=44toAmeXFLVRg+CDUFpVxjmhxjEoa8U0u76RiZEMUIw=;
        b=SKMbihDcqGI9yF/BbPVVLqj0+AwbFDeotnuAOsaI2KVoXLwBmJnWnSkQvy0RaIUTx+
         sefgHXphcNWIpKHmcShhQ83F0RrXtVsXmSDrY2R9NDWIh2DeEHR1AhycDHv2Ek4SigN9
         +6vua6Jf5ArwZdzTepy0wTwIssIHO5NlmxrV+1yav+77fc/vQ4Dv8Q786U5IlZMPVGQY
         6AV/rFS4EuSmdx8hoU7wXstI6vpFZYvEz4/FPzqI/wwxUeZI1BSH2r0aaH0Ylns7VPUg
         Pm79732APWLCQ6hXvmbtJTzWtjVpgwCRjO3hIq4zlzlKO05XFsxdcoLjd7Ygq9hg/M1O
         Kp4w==
X-Gm-Message-State: ACgBeo0QekpHy82wjDUj733DeZmnb2UYFqFyg1kOm+vaRITczrCBc8mE
        OakA48nt8o8QUljhnhqiOA2nZVWzTcU=
X-Google-Smtp-Source: AA6agR7EGL0L4sLrCqLkQeeIi1kiz+ZlnqQJumoP82f+82c0TXOgOUvBy/Ma46T4ubLhHdFmxO8dCg==
X-Received: by 2002:a17:902:cf12:b0:16c:a263:62b8 with SMTP id i18-20020a170902cf1200b0016ca26362b8mr14192049plg.31.1659320582754;
        Sun, 31 Jul 2022 19:23:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 145-20020a621897000000b0052aaff953aesm7136393pfy.115.2022.07.31.19.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:23:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] recordmcount:use the !E in conditional statements
Date:   Mon,  1 Aug 2022 02:22:58 +0000
Message-Id: <20220801022258.1594336-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Use !E to replace the type of x == 0. This change is
just to simplify the code, no actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 scripts/recordmcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index cce12e1971d8..8d01decd12e9 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -139,7 +139,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 static void * umalloc(size_t size)
 {
 	void *const addr = malloc(size);
-	if (addr == 0) {
+	if (!addr) {
 		fprintf(stderr, "malloc failed: %zu bytes\n", size);
 		file_append_cleanup();
 		mmap_cleanup();
-- 
2.25.1
