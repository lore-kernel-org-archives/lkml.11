Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 12:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiBVMBB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiBVMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B55156C70
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so1628884wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TT58Pxq1258T4AxyuLdXgL1OIhP7Hr2onHMX8NaDui0=;
        b=OlsqQ+HYW21fdRD6Ie2kAF0sLLQXbbvVHzDRxuPbFBpppJeOcibTqM53uRG725SIm/
         5hZ/AGJpEmJP5N3am+fe7KIvlFwLrrn93UN6ZV3ky4sQrUoAs5TVKpAU2Q4F+cz8SQGX
         K+rfi/eblBV5qbMFbU07oElE7eOsTeU1tp/c6zSPfUQlgNqwOKlMS4iRRFl5cAIU1zyN
         CoftkLdoW0KnNngUjTdrxms5xLic4p6+Etf3nDx2U7ZAufFJf6o1G7O/HKH14OlwAIdL
         HxNtQvbXxGDxymxxMkGeYxlSLWZEiJ5+Y4A+VovzD/K2OmbM8zA4S1Zvalqg2czbNlVg
         nz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TT58Pxq1258T4AxyuLdXgL1OIhP7Hr2onHMX8NaDui0=;
        b=4xAAj19DmUUVXpiSpMZ09fssFq1Q/rJMqxDhwHyaSH9zJOZOT8apcIoIFvWVSn95KF
         JEHFv0mjKs3hxZELp+vA1YNL6HulUCLYKdxNUUzsgr9eXYRxU5Lchq+9opsBfr3nUmSx
         H9pcSyZ5VZcNwe+WJ3usV+sQlKOuMS6p+wmQHk9cr8BxanOoebMseKc4a7VUVQBLIr+8
         +MlGiQwr04zW3E/ZZgmcZUO0CJZwGJQA18cxpWFZ+NsEtOHv0btm83KiQCFEUs0c21o4
         JFUD3WL/O2zV8MHkaqWBGbL1/dgnR660SLybVvhEnCIWK0XQv+n/B47ogY4jUgPj+1tL
         TeWA==
X-Gm-Message-State: AOAM532trOr4aNSKWflNfzupvmUJTYRGvkDSA7T2kSvP3CV1NHRy6Gxu
        gTcz3DOmBLj8y1B16PVftEk7wQNJFnM4Hw==
X-Google-Smtp-Source: ABdhPJxBY/ikhqjz0AGd2wmSRhvxpIVt0C6nKXdpBIDhdfbRAM6xKSfI39VaB3VRbnro5u+Oi0EiQA==
X-Received: by 2002:a1c:a915:0:b0:380:e3de:b78f with SMTP id s21-20020a1ca915000000b00380e3deb78fmr321477wme.19.1645531196938;
        Tue, 22 Feb 2022 03:59:56 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/16] ASoC: codecs: wcd934x: fix return value of wcd934x_rx_hph_mode_put
Date:   Tue, 22 Feb 2022 11:59:26 +0000
Message-Id: <20220222115933.9114-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wcd934x_rx_hph_mode_put currently returns zero eventhough it changes the value.
Fix this, so that change notifications are sent correctly.

Fixes: 1cde8b822332 ("ASoC: wcd934x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index f2674905a4a7..ab580f37cf00 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3314,7 +3314,7 @@ static int wcd934x_rx_hph_mode_put(struct snd_kcontrol *kc,
 	}
 	wcd->hph_mode = mode_val;
 
-	return 0;
+	return 1;
 }
 
 static int slim_rx_mux_get(struct snd_kcontrol *kc,
-- 
2.21.0

