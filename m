Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F7C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 03:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiGGDSe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiGGDSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:18:32 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC26F37
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:18:26 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id BAZ00020;
        Thu, 07 Jul 2022 11:18:20 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.9; Thu, 7 Jul 2022 11:18:21 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] virtio: Check dev_set_name() return value
Date:   Wed, 6 Jul 2022 23:17:51 -0400
Message-ID: <20220707031751.4802-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20227071118208ceba2ca8c27dba11c9cd9e0884f25ed
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that dev_set_name() returns -ENOMEM, catch and handle this.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 7deeed30d1f3..ddd4466da83b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -428,7 +428,9 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out;
 
 	dev->index = err;
-	dev_set_name(&dev->dev, "virtio%u", dev->index);
+	err = dev_set_name(&dev->dev, "virtio%u", dev->index);
+	if (err)
+		goto out_ida_remove;
 
 	err = virtio_device_of_init(dev);
 	if (err)
-- 
2.27.0

