Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C8EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 07:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348351AbiBHHg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 02:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348333AbiBHHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:36:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB365C0401F1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:36:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n32so17430505pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rv2PEt6IIiPLW9lZEeUjxxgQpIiSoXGPYPSbKMenEs=;
        b=mWirpXFETjjymQb9FwJYTXT9RWcZSQSLT5Nsh/1DBOfuh2Biuy/KM+f9R5CeJIlYYC
         GDwg8fBYZTDlssF3zNfvwJnkHHLbN9g9hR/k68bwOWP4LlYKrolMPPGjF06x1diK+Vpg
         Oeq7EOUsr9mUAe81PFskxE4Owu3enMTWXolrKTdSt0ZY2vd98WKWzyNREyikVcUun4xE
         SyrT606wjX2rhlV21mzXjz0B6XCMwG0ldcYNkSV1MewRFtJ3CeKOt8uPKd04zxFdx6ft
         e8aAg8sn9SGEQdDo3KLTRL2+fX4oI1DR15XPBg91kF7l+/phcejECxxqPkHZHbrWx/sK
         7lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rv2PEt6IIiPLW9lZEeUjxxgQpIiSoXGPYPSbKMenEs=;
        b=Sz6wIAjKTllQtKMOlGo/Z/qmeCGGGCs4DOqmcWuQhYoEksutlioJXZgsx/0fw1m9Zj
         bmbAwoCa37sLJa0Irz3dXicRuKVZttarzy0uHvGt4WE9ClBUPKytwcqCk9NfjpMQO7Pg
         gDIb3e/Kwm2u7S7EaGXBZS0L95IC1no0t1Ay9PiFDEDwVbP+RIKuyBBM6ibTeUlxS9eb
         LzxSAx/ll9GwsDBRXtc24Ut+4TxMxW6gi29D9308tDokt9U2BPVgi+L6kJHKWGaiv6NO
         1wyfVsN33hwr6TYHvnpnB+1IQCc5xQln+QjNBWHc7fh/tagpMQISK98exxRd31diUmXx
         /e9Q==
X-Gm-Message-State: AOAM532du9Dhd8RE4VHJaNPGP85CMAN0ijwW9Nbb/1wbKGlixvdP4Gf/
        gG11/b8eFvHVI5noMHrlfARhyw==
X-Google-Smtp-Source: ABdhPJx5wI1WRTMKEZCVCDQaBQBLj00V8f1A43/kPGwa6KwBioaxK5T2yS6JmK55WW3Uw7U4O59aTA==
X-Received: by 2002:a05:6a00:1253:: with SMTP id u19mr3314465pfi.8.1644305811236;
        Mon, 07 Feb 2022 23:36:51 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id gx10sm1621017pjb.7.2022.02.07.23.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 23:36:50 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 4/5] mm: hugetlb: fix missing cache flush in hugetlb_mcopy_atomic_pte()
Date:   Tue,  8 Feb 2022 15:36:16 +0800
Message-Id: <20220208073617.70342-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220208073617.70342-1-songmuchun@bytedance.com>
References: <20220208073617.70342-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_copy() will copy the data from one page to the target page, then
the target page will be mapped to the user space address, which might
have an alias issue with the kernel address used to copy the data from
the page to.  There are 2 ways to fix this issue.

 1) insert flush_dcache_page() after folio_copy().
 2) replace folio_copy() with copy_user_huge_page() which already
    considers the cache maintenance.

We chose 2) way to fix the issue since architectures can optimize this
situation.

Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1baa198519a..eba7681d15d0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5818,7 +5818,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			*pagep = NULL;
 			goto out;
 		}
-		folio_copy(page_folio(page), page_folio(*pagep));
+		copy_user_huge_page(page, *pagep, dst_addr, dst_vma,
+				    pages_per_huge_page(h));
 		put_page(*pagep);
 		*pagep = NULL;
 	}
-- 
2.11.0

