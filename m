Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44414C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 07:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiBPH0S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:26:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiBPH0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:26:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E565C2FFE4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:26:01 -0800 (PST)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jz7Wg3bzBzcbYP;
        Wed, 16 Feb 2022 14:35:59 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 14:37:05 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 14:37:04 +0800
To:     <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC:     <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        lixiaokeng <lixiaokeng@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] md: remove unused dm_thin_remove_block()
Message-ID: <b0ec028e-bc9e-f705-9674-ffc4a01ee2f0@huawei.com>
Date:   Wed, 16 Feb 2022 14:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


dm_thin_remove_block() is no longer unused, just remove it.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 drivers/md/dm-thin-metadata.c | 12 ------------
 drivers/md/dm-thin-metadata.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 1a96a07cbf44..986a2dc9a686 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1740,18 +1740,6 @@ static int __remove_range(struct dm_thin_device *td, dm_block_t begin, dm_block_
 	return dm_btree_insert(&pmd->tl_info, pmd->root, keys, &value, &pmd->root);
 }

-int dm_thin_remove_block(struct dm_thin_device *td, dm_block_t block)
-{
-	int r = -EINVAL;
-
-	pmd_write_lock(td->pmd);
-	if (!td->pmd->fail_io)
-		r = __remove(td, block);
-	pmd_write_unlock(td->pmd);
-
-	return r;
-}
-
 int dm_thin_remove_range(struct dm_thin_device *td,
 			 dm_block_t begin, dm_block_t end)
 {
diff --git a/drivers/md/dm-thin-metadata.h b/drivers/md/dm-thin-metadata.h
index 7ef56bd2a7e3..4d7a2caf21d9 100644
--- a/drivers/md/dm-thin-metadata.h
+++ b/drivers/md/dm-thin-metadata.h
@@ -166,7 +166,6 @@ int dm_pool_alloc_data_block(struct dm_pool_metadata *pmd, dm_block_t *result);
 int dm_thin_insert_block(struct dm_thin_device *td, dm_block_t block,
 			 dm_block_t data_block);

-int dm_thin_remove_block(struct dm_thin_device *td, dm_block_t block);
 int dm_thin_remove_range(struct dm_thin_device *td,
 			 dm_block_t begin, dm_block_t end);

-- 
2.32.0


