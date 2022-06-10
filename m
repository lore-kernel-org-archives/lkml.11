Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 17:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350068AbiFJRii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346813AbiFJRid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:38:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F52253A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:38:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y8-20020a25a088000000b0066465a3112dso1947830ybh.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5fmQszK1Ftmw30V0gwN1AZaU6pQNh3b494ZogsrG54w=;
        b=QGT7zos6PMA4nXZmokylnJRPrMcP3oyvrZKGohf5aZSXTn/UheG2FCg5yKy29JsjSN
         eZSdktXiLVEzvErtwWSo7D3GPQedGFu1CySEfelpPuvGc5+kPlMy1F11sDFL7nveEsQt
         HjdR6s3jW9l1P7m5y2fAIT8HR/vNIzTz4DnSiZ44GnKtm7drGyA2z/iJjfsvWlNCK1cM
         Yz5pUQ1uhf0s95Yor3DODnYdVMmWKM1Ad1xVRkLz9bXhY84nxexLIitGVw7Gs2HyoVjZ
         JyHN0C8XoIBPk0GlyHy+HKIEOTkjHLYujG5EH/8kZpHAw7vSTBubzvRVShRyUJAbYSiU
         b/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5fmQszK1Ftmw30V0gwN1AZaU6pQNh3b494ZogsrG54w=;
        b=hcKXYPXOzMEW13WJVg+Fm/5eIBmYlz1G78LdUlZIQtEl67S8uByEGBuv8XBnohB+CX
         /kl2rxYpvk6O0kK+YgNu1Vgupn8y1dRt5UKr5k7zcZgr1KFS+lv2wTUUcKdEf2WLzFGR
         0zGuNf4/yHL4g7sChsoxIJ4wowmApqL/JWYCV/MrPs/vwS1osuIS4w12ZwbZSJcBgLiT
         Jq8ZUP2IRNu8Eib0doFFqRHjY4h4c77kvWaGKr57XLsly/cDP+7a5mgU2O34cNo8QRjU
         nk0ryXV47Tk+e4fbBmGwq1Ei41P/0krLNR1bmBwL60CGT9YOH5zs4FJBPZnkqiZbvtRG
         +7RQ==
X-Gm-Message-State: AOAM5337MlRBXMl34+IvLmpryuv9MrJWqBBKROCTst9lpFGtA9XtrJoD
        AxQoVFXP4xrNuNEYMGaFKKOP0wRnJSSsh2oCHZRl
X-Google-Smtp-Source: ABdhPJzSqTsvnb1ZC/aD7CdAHop/d77Nuh2d8nZpHySjd4kmLswDFlqFdL1Bx2WtIJ/Tzlole4EE2ZwSXQwJGB8+JpE5
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:9a0c:4d31:bfe1:5abd])
 (user=axelrasmussen job=sendgmr) by 2002:a25:58f:0:b0:664:628a:374b with SMTP
 id 137-20020a25058f000000b00664628a374bmr4604612ybf.329.1654882711003; Fri,
 10 Jun 2022 10:38:31 -0700 (PDT)
Date:   Fri, 10 Jun 2022 10:38:12 -0700
Message-Id: <20220610173812.1768919-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2] mm: userfaultfd: fix UFFDIO_CONTINUE on fallocated shmem pages
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fallocate() is used on a shmem file, the pages we allocate can end
up with !PageUptodate.

Since UFFDIO_CONTINUE tries to find the existing page the user wants to
map with SGP_READ, we would fail to find such a page, since
shmem_getpage_gfp returns with a "NULL" pagep for SGP_READ if it
discovers !PageUptodate. As a result, UFFDIO_CONTINUE returns -EFAULT,
as it would do if the page wasn't found in the page cache at all.

This isn't the intended behavior. UFFDIO_CONTINUE is just trying to find
if a page exists, and doesn't care whether it still needs to be cleared
or not. So, instead of SGP_READ, pass in SGP_NOALLOC. This is the same,
except for one critical difference: in the !PageUptodate case,
SGP_NOALLOC will clear the page and then return it. With this change,
UFFDIO_CONTINUE works properly (succeeds) on a shmem file which has been
fallocated, but otherwise not modified.

Fixes: 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE for shmem")
Cc: stable@vger.kernel.org
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/userfaultfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4f4892a5f767..07d3befc80e4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -246,7 +246,10 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
 	struct page *page;
 	int ret;
 
-	ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
+	ret = shmem_getpage(inode, pgoff, &page, SGP_NOALLOC);
+	/* Our caller expects us to return -EFAULT if we failed to find page. */
+	if (ret == -ENOENT)
+		ret = -EFAULT;
 	if (ret)
 		goto out;
 	if (!page) {
-- 
2.36.1.476.g0c4daa206d-goog

