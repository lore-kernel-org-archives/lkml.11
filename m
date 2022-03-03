Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D38C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 03:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiCCDQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 22:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiCCDQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:16:07 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F2DF70CD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:15:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V650kGS_1646277314;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V650kGS_1646277314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 11:15:15 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] kfence: Allow re-enabling KFENCE after system startup
Date:   Thu,  3 Mar 2022 11:15:04 +0800
Message-Id: <20220303031505.28495-2-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220303031505.28495-1-dtcccc@linux.alibaba.com>
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If once KFENCE is disabled by:
echo 0 > /sys/module/kfence/parameters/sample_interval
KFENCE could never be re-enabled until next rebooting.

Allow re-enabling it by writing a positive num to sample_interval.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 mm/kfence/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 13128fa13062..19eb123c0bba 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -55,6 +55,7 @@ EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
 #endif
 #define MODULE_PARAM_PREFIX "kfence."
 
+static int kfence_enable_late(void);
 static int param_set_sample_interval(const char *val, const struct kernel_param *kp)
 {
 	unsigned long num;
@@ -65,10 +66,11 @@ static int param_set_sample_interval(const char *val, const struct kernel_param
 
 	if (!num) /* Using 0 to indicate KFENCE is disabled. */
 		WRITE_ONCE(kfence_enabled, false);
-	else if (!READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
-		return -EINVAL; /* Cannot (re-)enable KFENCE on-the-fly. */
 
 	*((unsigned long *)kp->arg) = num;
+
+	if (num && !READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
+		return kfence_enable_late();
 	return 0;
 }
 
@@ -787,6 +789,16 @@ void __init kfence_init(void)
 		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
 }
 
+static int kfence_enable_late(void)
+{
+	if (!__kfence_pool)
+		return -EINVAL;
+
+	WRITE_ONCE(kfence_enabled, true);
+	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
+	return 0;
+}
+
 void kfence_shutdown_cache(struct kmem_cache *s)
 {
 	unsigned long flags;
-- 
2.27.0

