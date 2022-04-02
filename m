Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF88AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 07:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiDBHWO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 03:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBHWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:22:12 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313D114B85E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:20:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V8yXVIm_1648884017;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V8yXVIm_1648884017)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 15:20:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] tracing: Fix tracing_map_sort_entries() kernel-doc comment
Date:   Sat,  2 Apr 2022 15:20:15 +0800
Message-Id: <20220402072015.45864-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @n_sort_keys and make @sort_key ->
@sort_keys in tracing_map_sort_entries() kernel-doc comment
to remove warnings found by running scripts/kernel-doc, which
is caused by using 'make W=1'.

kernel/trace/tracing_map.c:1073: warning: Function parameter or member
'sort_keys' not described in 'tracing_map_sort_entries'
kernel/trace/tracing_map.c:1073: warning: Function parameter or member
'n_sort_keys' not described in 'tracing_map_sort_entries'
kernel/trace/tracing_map.c:1073: warning: Excess function parameter
'sort_key' description in 'tracing_map_sort_entries'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/tracing_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9628b5571846..9901708ce6b8 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -1045,7 +1045,8 @@ static void sort_secondary(struct tracing_map *map,
 /**
  * tracing_map_sort_entries - Sort the current set of tracing_map_elts in a map
  * @map: The tracing_map
- * @sort_key: The sort key to use for sorting
+ * @sort_keys: The sort key to use for sorting
+ * @n_sort_keys: hitcount, always have at least one
  * @sort_entries: outval: pointer to allocated and sorted array of entries
  *
  * tracing_map_sort_entries() sorts the current set of entries in the
-- 
2.20.1.7.g153144c

