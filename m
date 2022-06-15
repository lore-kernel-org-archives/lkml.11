Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA80C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 13:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352698AbiFONgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbiFONgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:36:10 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0569E3631F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cQlyO
        FmjcZobR7aTYosEqngYYxcwcNKmc5B9Yt/7tqc=; b=EJ4GIwj73lWbbNMkOT38h
        zKj2yF8qwKAnjjRTaXESc12YN+7K3IpNxXQjFsX4MuYZ8TNBCVVqoNexX0WBIvcR
        MYE6/Fe7GuguFE3WgiafKbt4I9peEHniJGDacoRG5p7gwnV69z31QIIURu+l0coq
        9SpHuBAde37EnwTrQRJvIk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowADH0wbV36liBxg5DQ--.45191S2;
        Wed, 15 Jun 2022 21:34:14 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liang He <windhl@126.com>
Subject: [PATCH] drivers: edac: Add missing of_node_put() in altera_edac.c
Date:   Wed, 15 Jun 2022 21:34:13 +0800
Message-Id: <20220615133413.3967379-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowADH0wbV36liBxg5DQ--.45191S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1kJF4UCFy3GF13Aw43Jrb_yoW8AF15pF
        48Ka90yFWIyr15WF1qv3Z5Zay5Xw1vv3y8urySy392kFsrJ3yvqryjvFZIyas8ArWrZ3y3
        Xw4jy3yfC3WUCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-_-dUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhYhF18RPTFd9QAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In altr_portb_setup(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() in
fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/edac/altera_edac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..f035d131751c 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1528,7 +1528,8 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: Unable to allocate PortB EDAC device\n",
 			    ecc_name);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto out_put;
 	}
 
 	/* Initialize the PortB EDAC device structure from PortA structure */
@@ -1536,7 +1537,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	*altdev = *device;
 
 	if (!devres_open_group(&altdev->ddev, altr_portb_setup, GFP_KERNEL))
-		return -ENOMEM;
+	{
+		rc = -ENOMEM;
+		goto out_put;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
@@ -1605,6 +1609,9 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENOMEM;
 		goto err_release_group_1;
 	}
+	
+	of_node_put(np);
+	
 	altr_create_edacdev_dbgfs(dci, prv);
 
 	list_add(&altdev->next, &altdev->edac->a10_ecc_devices);
@@ -1618,6 +1625,8 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	devres_release_group(&altdev->ddev, altr_portb_setup);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
+out_put:
+    of_node_put(np);	
 	return rc;
 }
 
-- 
2.25.1

