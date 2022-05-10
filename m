Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEBCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 12:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiEJMVk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiEJMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:21:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883AAF68BC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:17:37 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyH6J0BxJzGpfZ;
        Tue, 10 May 2022 20:14:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 20:17:35 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 20:17:34 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>, <gregkh@linuxfoundation.org>,
        <arne.edholm@axis.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3 0/3] Fix high cpu usage of ubi_bgt thread and an uaf problem
Date:   Tue, 10 May 2022 20:31:23 +0800
Message-ID: <20220510123126.1820335-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
  Update fm pool filling strategy, consider reserve enough free count
  for fastmap non anchor pebs while filling fm_wl_pool.
  Remove 'fm_next_anchor' and check 'fm_anchor' during wear leveling.
  Check wl_pool for free peb before wear leveling.
v2->v3:
  1. Don't reserve beb_revd_pebs while filling fm pool.
  2. Fix an uaf in ubi_create_volume()'s error handling path.

Zhihao Cheng (3):
  ubi: fastmap: Fix high cpu usage of ubi_bgt by making sure wl_pool not
    empty
  ubi: fastmap: Check wl_pool for free peb before wear leveling
  ubi: ubi_create_volume: Fix use-after-free when volume creation failed

 drivers/mtd/ubi/fastmap-wl.c | 121 ++++++++++++++++++++++++++++-------
 drivers/mtd/ubi/fastmap.c    |  11 ----
 drivers/mtd/ubi/ubi.h        |   4 +-
 drivers/mtd/ubi/vmt.c        |   1 -
 drivers/mtd/ubi/wl.c         |  33 ++++++----
 drivers/mtd/ubi/wl.h         |   2 +
 6 files changed, 123 insertions(+), 49 deletions(-)

-- 
2.31.1

