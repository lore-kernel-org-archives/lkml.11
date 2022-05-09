Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4FC35295
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 07:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiEIHx2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 03:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiEIHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:45:01 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC239165BC;
        Mon,  9 May 2022 00:41:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VCfaIpJ_1652082055;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCfaIpJ_1652082055)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 15:40:56 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v11 17/22] erofs: implement fscache-based metadata read
Date:   Mon,  9 May 2022 15:40:23 +0800
Message-Id: <20220509074028.74954-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the data plane of reading metadata from primary data blob
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c    | 19 +++++++++++++++----
 fs/erofs/fscache.c | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 14b64d960541..bb9c1fd48c19 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -6,6 +6,7 @@
  */
 #include "internal.h"
 #include <linux/prefetch.h>
+#include <linux/sched/mm.h>
 #include <linux/dax.h>
 #include <trace/events/erofs.h>
 
@@ -35,14 +36,20 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
+	struct folio *folio;
+	unsigned int nofs_flag;
 
 	if (!page || page->index != index) {
 		erofs_put_metabuf(buf);
-		page = read_cache_page_gfp(mapping, index,
-				mapping_gfp_constraint(mapping, ~__GFP_FS));
-		if (IS_ERR(page))
-			return page;
+
+		nofs_flag = memalloc_nofs_save();
+		folio = read_cache_folio(mapping, index, NULL, NULL);
+		memalloc_nofs_restore(nofs_flag);
+		if (IS_ERR(folio))
+			return folio;
+
 		/* should already be PageUptodate, no need to lock page */
+		page = folio_file_page(folio, index);
 		buf->page = page;
 	}
 	if (buf->kmap_type == EROFS_NO_KMAP) {
@@ -63,6 +70,10 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
+	if (erofs_is_fscache_mode(sb))
+		return erofs_bread(buf, EROFS_SB(sb)->s_fscache->inode,
+				   blkaddr, type);
+
 	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ac02af8cce3e..23d7e862eed8 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -59,7 +59,32 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
 	return ret;
 }
 
+static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
+{
+	int ret;
+	struct folio *folio = page_folio(page);
+	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct erofs_map_dev mdev = {
+		.m_deviceid = 0,
+		.m_pa = folio_pos(folio),
+	};
+
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		goto out;
+
+	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
+			folio_mapping(folio), folio_pos(folio),
+			folio_size(folio), mdev.m_pa);
+	if (!ret)
+		folio_mark_uptodate(folio);
+out:
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
+	.readpage = erofs_fscache_meta_readpage,
 };
 
 int erofs_fscache_register_cookie(struct super_block *sb,
-- 
2.27.0

