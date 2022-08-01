Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F19C00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 08:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiHAIvb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiHAIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:51:30 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7C54DF4E;
        Mon,  1 Aug 2022 01:51:28 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 604F61E80D06;
        Mon,  1 Aug 2022 16:50:53 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S4LnGvzaf86W; Mon,  1 Aug 2022 16:50:50 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AFC1F1E80CEA;
        Mon,  1 Aug 2022 16:50:50 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] proc: remove initialization assignment
Date:   Mon,  1 Aug 2022 16:51:17 +0800
Message-Id: <20220801085117.4313-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation address of the core_parent pointer variable is first
executed in the function, no initialization assignment is required.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 021e83fe831f..50ba9e4fb284 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1246,7 +1246,7 @@ static bool get_links(struct ctl_dir *dir,
 static int insert_links(struct ctl_table_header *head)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
-	struct ctl_dir *core_parent = NULL;
+	struct ctl_dir *core_parent;
 	struct ctl_table_header *links;
 	int err;
 
-- 
2.18.2

