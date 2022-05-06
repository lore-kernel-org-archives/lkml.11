Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B1DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 07:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349671AbiEFHHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 03:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388071AbiEFHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:06:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03D66CBF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:03:10 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvhMx0mNHzhYmj;
        Fri,  6 May 2022 15:02:37 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 15:03:08 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 15:03:07 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>, <arne.edholm@axis.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: [PATCH v2 0/2] Fix high cpu usage of ubi_bgt thread
Date:   Fri, 6 May 2022 15:17:02 +0800
Message-ID: <20220506071704.222501-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Zhihao Cheng (2):
  ubi: fastmap: Fix high cpu usage of ubi_bgt by making sure wl_pool not
    empty
  ubi: fastmap: Check wl_pool for free peb before wear leveling

 drivers/mtd/ubi/fastmap-wl.c | 115 ++++++++++++++++++++++++++++-------
 drivers/mtd/ubi/fastmap.c    |  11 ----
 drivers/mtd/ubi/ubi.h        |   4 +-
 drivers/mtd/ubi/wl.c         |  33 ++++++----
 drivers/mtd/ubi/wl.h         |   2 +
 5 files changed, 117 insertions(+), 48 deletions(-)

-- 
2.31.1

