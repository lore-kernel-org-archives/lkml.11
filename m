Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3EBC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 07:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiBYHtU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 02:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiBYHtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:49:18 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EDA1AAFD3;
        Thu, 24 Feb 2022 23:48:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V5RxXOB_1645775320;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V5RxXOB_1645775320)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Feb 2022 15:48:44 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hdegoede@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] vboxsf: Remove redundant assignment to out_len
Date:   Fri, 25 Feb 2022 15:48:38 +0800
Message-Id: <20220225074838.553-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following clang-w1 warning:

fs/vboxsf/utils.c:442:9: warning: variable 'out_len' set but not used
[-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Delete " out_len += nb;".

 fs/vboxsf/utils.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index e1db0f3f7e5e..7f2838c42dcc 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -439,7 +439,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 {
 	const char *in;
 	char *out;
-	size_t out_len;
 	size_t out_bound_len;
 	size_t in_bound_len;
 
@@ -447,7 +446,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 	in_bound_len = utf8_len;
 
 	out = name;
-	out_len = 0;
 	/* Reserve space for terminating 0 */
 	out_bound_len = name_bound_len - 1;
 
@@ -468,7 +466,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 
 		out += nb;
 		out_bound_len -= nb;
-		out_len += nb;
 	}
 
 	*out = 0;
-- 
2.20.1.7.g153144c

