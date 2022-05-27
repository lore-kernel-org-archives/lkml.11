Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E1DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 14:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353405AbiE0O5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 10:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiE0O5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:57:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6D26558
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D34B9B80AAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB63C385A9;
        Fri, 27 May 2022 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653663455;
        bh=tpEtjd4nbyNCejM6AtwsnItS+PD48F89/FUa062YJUI=;
        h=From:To:Cc:Subject:Date:From;
        b=iPBtkL6xdM/Z60+U7iPOu+FD9LGBe209M7wbOabX3NhUNr6aqDdif0CFhQGh3xHi0
         sytLxpuV82gBilWI9NucufMGvcNR4Rm260e2Po/Lzb7JWmwJcSUvyBXQUjx9BWijLF
         LGwHIGxgHj5SbwCA9d7FYtc67qK1YUQKhXpTAKCudqL4RZzIeiyjTrEcd+ktP7Wt/T
         5NorrMBpQruxf0NNTVlzJYbKFzrn58FjFtRS9u++b4HMJvy5uUP4VD6O+xYhCh95dR
         0uETkItq9qqAwE9+i4H3bIlnfMM89dEclAqPZSrt8/sa8jfLt7OKw3YdIBwceFWjbZ
         Ik68wOvD9ZtrA==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: fix to tag gcing flag on page during file defragment
Date:   Fri, 27 May 2022 12:13:30 +0800
Message-Id: <20220527041330.19951-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to garantee migrated data be persisted during checkpoint,
otherwise out-of-order persistency between data and node may cause
data corruption after SPOR.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a05d842a7e72..e2310c91183c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2602,6 +2602,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			}
 
 			set_page_dirty(page);
+			set_page_private_gcing(page);
 			f2fs_put_page(page, 1);
 
 			idx++;
-- 
2.36.1

