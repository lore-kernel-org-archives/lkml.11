Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE99DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 15:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiBTPQ4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 10:16:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiBTPQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255AB34BA8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so22805088wra.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPxVOPedb7VSlKJrNqeXgyqzEIVCKAODI2AGkqq7jh0=;
        b=YGrymPtMsXeZaHEpHtmPZMlg3m+LYLl71bOPVMnvF/ikOOpY1R326ccQHH77Tz7CwM
         66tLMVK0kGZudM/UgNRSMDqPnFKGlzlniu05V0P8tl39/xzGON45pSrOPxSOI4BpCgsZ
         762VoLHvjM6+3HAPk0s84HgAZd1DjSMiG+t14TpvvkeuYgkBmjQG3wQqLRXg9pW0//o/
         3Lvakym+02l3Uuk0jwiSVjJKzj79hs2w9l+ZLy7JJXufxDFMgvs6EwPjysvzTww88L9F
         VUPiQN9uuBpRQkDBWdxqII9HTBtxPDWjISMr/4l6qfwI/ebblm0PpIMcvhmIb1gcmfHy
         i27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPxVOPedb7VSlKJrNqeXgyqzEIVCKAODI2AGkqq7jh0=;
        b=qoXHljor20ZjQ5svblFNYJ2Lt8S1VlDMKNGT0a7hBc3M4aOFIHccLuhg7/pIq6KY/U
         lnyohKbdm3X6k+19PWfLfxqtuVqPfKjREpVzmpyKZHEBvEzpCXeG6k9p4gKdW2Mr8cBB
         P92ag7PENdpSsPtFhJDQWfa+uUw8F1vEXpX8kGgB+npu9EaAQcFdMzoZbt1eMaAe7euV
         THejBczV43g6SoyC5tFS6Mgoo4Z8BP82VloaAwKmFDL3uQrF7EHjxcBHpzPdDOavw/nW
         HfmbTqDfdCHxZfFsLTupsOH7+g7TsXGcceX8iVK+Lb4b3tmzgNW2TjsYd2qdtlq29f95
         /y5w==
X-Gm-Message-State: AOAM532b4Y/LR+Qa35QNkJPP9qHki+ydnqh8DU8LxLjov8djeRabNEFe
        YVZgXV8SoHXCaU50XC+NQXnJQA==
X-Google-Smtp-Source: ABdhPJzoK0LZ8FPn8rmbGAiwjODLqINRZujKRulVkIZMKPBEB7QQS5ZgLH3spfqaJwJPiGfgysMM+g==
X-Received: by 2002:adf:df0b:0:b0:1e4:979f:a56f with SMTP id y11-20020adfdf0b000000b001e4979fa56fmr12356206wrl.686.1645370161675;
        Sun, 20 Feb 2022 07:16:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:16:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/13] thunderbolt: Drop duplicate NULL checks around nvmem_unregister()
Date:   Sun, 20 Feb 2022 15:15:27 +0000
Message-Id: <20220220151527.17216-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since nvmem_unregister() checks for NULL, no need to repeat in
the caller. Drop duplicate NULL checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/thunderbolt/nvm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 3a5336913cca..b3f310389378 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -154,10 +154,8 @@ int tb_nvm_add_non_active(struct tb_nvm *nvm, size_t size,
 void tb_nvm_free(struct tb_nvm *nvm)
 {
 	if (nvm) {
-		if (nvm->non_active)
-			nvmem_unregister(nvm->non_active);
-		if (nvm->active)
-			nvmem_unregister(nvm->active);
+		nvmem_unregister(nvm->non_active);
+		nvmem_unregister(nvm->active);
 		vfree(nvm->buf);
 		ida_simple_remove(&nvm_ida, nvm->id);
 	}
-- 
2.21.0

