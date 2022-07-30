Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D22C00144
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jul 2022 01:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiG3B1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 21:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3B1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:27:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC45D0C3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:27:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e1so6185176pjl.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jn4/LA7fxNt8iXGVssrYM+dajHtnWZvbUaOvrA1fJlQ=;
        b=UherdjpeAiGSg3iy6gWENoRuu+eJVyt1yoSXDWVcALTCxNeCo9woucCva3GKjeCZGc
         04mhRO9LuBK1m0Qur0gZE0zICckc0O0sVmn1pqdBybPI1oxHYTA42TYjTXAISgp4itEY
         8A3JXLb9igc9E/SfMD8ZGmzbjDL23OXQU5ms7CFqSsSqjvTK9KatpPkrnpD0S6DvK6Je
         qFg6iRtDxeTHR9yxylPrOh/Y9iE1HJpdU4TtQs/Fttyxq6c70qlIDUkBgoiyD57iBtlI
         BYZGksjyQV0LW7yP6iHYnEC9qkifgGQDYZ4bE3o6fqx5IJvVvs7f2rmDM7NKdpK5uTMw
         wE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jn4/LA7fxNt8iXGVssrYM+dajHtnWZvbUaOvrA1fJlQ=;
        b=G+W5k7ESnGBXZumIqJPlngYn/+R1PGLYTphEbR6CmHmIMIa+26zHADe9X9mo4KbmC3
         h8f35hLPmz70SYTlcMO/kt/2UT1kYLko0ulxt8ZVj7+QwePQdR5wn9STcDNWww96VqNt
         UGb6zyXNBhQRtmO75lmgUSC3aq9Be6qIDH9faJEUX14G6x/dqybCirocAU4MzmwIGcxK
         jruaC+ZyZbBck4sTstIN/kjE9NtBKEIXgn99EfuKiWhYZcVvvoCtxAtfUiGoMWZNzCvX
         ANZ0+gdTlqVQJgT7Y4uKax4RIE+C1qAQJW2PjPvXPH5jkcCu/8fiVWDLjdQplgV6sseq
         TIRA==
X-Gm-Message-State: ACgBeo00OR9YT15HXyWFcCT9iwmuNX8S9C2R0Uluv8/9LvA3oOkL9oag
        D+zmIqEBCiI9Ci5oG4Lq2Bw=
X-Google-Smtp-Source: AA6agR7JDXm24wIBhiFmWsY1Z8pdIth3ZJyCwhmhZ3BrwBim+03Up78YuCPWc7TOoQPnbxX/3428cA==
X-Received: by 2002:a17:90b:3c4a:b0:1f2:205d:dbac with SMTP id pm10-20020a17090b3c4a00b001f2205ddbacmr7012517pjb.110.1659144450067;
        Fri, 29 Jul 2022 18:27:30 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a414900b001f251948ad6sm6518255pjg.35.2022.07.29.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 18:27:29 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: fix wrong debug message on rf69_write_fifo()
Date:   Sat, 30 Jul 2022 02:27:24 +0100
Message-Id: <20220730012724.1138-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug message should describe error when user calls rf69_write_fifo()
not rf69_write_fifo().

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/rf69.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 659c8c1b38fd..8c7fab6a46bb 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -816,7 +816,7 @@ int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 
 	if (size > FIFO_SIZE) {
 		dev_dbg(&spi->dev,
-			"read fifo: passed in buffer bigger then internal buffer\n");
+			"write fifo: passed in buffer bigger then internal buffer\n");
 		return -EMSGSIZE;
 	}
 
-- 
2.30.2

