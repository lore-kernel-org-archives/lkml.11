Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 19:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391757AbiEFTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388545AbiEFTuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:50:20 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0E6A06F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:46:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VCTGrlU_1651866391;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VCTGrlU_1651866391)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 03:46:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs: remove obsoluted comments
Date:   Sat,  7 May 2022 03:46:11 +0800
Message-Id: <20220506194612.117120-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
References: <20220506194612.117120-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments haven't been useful anymore since the code updated.
Let's drop them instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c    |  5 -----
 fs/erofs/internal.h | 25 -------------------------
 2 files changed, 30 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 8d3f56c6469b..8b18d57ec18f 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,11 +8,6 @@
 
 #include <trace/events/erofs.h>
 
-/*
- * if inode is successfully read, return its inode page (or sometimes
- * the inode payload page if it's an extended inode) in order to fill
- * inline data if possible.
- */
 static void *erofs_read_inode(struct erofs_buf *buf,
 			      struct inode *inode, unsigned int *ofs)
 {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ce2a04836cd2..cfee49d33b95 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -397,31 +397,6 @@ extern const struct super_operations erofs_sops;
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
 
-/*
- * Logical to physical block mapping
- *
- * Different with other file systems, it is used for 2 access modes:
- *
- * 1) RAW access mode:
- *
- * Users pass a valid (m_lblk, m_lofs -- usually 0) pair,
- * and get the valid m_pblk, m_pofs and the longest m_len(in bytes).
- *
- * Note that m_lblk in the RAW access mode refers to the number of
- * the compressed ondisk block rather than the uncompressed
- * in-memory block for the compressed file.
- *
- * m_pofs equals to m_lofs except for the inline data page.
- *
- * 2) Normal access mode:
- *
- * If the inode is not compressed, it has no difference with
- * the RAW access mode. However, if the inode is compressed,
- * users should pass a valid (m_lblk, m_lofs) pair, and get
- * the needed m_pblk, m_pofs, m_len to get the compressed data
- * and the updated m_lblk, m_lofs which indicates the start
- * of the corresponding uncompressed data in the file.
- */
 enum {
 	BH_Encoded = BH_PrivateStart,
 	BH_FullMapped,
-- 
2.24.4

