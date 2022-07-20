Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E6CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 14:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiGTOsL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGTOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:09 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6BC4F1A2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:08 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26KEm0SO080968;
        Wed, 20 Jul 2022 23:48:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Wed, 20 Jul 2022 23:48:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26KElxKQ080963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jul 2022 23:48:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ffa62ece-6a42-2644-16cf-0d33ef32c676@I-love.SAKURA.ne.jp>
Date:   Wed, 20 Jul 2022 23:47:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] mm: shrinkers: fix double kfree on shrinker name
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting double kfree() at free_prealloced_shrinker() [1], for
destroy_unused_super() calls free_prealloced_shrinker() even if
prealloc_shrinker() returned an error. Explicitly clear shrinker name
when prealloc_shrinker() called kfree().

Link: https://syzkaller.appspot.com/bug?extid=8b481578352d4637f510 [1]
Reported-by: syzbot <syzbot+8b481578352d4637f510@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: e33c267ab70de424 ("mm: shrinkers: provide shrinkers with names")
---
 mm/vmscan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 64ffdcd019a9..3302d9ed332e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -707,8 +707,10 @@ int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
 		return -ENOMEM;
 
 	err = __register_shrinker(shrinker);
-	if (err)
+	if (err) {
 		kfree_const(shrinker->name);
+		shrinker->name = NULL;
+	}
 	return err;
 }
 #else
-- 
2.18.4
