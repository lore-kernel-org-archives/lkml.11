Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501C6C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 23:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiBWXy5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiBWXy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:54:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D004C593BA;
        Wed, 23 Feb 2022 15:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665E96090C;
        Wed, 23 Feb 2022 23:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612DBC340E7;
        Wed, 23 Feb 2022 23:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645660466;
        bh=pcF6zZuUcgNI9ao0WzasCIspBF4B6jWzESMdaq5J6Jw=;
        h=From:To:Cc:Subject:Date:From;
        b=QnKTMnq0xShV25NBHK70s6uW3dJ9udLnHGK2MoaZTN71bgBFt1+JcYpVdkUkmrtF6
         l+dhEprZIAzEyjXAFF8K1V7UPyt4Z5FGOaPYgIaCFDh84qnhaw7hFTYXNqRBYT0lGz
         kwgmOrBgsSyH+FMMvuUbIloT5vOVrEVKPD9O8JFav01JB/bDYw81TCili10UwMLRlp
         dmw3lhacwYLc1uDyipxFn4qS6pojBbBCMiimow24mL/7EIkPgqElkPxob1PwQE1Iwv
         OP/33SsAkdaWBBF4F1Hc4LO8ur1wQ2bxuk0d3u2bwXjtzRQy1rDzswEmZzDQhc2fRs
         IscJHZ5R2DNTQ==
From:   broonie@kernel.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the maple tree
Date:   Wed, 23 Feb 2022 23:54:22 +0000
Message-Id: <20220223235422.672736-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  mm/oom_kill.c

between commit:

  91a14015304fe ("mm/oom_kill: Use maple tree iterators instead of vma linked list")

from the maple tree and commit:

  a213e5cf71cbc ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")

from the folio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc mm/oom_kill.c
index 0e7effe225e59,6b875acabd1e7..0000000000000
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@@ -555,8 -525,8 +555,8 @@@ bool __oom_reap_task_mm(struct mm_struc
  	 */
  	set_bit(MMF_UNSTABLE, &mm->flags);
  
 -	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
 +	for_each_vma(vmi, vma) {
- 		if (!can_madv_lru_vma(vma))
+ 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
  			continue;
  
  		/*
