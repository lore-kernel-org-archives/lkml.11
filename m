Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAE5C32792
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiHWJuP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbiHWJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:48:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB547A758;
        Tue, 23 Aug 2022 01:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A29CEB81BF8;
        Tue, 23 Aug 2022 08:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F374FC4314A;
        Tue, 23 Aug 2022 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661244280;
        bh=CmcPK2lc47Okxh9b7fsrFvpDKb/n652OLhI6HxQ2s24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdoSxSMAEvQfdbvlKlhPCuzuB5GiZQIwiydH6mkglSSllZrC4JI4sRNgLL4aP56Yr
         bN6BDCJv/dhq/IGVWXe1LZL/ZESRKxfpUo5UkM77+yaRocCPS50K35t3/nkodIQWHs
         MF1wqkcwNPEp6EyIRRl52u/ahWCTO8YjRUbcAhxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 113/229] platform/olpc: Fix uninitialized data in debugfs write
Date:   Tue, 23 Aug 2022 10:24:34 +0200
Message-Id: <20220823080057.723034349@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080053.202747790@linuxfoundation.org>
References: <20220823080053.202747790@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 40ec787e1adf302c11668d4cc69838f4d584187d ]

The call to:

	size = simple_write_to_buffer(cmdbuf, sizeof(cmdbuf), ppos, buf, size);

will succeed if at least one byte is written to the "cmdbuf" buffer.
The "*ppos" value controls which byte is written.  Another problem is
that this code does not check for errors so it's possible for the entire
buffer to be uninitialized.

Inintialize the struct to zero to prevent reading uninitialized stack
data.

Debugfs is normally only writable by root so the impact of this bug is
very minimal.

Fixes: 6cca83d498bd ("Platform: OLPC: move debugfs support from x86 EC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YthIKn+TfZSZMEcM@kili
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/olpc/olpc-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 374a8028fec7..b36a000ed969 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -170,7 +170,7 @@ static ssize_t ec_dbgfs_cmd_write(struct file *file, const char __user *buf,
 	int i, m;
 	unsigned char ec_cmd[EC_MAX_CMD_ARGS];
 	unsigned int ec_cmd_int[EC_MAX_CMD_ARGS];
-	char cmdbuf[64];
+	char cmdbuf[64] = "";
 	int ec_cmd_bytes;
 
 	mutex_lock(&ec_dbgfs_lock);
-- 
2.35.1



