Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 08:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiCBIaJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiCBI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:29:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2044CB82E9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:29:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso4163281pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOhvmpBLieRVF+NKQPb4pdavGDEjnXCIzLlMLWWpOKA=;
        b=Eqy9IPjbLYYbIstc/J+JZ8WTf619n0h2r8uqKqJ+e6S9Uv+eWqpcul4UbryOb5p+/u
         MaSxXNwLLByowHTqGTJmAsxIcHxjSri8rtIKgWnK7dAxgThGETtK7a3vlVgTsAIso5ar
         jz6a8FaGafuyrVazLBfr548UwTAKf5gemmCc1q/mdgh/EBxhT2Wvwoij1uyTH3KARIXd
         jcdjAZ9+pZL04jxy94vLnK5/fYv2dad6VTjRS0mMTD7NNmpGZHjiGq1JUbhrnPSfBT1F
         4WAiWLScu72rwaHUnfiXZdJgAL3fWS9Qcg6grtWwG0Zxwea9ard9epbbCH3a5Is0pfue
         VlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOhvmpBLieRVF+NKQPb4pdavGDEjnXCIzLlMLWWpOKA=;
        b=ePJxzRFNOB7Ofhm6EeoQrRgMF5Czpy+iZM8PMXR+qGBLQCLFTDATgWS4F2XUfaZ3uW
         kV08quvMVR6O490pu8EB1y87kX56F6Yc9iSXTRZwIUaG0fRyt966tzokRJGRYYmWfYfU
         ikW6WkcxywPi2KMn6EvoIXlDjOHSSNedg49pkfUZvg89BIcREPzsyvWM5Ia5RO4EqJzh
         Sswqry3OXpz7KtG/zQRaxvSGrfoPfAJo099fudYmbMylTHWY06cmTUirXO5XOeybjteq
         Plh06KuvBz2j8IKMEZwGxX5w8dtG0DcMLX1Jbk11uBWEEZF8P8xDOEinml6M9WlXt8ee
         dSgg==
X-Gm-Message-State: AOAM531Dhp70Qn8qUo+obtwahmoxiidk4sSqZ+XTRsfICctN9MNIcBWV
        HmKmgOwWTVnkdfRXGNBaX/24pQ==
X-Google-Smtp-Source: ABdhPJy4/KlcXCarIW7Ivk1JNvCCmPY83Lz2efEDwfG2djMlcALEZNHFvUurWjFDAawaZRfirDGOSw==
X-Received: by 2002:a17:90a:ec09:b0:1bc:d7c2:b2d5 with SMTP id l9-20020a17090aec0900b001bcd7c2b2d5mr25500689pjy.22.1646209752693;
        Wed, 02 Mar 2022 00:29:12 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f396b965a9sm20922228pfv.49.2022.03.02.00.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:29:12 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 1/6] mm: rmap: fix cache flush on THP pages
Date:   Wed,  2 Mar 2022 16:27:13 +0800
Message-Id: <20220302082718.32268-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302082718.32268-1-songmuchun@bytedance.com>
References: <20220302082718.32268-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
However, it does not cover the full pages in a THP except a head page.
Replace it with flush_cache_range() to fix this issue. At least, no
problems were found due to this. Maybe because the architectures that
have virtual indexed caches is less.

Fixes: f27176cfc363 ("mm: convert page_mkclean_one() to use page_vma_mapped_walk()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/rmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index fc46a3d7b704..723682ddb9e8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -970,7 +970,8 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
 				continue;
 
-			flush_cache_page(vma, address, folio_pfn(folio));
+			flush_cache_range(vma, address,
+					  address + HPAGE_PMD_SIZE);
 			entry = pmdp_invalidate(vma, address, pmd);
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
-- 
2.11.0

