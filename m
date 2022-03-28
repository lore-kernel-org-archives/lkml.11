Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2E9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 11:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiC1Lvt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 07:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbiC1Loj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBABA6468
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y10so16530680edv.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jodBJRHAI7bQz4eWwISuZPyoBIq/i4bbo51R73wWZsQ=;
        b=cuBRhvoBXuanGhKSopcvIdj8n8tOh0tDDSDLs2SoiymrkH056m1LLdJfNLKZ999Xyc
         734DU4Fd9gUARO66ZZX9X/exhiR4P6KNvvGlYnT3QgOi/0cSspeWbNS3onozAPjg3H+y
         +UemaqBdynCqs/+mW/b0A22RRrwUv2lmt/Bqwu2YzmICGvlP/I/j1wJvEC1dKO/wqUkL
         CwzN11AW/zD88zdFwM29XTKkL3OvErj1nJDVgNUAbPQCt80xhYiyVWMQos0Xopp/3cQ/
         QOwH8JatTSwwlXIr+SntO63DlUXmqgIIh2gpT8e4fxYBqY1ucy0JW007R7GXvVto+HJF
         3E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jodBJRHAI7bQz4eWwISuZPyoBIq/i4bbo51R73wWZsQ=;
        b=MbpYBvOVVmD2IpwcOxtJDeDIyi5lYQSgydi6Ou8IyjvwY4BvVVYZwFh3ZNXQgD77P3
         BdIjCXOvowIubv9ZFdhCGWEOoCMsi8BTTZnxgtOaaRkgrCO3HEgLHJuiXk/ou338bIp+
         QQXNHfFG6SefchbE3f9aMrvE0wJVZxQpnzGVHUhEM8DVIf1FZcNd7ThaESoJfGGHytaZ
         sTHBELA+o+7gR8inFr9bDl84VCr55Q/ydCqtORBevcBSDg1+nSn9o3YY1LumLeNy+c6z
         iyS2EKjJqacAEIT2RoAYRSRFgeZV/0FugLLN0+YOzP/Tjt+zgGTKtY89ZWVcyaqIIM3y
         Lk7A==
X-Gm-Message-State: AOAM532OzxrarhRjKgD0H74b1YNtStz/8ybCjxV/qXPeZ6KgnUWrWTGa
        3ZvD58td5bt2Bb2u8HTJlp3Y/DuiCzs=
X-Google-Smtp-Source: ABdhPJyG8GUy6GyP5HcwR2//q/nK/QMklSt2zhCs5fL7M/rNPZgVcifTmo1kATZDImdgNVnggYHrbQ==
X-Received: by 2002:aa7:cd7a:0:b0:419:48ce:3a10 with SMTP id ca26-20020aa7cd7a000000b0041948ce3a10mr15464848edb.312.1648467597358;
        Mon, 28 Mar 2022 04:39:57 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/9] staging: r8188eu: simplify if-else statement
Date:   Mon, 28 Mar 2022 13:39:38 +0200
Message-Id: <20220328113940.6396-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328113940.6396-1-straube.linux@gmail.com>
References: <20220328113940.6396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify a nested if-else statement to a single if statement in
rtw_joinbss_reset(). This improves readability and shortens the code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 83841cf85a0d..1569f719af1b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1810,19 +1810,15 @@ void rtw_joinbss_reset(struct adapter *padapter)
 
 	phtpriv->ampdu_enable = false;/* reset to disabled */
 
-	/*  TH = 1 => means that invalidate usb rx aggregation */
-	/*  TH = 0 => means that validate usb rx aggregation, use init value. */
-	if (phtpriv->ht_option) {
-		if (padapter->registrypriv.wifi_spec == 1)
-			threshold = 1;
-		else
-			threshold = USB_RXAGG_PAGE_COUNT;
+	 /* invalidate usb rx aggregation */
+	threshold = 1;
 
-		rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, threshold);
-	} else {
-		threshold = 1;
-		rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, threshold);
+	if (phtpriv->ht_option && padapter->registrypriv.wifi_spec != 1) {
+		/* validate usb rx aggregation, use init value. */
+		threshold = USB_RXAGG_PAGE_COUNT;
 	}
+
+	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, threshold);
 }
 
 /* the function is >= passive_level */
-- 
2.35.1

