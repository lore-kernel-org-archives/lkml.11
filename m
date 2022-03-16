Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822FAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 14:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356744AbiCPOVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356807AbiCPOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B54A90C;
        Wed, 16 Mar 2022 07:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D2B561277;
        Wed, 16 Mar 2022 14:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F51C340E9;
        Wed, 16 Mar 2022 14:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647440336;
        bh=1LUqk+FiiU6GNjmhIbzfH3wX9ifuYHOOOkjkXPeXklk=;
        h=From:To:Cc:Subject:Date:From;
        b=Qy6B41GzREZNRxCHsdS7lb6rsgpHIeQf+i4YdgSGsrMlTXxh47k2S/VCrdKQD8/3k
         Zk0J9qB/5KvcEU/Whs0RIJC1ciRzIqpgYItTkz7Ag1zSHYUc7H4RqEs8rBp/byvXlX
         siv+cflFCoJ8kobJDQGcuOrcshZ33lKZ/oVQJHbROHSyLlL1CbQ04vDcBwfy0l+ie3
         jhiIKRjZAH5+LfXys1vkkkwgiV+zgyqJDZd6aq9mFNZwHfkUwtsOTy7NcxGQMm4BnH
         gQduSG3hcZtCwHjrlavOJdwd0ScgIEBbmiaqUK0YvLzPORwMTIxwuo/qYIlKUiL/a6
         Esp9czO2TrxMw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, amit@kernel.org,
        gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 1/3] virtio_console: break out of buf poll on remove
Date:   Wed, 16 Mar 2022 10:18:48 -0400
Message-Id: <20220316141850.248784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit 0e7174b9d5877130fec41fb4a16e0c2ee4958d44 ]

A common pattern for device reset is currently:
vdev->config->reset(vdev);
.. cleanup ..

reset prevents new interrupts from arriving and waits for interrupt
handlers to finish.

However if - as is common - the handler queues a work request which is
flushed during the cleanup stage, we have code adding buffers / trying
to get buffers while device is reset. Not good.

This was reproduced by running
	modprobe virtio_console
	modprobe -r virtio_console
in a loop.

Fix this up by calling virtio_break_device + flush before reset.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0fb3a8e62e62..2140d401523f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2001,6 +2001,13 @@ static void virtcons_remove(struct virtio_device *vdev)
 	list_del(&portdev->list);
 	spin_unlock_irq(&pdrvdata_lock);
 
+	/* Device is going away, exit any polling for buffers */
+	virtio_break_device(vdev);
+	if (use_multiport(portdev))
+		flush_work(&portdev->control_work);
+	else
+		flush_work(&portdev->config_work);
+
 	/* Disable interrupts for vqs */
 	vdev->config->reset(vdev);
 	/* Finish up work that's lined up */
-- 
2.34.1

