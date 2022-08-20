Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB87C25B08
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Aug 2022 18:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiHTSRm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiHTSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B430F71
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t5so9131383edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GZU6i7aDhQpE9Y4RDqbtXF3Z4a0g0R6IbiFmWRA8yYM=;
        b=KL6nER2nrF3su/u53V4e/nPH8TwgstfI7LTmxj9kEuH2LZvGlFTMY7xbnu5k/IS6gC
         2QkMIapsaXz8ygipyYvpAefCe/2XagtRSC7difoSWdnt+Z2Z5vn+dv/522YfpBSbEEZd
         mrvWfFfYFRnT9x1X5cylXTfszqVzqsvQtVgfM7aLWm91oe7l5ony9Ca5XaX3i86vy9wn
         HA7+lCz2a3pO1CcNZf+hw+kqbEFruVHkIBK9W9UzgnVhjf/6jzRCI6tKz3KOWxKo0CRh
         a189231pKGValY0cXoxWzEduJXA8069MVcOX66u7uqeBF7BZJwe8wdi7aMYPHeLLfb7C
         gRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GZU6i7aDhQpE9Y4RDqbtXF3Z4a0g0R6IbiFmWRA8yYM=;
        b=kURDmf5ui2rJsx4+S9SEDLq4MhEbUgbyi4VWTvqjbJqF8dt+X5MxFqD8s1HfmYP7R3
         OL6xckVZd8pGbDIryK73yiCSvao73sCa6EoRDyOKrxnCz4UFTtIOumZArgiOxBOx80k8
         1Q6rLixscGYa7+QKc6zLGqRexbvKQiPZCPgE5Tb1nsYAqbIWZ3AQMePa2xo98K2r0D1i
         1xpuR5BJv0dsnnlaLuqYweVvinm7XiozhjIHo4MJqoQeACbpFc2hc0Bw+PD6vG25X1g8
         pL6QCjoJiEKZEqssa3rDTWbyAQy25MQHFRwJxDHgFldhwWOhMzoKJZOgECCh71W9ZL3h
         +Wcw==
X-Gm-Message-State: ACgBeo2OJB9F3alD398WswRe43bsSjGc/otMO86x6pXoTh/Bo7PxenzZ
        gSceLwfJbazxFKGji7w3FlU=
X-Google-Smtp-Source: AA6agR6oLVTY6qUsqCtwJ6uLznILUKKMYi6isg2sqEFLxh10zLVCr3PFa8YEiYu2OwIDQSa3929V5w==
X-Received: by 2002:a05:6402:5212:b0:446:6910:5549 with SMTP id s18-20020a056402521200b0044669105549mr3632612edd.345.1661019404495;
        Sat, 20 Aug 2022 11:16:44 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/19] staging: r8188eu: remove unnecessary initialization to zero
Date:   Sat, 20 Aug 2022 20:16:16 +0200
Message-Id: <20220820181623.12497-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization to zero of the variable 'len' in rtw_pktfile_read()
is not needed. It is immediately set to another value. Remove the
initialization to zero. While at it, remove an extra space.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 51672984156b..f79889011cd1 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -429,9 +429,9 @@ static uint rtw_remainder_len(struct pkt_file *pfile)
 
 static uint rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 {
-	uint	len = 0;
+	uint len;
 
-	len =  rtw_remainder_len(pfile);
+	len = rtw_remainder_len(pfile);
 	len = (rlen > len) ? len : rlen;
 
 	if (rmem)
-- 
2.37.2

