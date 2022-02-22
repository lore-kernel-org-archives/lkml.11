Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 11:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiBVLNo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBVLNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:13:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E89B45A0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:13:17 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K2xLr5zVwz9sxm;
        Tue, 22 Feb 2022 19:11:32 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 19:13:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>
CC:     <sstabellini@kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] xen: use helper macro __ATTR_RW
Date:   Tue, 22 Feb 2022 19:12:22 +0800
Message-ID: <20220222111222.56877-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro __ATTR_RW to define hyp_sysfs_attr to make code more
clear. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/xen/sys-hypervisor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index feb1d16252e7..5e842c88a13e 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -25,8 +25,7 @@
 static struct hyp_sysfs_attr  _name##_attr = __ATTR_RO(_name)
 
 #define HYPERVISOR_ATTR_RW(_name) \
-static struct hyp_sysfs_attr _name##_attr = \
-	__ATTR(_name, 0644, _name##_show, _name##_store)
+static struct hyp_sysfs_attr _name##_attr = __ATTR_RW(_name)
 
 struct hyp_sysfs_attr {
 	struct attribute attr;
-- 
2.23.0

