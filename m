Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8EAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 01:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbiEZBD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 21:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiEZBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:03:54 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95B8D6AE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:03:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEPlGvz_1653527024;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VEPlGvz_1653527024)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 May 2022 09:03:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] erofs: leave compressed inodes unsupported in fscache mode for now
Date:   Thu, 26 May 2022 09:03:44 +0800
Message-Id: <20220526010344.118493-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

erofs over fscache doesn't support the compressed layout yet. It will
cause NULL crash if there are compressed inodes contained when working
in fscache mode.

So far in the erofs based container image distribution scenarios
(RAFS v6), the compressed RAFS v6 images are downloaded and then
decompressed on demand as an uncompressed erofs image. Then the erofs
image is mounted in fscache mode for containers to use. IOWs, currently
compressed data is decompressed on the userspace side instead and
uncompressed erofs images will be finally cached.

The fscache support for the compressed layout is still under
development and it will be used for runtime decompression feature.
Anyway, to avoid the potential crash, let's leave the compressed inodes
unsupported in fscache mode until we support it later.

Fixes: 1442b02b66ad ("erofs: implement fscache-based data read for non-inline layout")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index bcc8335b46b3..95a403720e8c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -288,7 +288,10 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		err = z_erofs_fill_inode(inode);
+		if (!erofs_is_fscache_mode(inode->i_sb))
+			err = z_erofs_fill_inode(inode);
+		else
+			err = -EOPNOTSUPP;
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
-- 
2.27.0

