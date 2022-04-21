Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265BAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 01:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383693AbiDUBuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 21:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383690AbiDUBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:50:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A19E2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lCKFA+BDHuzLwKvYRaUjUjFnWJLUPF5Zhejj39N5OVY=; b=LOjZtvsMbVRyxck4upAdMThxEM
        PNM2Mrd6ZAZcsOaI/cMjMeJGWzEjOnLJ29m7OUg7JApDDyUqu9nWTEDSzKl7xP9TK5X15VRUN1Ohf
        3AoWWxQj/JwU0dYkvnekzkZk2chvGCJG0+En5flDsTUFRyoqw3Vp4MbsOEpwVB/zyoIxguSRNYqpd
        1JQ8e9AlwltZ4JSgTO44Ch5PJevqxz+yJOun9Llg4qSti1LawAyagvYuYo9AQQX+db/Gqx5sl/ksG
        5l3OHnZD+FlJU2QQZI0RBMjGri1/l9wWnwVWN4W7wSUPaQMdA6FQfn2kJtuY4mCwt+Gm6DubfO3op
        Wime5y6A==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhLum-00B3rr-5C; Thu, 21 Apr 2022 01:47:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Signed-off-by : Peter Xu" <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -mmotm] hugetlb: use mm.h instead of mm_types.h
Date:   Wed, 20 Apr 2022 18:47:23 -0700
Message-Id: <20220421014723.5802-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_types.h does not have zap_flags_t in it so use mm.h instead
in hugetlb.h.

Fixes this build error:

In file included from ../drivers/virt/nitro_enclaves/ne_misc_dev.c:16:0:
../include/linux/hugetlb.h:414:4: error: unknown type name ‘zap_flags_t’; did you mean ‘vm_flags_t’?
    zap_flags_t zap_flags)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Signed-off-by: Peter Xu <peterx@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Fixes: mm-hugetlb-only-drop-uffd-wp-special-pte-if-required-fix.patch

 include/linux/hugetlb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_HUGETLB_H
 #define _LINUX_HUGETLB_H
 
-#include <linux/mm_types.h>
+#include <linux/mm.h>
 #include <linux/mmdebug.h>
 #include <linux/fs.h>
 #include <linux/hugetlb_inline.h>
