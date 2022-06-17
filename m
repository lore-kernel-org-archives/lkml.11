Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BE4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 07:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380370AbiFQHG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380086AbiFQHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:06:55 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35766006C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:06:51 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id LDX00144;
        Fri, 17 Jun 2022 15:06:44 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2308.27; Fri, 17 Jun 2022 15:06:45 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] virtio: Remove unnecessary variable assignments
Date:   Fri, 17 Jun 2022 01:59:52 -0400
Message-ID: <20220617055952.5364-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022617150644eebf72efbf489856870321ce69408a8d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function vp_modern_probe(), "mdev->pci_dev" is assigned to
variable "pci_dev", variable "pci_dev" and "mdev->pci_dev" have
the same value. There is no need to assign variable "pci_dev" to
"mdev->pci_dev". So remove it.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index b790f30b2b56..fa2a9445bb18 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -220,8 +220,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 
 	check_offsets();
 
-	mdev->pci_dev = pci_dev;
-
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
 		return -ENODEV;
-- 
2.27.0

