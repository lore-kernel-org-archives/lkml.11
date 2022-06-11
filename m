Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7BAC43334
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 03:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350192AbiFKD6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 23:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349130AbiFKD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:57:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18FE11462
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so1077335pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRhMR0ZHYhacS3442LotLCWWOUVPdNCodU10GIEMY0w=;
        b=Bikr50hWOgc7DNBC6J8V9OgTaGPyggfd5K1DmchOjSSYF/aiVNAoiFOXQNCc9j7oDy
         rHADQT+de00Tlzb56K4YyRrR4ZP3IsrxnAjP3EnZkD+VQ6ZO2T7T58rSDuQENcujxMLQ
         eJJ8Fx26CkNaLqLT6vtCgg3tq3u+F7u7XgvGpZe4aTxN+cMM0QHv84F5RPXP1CSd1Mof
         pfBgR1Yr3F5++iQHpBbaDAmYPzAJf/la/A6bRNAGspLj47QgGKXu60ENvOaL5ut/w4Mr
         NN/Tw+eHpnfOqM7SicupIzJKw+kh21jNRoL2/ubHzEdO5wXUX9k+QHi4mAupYe6voUs7
         PUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRhMR0ZHYhacS3442LotLCWWOUVPdNCodU10GIEMY0w=;
        b=aFMSh3ClMbCQLgEixGyqBRvCUgZgbkFQekCtuXZazusFgbf2VSiLI6xAZRxVLds1KU
         4lfqto/xXyGfdpar5dZrEtizIVq2qar406b32f4rO4vD+FLaHeifXx1TPcOaYdCkwGqg
         xdCqtzlpw3I85rbmP7SHk4wYv9G3Zbfhf/H9urdR2JalEwIq4f2ovdELx+ulxU13O+JE
         ZDJAqbUYkR/0XkNEn7XDI6Q6kWPiAgRZa+tsYhMKEmbtF8aztQCjejtzNBRjeJdWzaPt
         47gYzbxukMvYEzXJRwqGwDCLnBAPvgb0GtzYt2OcP4UqYmc2pApxiyOUY0iECloCGT+T
         3sMw==
X-Gm-Message-State: AOAM530bMkEi7yrMkajTOAQwP9JCyaxuuO1jl0iEx8Zik/oiEk8ds5na
        Pmn+ui21ktkX9MjZtos+WcM=
X-Google-Smtp-Source: ABdhPJzGgybSUKDPG1nlM6xxS/2e+0mjaKFrXr6aIaPH6O/k0r821mFiWjuBLf3vkhd6gImVMWO5Zw==
X-Received: by 2002:a17:902:ecca:b0:166:3e34:4d01 with SMTP id a10-20020a170902ecca00b001663e344d01mr46885922plh.97.1654919878399;
        Fri, 10 Jun 2022 20:57:58 -0700 (PDT)
Received: from localhost ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id ct21-20020a056a000f9500b0051c0784cb45sm381671pfb.99.2022.06.10.20.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 20:57:57 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v4 4/4] mm: kmemleak: check physical address when scan
Date:   Sat, 11 Jun 2022 11:55:51 +0800
Message-Id: <20220611035551.1823303-5-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
References: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the physical address of objects for its boundary
when scan instead of in kmemleak_*_phys().

Fixes: 23c2d497de21 ("mm: kmemleak: take a full lowmem check in kmemleak_*_phys()")
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 155f50e1a604..387d6fa402c6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1184,7 +1184,7 @@ void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, gfp_t gfp)
 {
 	pr_debug("%s(0x%pa, %zu)\n", __func__, &phys, size);
 
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (kmemleak_enabled)
 		/*
 		 * Create object with OBJECT_PHYS flag and
 		 * assume min_count 0.
@@ -1204,7 +1204,7 @@ void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
 	pr_debug("%s(0x%pa)\n", __func__, &phys);
 
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (kmemleak_enabled)
 		delete_object_part((unsigned long)phys, size, true);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
@@ -1218,7 +1218,7 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
 	pr_debug("%s(0x%pa)\n", __func__, &phys);
 
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (kmemleak_enabled)
 		make_black_object((unsigned long)phys, true);
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
@@ -1493,6 +1493,17 @@ static void kmemleak_scan(void)
 			dump_object_info(object);
 		}
 #endif
+
+		/* ignore objects outside lowmem (paint them black) */
+		if ((object->flags & OBJECT_PHYS) &&
+		   !(object->flags & OBJECT_NO_SCAN)) {
+			unsigned long phys = object->pointer;
+
+			if (PHYS_PFN(phys) < min_low_pfn ||
+			    PHYS_PFN(phys + object->size) >= max_low_pfn)
+				__paint_it(object, KMEMLEAK_BLACK);
+		}
+
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
 		if (color_gray(object) && get_object(object))
-- 
2.25.1

