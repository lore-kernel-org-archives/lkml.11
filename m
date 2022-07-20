Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF801C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 01:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiGTB4I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiGTB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:56:07 -0400
Received: from mta02.start.ca (mta02.start.ca [162.250.196.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1E54D159
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:56:05 -0700 (PDT)
Received: from mta02.start.ca (localhost [127.0.0.1])
        by mta02.start.ca (Postfix) with ESMTP id 33CFD41A7B;
        Tue, 19 Jul 2022 21:56:04 -0400 (EDT)
Received: from localhost (dhcp-24-53-241-20.cable.user.start.ca [24.53.241.20])
        by mta02.start.ca (Postfix) with ESMTPS id CC78F41A77;
        Tue, 19 Jul 2022 21:56:03 -0400 (EDT)
From:   Nick Bowler <nbowler@draconx.ca>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme: Define compat_ioctl again to unbreak 32-bit userspace.
Date:   Tue, 19 Jul 2022 21:55:38 -0400
Message-Id: <20220720015538.15838-1-nbowler@draconx.ca>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 89b3d6e60550 ("nvme: simplify the compat ioctl handling") removed
the initialization of compat_ioctl from the nvme block_device_operations
structures.

Presumably the expectation was that 32-bit ioctls would be directed
through the regular handler but this is not the case: failing to assign
.compat_ioctl actually means that the compat case is disabled entirely,
and any attempt to submit nvme ioctls from 32-bit userspace fails
outright with -ENOTTY.

For example:

  % smartctl -x /dev/nvme0n1
  [...]
  Read NVMe Identify Controller failed: NVME_IOCTL_ADMIN_CMD: Inappropriate ioctl for device

Direct .compat_ioctl to the main ioctl handlers in order to make things
work again.

Fixes: 89b3d6e60550 ("nvme: simplify the compat ioctl handling")
Signed-off-by: Nick Bowler <nbowler@draconx.ca>
---
 drivers/nvme/host/core.c      | 1 +
 drivers/nvme/host/multipath.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2862a56fadc..30e105dbc178 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2093,6 +2093,7 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
 static const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
+	.compat_ioctl	= nvme_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d464fdf978fb..0f38a5feec22 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -408,6 +408,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
 	.ioctl		= nvme_ns_head_ioctl,
+	.compat_ioctl	= nvme_ns_head_ioctl,
 	.getgeo		= nvme_getgeo,
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
-- 
2.35.1

