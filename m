Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiCJRgD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiCJRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:00 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207C318F216
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:34:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V6pLX5X_1646933689;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V6pLX5X_1646933689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 01:34:54 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] erofs: silence warnings related to impossible m_plen
Date:   Fri, 11 Mar 2022 01:34:48 +0800
Message-Id: <20220310173448.19962-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan reported two smatch warnings [1],
.. warn: should '1 << lclusterbits' be a 64 bit type?
.. warn: should 'm->compressedlcs << lclusterbits' be a 64 bit type?

In practice, m_plen cannot be more than 1MiB due to on-disk constraint
for the compression mode, so we're always safe here.

In order to make static analyzers happy and don't report again,
let's silence them instead.

[1] https://lore.kernel.org/r/202203091002.lJVzsX6e-lkp@intel.com

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 361b1d6e4bf9..b4059b9c3bac 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -494,7 +494,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) ||
 	    ((m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) &&
 	     !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2))) {
-		map->m_plen = 1 << lclusterbits;
+		map->m_plen = 1ULL << lclusterbits;
 		return 0;
 	}
 	lcn = m->lcn + 1;
@@ -540,7 +540,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
 		return -EFSCORRUPTED;
 	}
 out:
-	map->m_plen = m->compressedlcs << lclusterbits;
+	map->m_plen = (u64)m->compressedlcs << lclusterbits;
 	return 0;
 err_bonus_cblkcnt:
 	erofs_err(m->inode->i_sb,
-- 
2.24.4

