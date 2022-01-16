Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AC8C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jan 2022 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiAPMth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jan 2022 07:49:37 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:59232 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiAPMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:49:32 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 94yOnSI1HEuQ294yPnkO1m; Sun, 16 Jan 2022 13:49:31 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 16 Jan 2022 13:49:31 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Shevchenko <andy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] lib/string_helpers: Use the given gfp flag when allocating memory
Date:   Sun, 16 Jan 2022 13:49:22 +0100
Message-Id: <30a0c2011f8034378639883339fa7d7c55e034a5.1642337349.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup_quotable_cmdline() is given a gfp flag that is passed and used for
memory allocation in kstrdup_quotable() just a few lines below.

It looks reasonable to use this gfp value for the buffer allocated and
freed in kstrdup_quotable_cmdline() as well.

Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
According to what I've found in 5.16, all callers use GFP_KERNEL, so this
patch should be a no-op.
But who knows how it will be used in the future. Better safe than sorry.
---
 lib/string_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 90f9f1b7afec..7aceeb40dfd7 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -624,7 +624,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
 	char *buffer, *quoted;
 	int i, res;
 
-	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, gfp);
 	if (!buffer)
 		return NULL;
 
-- 
2.32.0

