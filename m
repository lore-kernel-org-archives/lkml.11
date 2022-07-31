Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ECCC00140
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Jul 2022 10:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbiGaKvO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Jul 2022 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiGaKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:50:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDEE11820
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A33160B3D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 10:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED2C433D6;
        Sun, 31 Jul 2022 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659264651;
        bh=o2jV6fAFKmqXjRPOlg7RT13FJ43CCdZ5+VCYMCJss2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LiTq3YHKdeFnnsK+j2b0rx2q66eea//OsQ4R5GtDE4lkOQq9YXC7vy0JGwxFQ9J7N
         /7+TK40cot8oiXW1wpS0vG0lXx3B+N/RcmUVwPsdDyLY+lIYsb8XHeh2ny3EzGsvJF
         JkPHn/zcqh8rnj3XhCgC1L7GxJ9Nijct4e09p2JQzZHvmChJZfQhl3p9KQ6FcgMda8
         7SaoUIdVEKMDyOyefKLdDdSnoe8L3tWgDccvfFle7ic/r9SbYqXXBtBqAOM9Hw6nVX
         dBA3A4e8yqjPxrrRg+1GseVVg0C2e69epqG2Kv1LC/h+CDMnaF2aPRhpcGuvHPfUUc
         Iig8Cj7PAi6NA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 8/8] habanalabs: move common function out of debugfs.c
Date:   Sun, 31 Jul 2022 13:50:37 +0300
Message-Id: <20220731105037.545106-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220731105037.545106-1-ogabbay@kernel.org>
References: <20220731105037.545106-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common function that is called from multiple places can't be
located in degugfs.c because that file is only compiled if
debugfs is enabled in the kernel config file.

This can lead to undefined symbol compilation error.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c | 25 ------------------------
 drivers/misc/habanalabs/common/device.c  | 24 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index c297248748d3..69fd3ed7680a 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -586,31 +586,6 @@ static ssize_t mmu_ack_error_value_write(struct file *file,
 	return -EINVAL;
 }
 
-void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...)
-{
-	va_list args;
-	int str_size;
-
-	va_start(args, fmt);
-	/* Calculate formatted string length. Assuming each string is null terminated, hence
-	 * increment result by 1
-	 */
-	str_size = vsnprintf(NULL, 0, fmt, args) + 1;
-	va_end(args);
-
-	if ((e->actual_size + str_size) < e->allocated_buf_size) {
-		va_start(args, fmt);
-		vsnprintf(e->buf + e->actual_size, str_size, fmt, args);
-		va_end(args);
-	}
-
-	/* Need to update the size even when not updating destination buffer to get the exact size
-	 * of all input strings
-	 */
-	e->actual_size += str_size;
-
-}
-
 static int engines_show(struct seq_file *s, void *data)
 {
 	struct hl_debugfs_entry *entry = s->private;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 6a98aae90f49..ab2497b6d164 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -267,6 +267,30 @@ int hl_access_dev_mem(struct hl_device *hdev, enum pci_region region_type,
 	return 0;
 }
 
+void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...)
+{
+	va_list args;
+	int str_size;
+
+	va_start(args, fmt);
+	/* Calculate formatted string length. Assuming each string is null terminated, hence
+	 * increment result by 1
+	 */
+	str_size = vsnprintf(NULL, 0, fmt, args) + 1;
+	va_end(args);
+
+	if ((e->actual_size + str_size) < e->allocated_buf_size) {
+		va_start(args, fmt);
+		vsnprintf(e->buf + e->actual_size, str_size, fmt, args);
+		va_end(args);
+	}
+
+	/* Need to update the size even when not updating destination buffer to get the exact size
+	 * of all input strings
+	 */
+	e->actual_size += str_size;
+}
+
 enum hl_device_status hl_device_status(struct hl_device *hdev)
 {
 	enum hl_device_status status;
-- 
2.25.1

