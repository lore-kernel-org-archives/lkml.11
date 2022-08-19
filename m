Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2D8C32772
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348185AbiHSJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348100AbiHSJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:38:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321AF4F689
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:38:49 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8Gmn5b1JzXdpD;
        Fri, 19 Aug 2022 17:34:33 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 17:38:47 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 17:38:46 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <rafael@kernel.org>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next] driver core: switch to use dev_err_probe()
Date:   Fri, 19 Aug 2022 17:46:56 +0800
Message-ID: <20220819094656.1945653-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() to simplify code and print error code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 753e7cca0f40..e51a09f9d0ec 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2507,11 +2507,9 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 
 	rc = kobject_synth_uevent(&dev->kobj, buf, count);
-
-	if (rc) {
-		dev_err(dev, "uevent: failed to send synthetic uevent\n");
-		return rc;
-	}
+	if (rc)
+		return dev_err_probe(dev, rc,
+				     "uevent: failed to send synthetic uevent\n");
 
 	return count;
 }
-- 
2.25.1

