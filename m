Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5AAC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 10:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiGIKIV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 06:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGIKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B224B0DE;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4793360E97;
        Sat,  9 Jul 2022 10:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4CDC341E7;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=DEiF6YejPpIbSp+o/b8ddPeWDksJbpHvwhJmNJ9U7O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je+WBSIkbp0mDAotk4sWMxXQDjaH28ebGUvHmljF8af5gM6GikOrQbO52qqUVeanD
         S7et8tlE0sIELwlQ8nT1sNXJmc2tRkMjl8DnzyRuUR2XoG9pZ7NHVWFzHmqRwnU2Ja
         3YSv5tzbJzNReMUYSOLSwb/iG1Q4vX7T41TNqbANvTnlpsT+kQBTyLakfT9r1yw8O6
         0k7VOyAuvJDcb6Hg6NcYY0rayfeMhxcsKWBvQdVoa8AhjlQOWHv1SZi7gCNXGVZSZK
         3lqciaQxIcaoCEKnnudE850irlNkm1yOzZ0gNvCBTs3b87NS4FOanMkKjdEVKECZtR
         WXNTOGUBkC/9Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EGZ-EV;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 03/21] docs: update vmemmap_dedup.rst reference
Date:   Sat,  9 Jul 2022 11:07:16 +0100
Message-Id: <a3a132957ac8cc6b423303f4f4491753714b89b2.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
renamed: Documentation/vm/vmemmap_dedup.rst
to: Documentation/mm/vmemmap_dedup.rst.

Update its cross-reference accordingly.

Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 mm/hugetlb_vmemmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..b8fc23c8763f 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -16,7 +16,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
- * Documentation/vm/vmemmap_dedup.rst.
+ * Documentation/mm/vmemmap_dedup.rst.
  */
 #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
 
-- 
2.36.1

