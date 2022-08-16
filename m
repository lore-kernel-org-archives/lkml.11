Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A3DC25B0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 13:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiHPN7U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiHPN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:59:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E774C610
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:59:14 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M6Xlm0JDgzGpW8;
        Tue, 16 Aug 2022 21:57:40 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 21:59:11 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next] mtd: ftl: use container_of() rather than cast
Date:   Tue, 16 Aug 2022 21:59:10 +0800
Message-ID: <20220816135910.268016-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The container_of() is much more readable and also safer.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/mtd/ftl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index bec56070039d..7e56c77535e8 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -941,7 +941,7 @@ static int ftl_write(partition_t *part, caddr_t buffer,
 
 static int ftl_getgeo(struct mtd_blktrans_dev *dev, struct hd_geometry *geo)
 {
-	partition_t *part = (void *)dev;
+	partition_t *part = container_of(dev, struct partition_t, mbd);
 	u_long sect;
 
 	/* Sort of arbitrary: round size down to 4KiB boundary */
@@ -969,7 +969,7 @@ static int ftl_writesect(struct mtd_blktrans_dev *dev,
 static int ftl_discardsect(struct mtd_blktrans_dev *dev,
 			   unsigned long sector, unsigned nr_sects)
 {
-	partition_t *part = (void *)dev;
+	partition_t *part = container_of(dev, struct partition_t, mbd);
 	uint32_t bsize = 1 << part->header.EraseUnitSize;
 
 	pr_debug("FTL erase sector %ld for %d sectors\n",
-- 
2.25.1

