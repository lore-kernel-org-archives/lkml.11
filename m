Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C6C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 15:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbiBTPQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 10:16:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbiBTPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE634BB1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:53 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c192so8135839wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AjbCoFPHwgXlgVhaHAoW47X9tb9L1pRYHiXqltbW+iI=;
        b=F7r6smAuasKrsIW1o21RG/D+0ZGoEoQM/S5iu5VNpy7tAQX5NpGfvAK06AeIDggyIc
         UPfKFtqX+dJch1F+xhLRrb/8pb/HLnjAPOwXve0HvxVYVJzFaEkqIKsb397NCVoxjwFP
         X+KjLN/xe5vc9A9I6EE4zBX+Ix666ReazrzSxgJDqAS7FSuh+6IFq7DA1BDzcBbFxdam
         ZzRtUz+UVTavm2KR6y/4jFIV0px2UjsFDVqStdE9D1zyVv0RcVvZUSYHwwo/3R5gkHJN
         1Tz9zxfAtNAPYCbnREaWm9v5nst48Jkgq7oobG+KhagFTd9JKoHyJAPtv5OT+leL5mAP
         69pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjbCoFPHwgXlgVhaHAoW47X9tb9L1pRYHiXqltbW+iI=;
        b=zc68OR1FhVOaw9SZc4ehg4TgQiF1qTd+wChQZvZSKDuMHbNkced78ZOIEYsNnzR/61
         e+h4xJNMylyfrNCvnQh5oTExR5rt5sB1DjwcqRjk4qdN9XOaYBpjDLVXgAZq3Jm57YLn
         7pX+pBe63nGpB6YZ/Z0Ld00AXFyXDsp7XOwPdjyxrkEACQFVR6TdDuvyO3Kkzx3/R1j9
         iLLeV6Ou8AVOecGQflgQ/C3bZI5nyfY5/PX5lWuJ1bT3zpd8IzAFNiXTK1rgrs1VraZV
         MQj1AopEgbbCBzAXgwbvI2X9s5+qOolrh7cJtIlf6/lxYzk1+Qtz00G06m/Qtzb9wRyF
         2iIg==
X-Gm-Message-State: AOAM5334SDmZB7udNeRb+e38SEwj5B1qaubD6Tljh/TrXDYuOcNCORFh
        JbIB8J0aZZgK1iWhWfnbeNRpe8I6HP593A==
X-Google-Smtp-Source: ABdhPJx1hTDBEGOH7VBzcafFAueFaoRh011MCubD53+Vy4xLw1ZjZeOvHwEgehH3ZGp4ovbM+qeNLw==
X-Received: by 2002:a05:600c:3512:b0:352:d502:bd0c with SMTP id h18-20020a05600c351200b00352d502bd0cmr17751784wmq.164.1645370151696;
        Sun, 20 Feb 2022 07:15:51 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/13] nvmem: core: Check input parameter for NULL in nvmem_unregister()
Date:   Sun, 20 Feb 2022 15:15:17 +0000
Message-Id: <20220220151527.17216-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

nvmem_unregister() frees resources and standard pattern is to allow
caller to not care if it's NULL or not. This will reduce burden on
the callers to perform this check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 327c88c432f0..f58d9bc7aa08 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -903,7 +903,8 @@ static void nvmem_device_release(struct kref *kref)
  */
 void nvmem_unregister(struct nvmem_device *nvmem)
 {
-	kref_put(&nvmem->refcnt, nvmem_device_release);
+	if (nvmem)
+		kref_put(&nvmem->refcnt, nvmem_device_release);
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
-- 
2.21.0

