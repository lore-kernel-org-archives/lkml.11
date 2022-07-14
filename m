Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AB3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 13:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiGNNVV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbiGNNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:05 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447725D5B1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPEO_1657804860;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPEO_1657804860)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:01 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 02/16] erofs: clean up z_erofs_collector_begin()
Date:   Thu, 14 Jul 2022 21:20:37 +0800
Message-Id: <20220714132051.46012-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange the code and get rid of all gotos.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 1b6816dd235f..c7be447ac64d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -521,7 +521,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 {
 	struct erofs_map_blocks *map = &fe->map;
-	struct erofs_workgroup *grp;
+	struct erofs_workgroup *grp = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -530,33 +530,31 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
 	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-	if (map->m_flags & EROFS_MAP_META) {
-		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		goto tailpacking;
+	if (!(map->m_flags & EROFS_MAP_META)) {
+		grp = erofs_find_workgroup(fe->inode->i_sb,
+					   map->m_pa >> PAGE_SHIFT);
+	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
 
-	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
 	if (grp) {
 		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
+		ret = -EEXIST;
 	} else {
-tailpacking:
 		ret = z_erofs_register_pcluster(fe);
-		if (!ret)
-			goto out;
-		if (ret != -EEXIST)
-			return ret;
 	}
 
-	ret = z_erofs_lookup_pcluster(fe);
-	if (ret) {
-		erofs_workgroup_put(&fe->pcl->obj);
+	if (ret == -EEXIST) {
+		ret = z_erofs_lookup_pcluster(fe);
+		if (ret) {
+			erofs_workgroup_put(&fe->pcl->obj);
+			return ret;
+		}
+	} else if (ret) {
 		return ret;
 	}
 
-out:
 	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  fe->pcl->pagevec, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
-- 
2.24.4

