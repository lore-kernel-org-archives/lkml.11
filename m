Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F9AC3F6B0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Aug 2022 16:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiHMQHy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Aug 2022 12:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiHMQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:07:51 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D369DEF5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:07:48 -0700 (PDT)
X-QQ-mid: bizesmtp73t1660406861tr2eb0lj
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 14 Aug 2022 00:07:35 +0800 (CST)
X-QQ-SSF: 0100000000000080H000000A0000020
X-QQ-FEAT: cHEuLz3LyUhbbjnxI6ywZpHdtaOOGt5yb1sGXIOVEEY4CkKdxf9SBSTw/qQk9
        t6FtHdabvwYtbRS8Kuxfn5LQQMQSXY7SUCyzG39ElFcFBYP59eMuVZAvLGyeKupHgI8aUj7
        KVj8wxnhZrEmFhggbyRXYvnR0wvZnnQnez6860jAg296LFTyxE5U+7+91TKwiWP6G3N7ZZu
        fOuqpTtJR6eHg91nlZ8ZwWzVoRWbW4YPQPyOAwb1z/3LK6qcmT6t+32wpx75v9LM/VdxYr0
        sCCYouA/hnOr3dueJZUYJodMrFy0G7eQxvumrElg7Wn2D/bZKvRUuT/fTH7rsC/wb3/9FOW
        uedFM2R2CzDY/UiJ1nLNMYT3TTfq2LJJoUpnjP+c0yRpLNoyFw=
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] treewide: Unneeded semicolon
Date:   Sun, 14 Aug 2022 00:07:23 +0800
Message-Id: <20220813160723.5769-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no semicolon after '}' in line 1615.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 fs/ntfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 5ae8de09b271..d663b49df84e 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ static bool load_and_init_attrdef(ntfs_volume *vol)
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
-- 
2.17.1

