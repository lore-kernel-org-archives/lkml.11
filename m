Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4552C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 03:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiCQDXs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 23:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiCQDXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:23:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4C529C99
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:22:28 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJsqH11ZtzfYkb;
        Thu, 17 Mar 2022 11:20:59 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 11:22:27 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 11:22:27 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <liwei391@huawei.com>,
        <liaoyu15@huawei.com>
Subject: [PATCH -next] bus: mhi: ep: remove useless judgement in mhi_ep_ring_add_element
Date:   Thu, 17 Mar 2022 11:31:17 +0800
Message-ID: <20220317033117.367027-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the check of 'ret' that is impossible to be non-zero.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/bus/mhi/ep/ring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index ac2043e71943..161505cd628f 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -131,8 +131,6 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
 
 	mhi_cntrl->write_to_host(mhi_cntrl, (void __iomem *)el, ring->rbase + (old_offset *
 				 sizeof(*el)), sizeof(*el));
-	if (ret < 0)
-		return ret;
 
 	return 0;
 }
-- 
2.25.1

