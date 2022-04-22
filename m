Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 07:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444719AbiDVHSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 03:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444611AbiDVHST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:18:19 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7250450
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:15:26 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id hnVin0NUEYnCyhnVjn2j0K; Fri, 22 Apr 2022 09:15:25 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 22 Apr 2022 09:15:25 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drivers/base/memory: Fix a reference counting issue in __add_memory_block()
Date:   Fri, 22 Apr 2022 09:15:21 +0200
Message-Id: <d44c63d78aafe844f920dc02ad6af25acc448fcf.1650611702.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in doing put_device()/device_unregister() on a
device that has just been registered a few lines above. This will lead to
a double reference decrement.

I guess that this put_device()/device_unregister() is a cut'n'paste from
remove_memory_block() (i.e. unregister_memory() at the time being) which
does need it.

Fixes: 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in xarray to accelerate lookup")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/base/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 7222ff9b5e05..084d67fd55cc 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -636,10 +636,9 @@ static int __add_memory_block(struct memory_block *memory)
 	}
 	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
 			      GFP_KERNEL));
-	if (ret) {
-		put_device(&memory->dev);
+	if (ret)
 		device_unregister(&memory->dev);
-	}
+
 	return ret;
 }
 
-- 
2.32.0

