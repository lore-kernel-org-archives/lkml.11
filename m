Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01550C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 08:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbiCBIjJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiCBIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:39:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491635839C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:38:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cx5so1174600pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqE92Z30jLRB5qj639p7ReXjqJAONBgi3Xr8rqugwWc=;
        b=G5CCJorcD+mvdq6Rx3y5zrdO9Uswo4f2HKicBJt0MzQd5dDmOGdcpF5Q0T5Sb+0dMe
         5Gh1k3gXFNEWbH8soeJvSqYskqaD8UIrfXhIbIZBJUvCoyOAUIlV90YNP9qy8+iB/ocD
         Xb6khWfXY6hJSuTWWhVIJQ5JO67wyCMgGKs/udM/CHgixLogCFxvXwpqr0oet2xKig0W
         0HSsd5g99k3fdPHKiaprYso/2/8m4zlPpcL+YcAUzQ2mbDElyCAN1eccs9UdJZqorU/p
         mNdMO7mjcCYhtJPqtnIo8RbIlPjV8CS2QQbKSEsPE6xsiveggCAQsm8VeiNcWAjZ85av
         U3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqE92Z30jLRB5qj639p7ReXjqJAONBgi3Xr8rqugwWc=;
        b=F5SdIokuNtK+xakr2ovPJQ00DymcgfygciRMMszw9XBLuLqgtECY2QiAuo+Vx5v+Ac
         ibmv1cH+02LUCtCYSu3vhsK++V4dvPFRh/CNmnQTiH17gDI14dFEbKwq/2ZnHcw9fBDe
         CsX+sV4S5Xezs6KMKneyGeV8U3BF5nnoysixDvARIeLXcIf2+4G+eo139hKvIBXulV7/
         eYH+DqJOncpfeeZVXkGFMIooHsAQXSD0ST/tGGTwcFZypfnDn2/2BvHGJXeetIBRwPL/
         94rc30pYpX+EAFqE0TID2mkbUTrGA2gdB+RPNjczVeS4ckW9qVcwq/vLXXtu4v9IpoQs
         fmTw==
X-Gm-Message-State: AOAM533NIgxrbwUDeWGbDBoUa4H9/8TD1iySdLUJyZWW2brcXDAoAvsV
        vP7Ww1nbTofCmGLkOnUbrw6umA==
X-Google-Smtp-Source: ABdhPJxo987uh2sy4iVBcpuO3RBDBmmhqeJ+aQAyhMLaM+8AbMNcaI4YlJ2ED9/26vh1UTb91s0bdw==
X-Received: by 2002:a17:90b:4b90:b0:1be:fd89:5402 with SMTP id lr16-20020a17090b4b9000b001befd895402mr769942pjb.117.1646210299670;
        Wed, 02 Mar 2022 00:38:19 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm18705141pfl.24.2022.03.02.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:38:19 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 1/3] mm: hugetlb: disable freeing vmemmap pages when struct page crosses page boundaries
Date:   Wed,  2 Mar 2022 16:37:56 +0800
Message-Id: <20220302083758.32528-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302083758.32528-1-songmuchun@bytedance.com>
References: <20220302083758.32528-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is enabled and the size
of "struct page" is not power of two, we cannot optimize vmemmap pages
of HugeTLB pages. We should disable this feature in this case.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b3118dba0518..836d1117f08b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -121,6 +121,17 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	if (!hugetlb_free_vmemmap_enabled())
 		return;
 
+	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON) &&
+	    !is_power_of_2(sizeof(struct page))) {
+		/*
+		 * The hugetlb_free_vmemmap_enabled_key can be enabled when
+		 * CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON. It should
+		 * be disabled if "struct page" crosses page boundaries.
+		 */
+		static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
+		return;
+	}
+
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page is not to be freed to buddy allocator, the other tail
-- 
2.11.0

