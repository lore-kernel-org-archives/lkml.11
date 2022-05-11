Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA9DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 13:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbiEKNV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbiEKNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEBE2469DF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE4261CB0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75275C34111;
        Wed, 11 May 2022 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652275195;
        bh=ZeV3gMfU+a1WJKfFQfnsBBxgRnqLCEoRt8Ufidruioo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtaP+Us29DU+hM5bw51wQRbzIjbAceM+GvsOrOBoOs/c1EE+1ubdJs4DZAmZ2WK30
         GdIZAwgrmBlOJRiiZEYOQwLcZyKAOODTXgIwxlncDqk+79Gh5RhaZYMropUfvYUBt6
         wEQ1iVX4ldB4sLI/sVeb7hXk7sZhGlBbQ5ER724uZjnBkun5UbScCPWT6B6s3DIYYn
         J4TC16P1SWSBTNb5t/zGtHKsg3SiX0S58iZit/lvYv5hfefKly1u9ANoFQ4An964kn
         PY4xFfOOX8CQ7flf+q+6S/wbcfo5+VkvUfsVAbEa5pU5F3q83PDh7PuEE0ah/qECEN
         8sF9BvEuTcFeQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 3/3] habanalabs: return -EFAULT on copy_to_user error
Date:   Wed, 11 May 2022 16:19:48 +0300
Message-Id: <20220511131948.1156471-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511131948.1156471-1-ogabbay@kernel.org>
References: <20220511131948.1156471-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If copy_to_user failed in info ioctl, we always return -EFAULT so the
user will know there was an error.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 51fa56287309..8fd2b427863f 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -118,7 +118,6 @@ static int hw_events_info(struct hl_device *hdev, bool aggregate,
 
 static int events_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
-	int rc;
 	u32 max_size = args->return_size;
 	u64 events_mask;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
@@ -131,8 +130,7 @@ static int events_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	hpriv->notifier_event.events_mask = 0;
 	mutex_unlock(&hpriv->notifier_event.lock);
 
-	rc = copy_to_user(out, &events_mask, sizeof(u64));
-	return rc;
+	return copy_to_user(out, &events_mask, sizeof(u64)) ? -EFAULT : 0;
 }
 
 static int dram_usage_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
-- 
2.25.1

