Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF3C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 09:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiHLJKR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiHLJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:10:14 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4AE2611E;
        Fri, 12 Aug 2022 02:10:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VM17qn1_1660295406;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VM17qn1_1660295406)
          by smtp.aliyun-inc.com;
          Fri, 12 Aug 2022 17:10:07 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] cachefiles: support multiple daemons
Date:   Fri, 12 Aug 2022 17:10:05 +0800
Message-Id: <20220812091005.65540-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CacheFiles can work in either the original mode caching for
network filesystems, or on-demand mode for container scenarios. Due to
the limit of singleton daemon, these two modes can not co-exist.

The current implementation can already work well in multiple daemon
mode. This patch only removes the explicit limitation, and thus enabling
the multiple daemon mdoe.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
PS:
Currently all filessytems using fscache (including network filesystems
and erofs) call fscache_acquire_volume() with @cache_name is NULL, and
thus they will be bound to the first registered cache. In this case, if
the first registered cache is in the original mode, mounting erofs will
fail since the boudn cache is not in on-demand mode.

This can be fixed by specifying the name of the cache to be bound when
calling fscache_acquire_volume(). Or adds a flag field to
fscache_acquire_volume(), specifying if the caller wants to bind a cache
in on-demand mode or not.

---
 fs/cachefiles/daemon.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..a4f70516d250 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -44,8 +44,6 @@ static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
 static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
 static void cachefiles_daemon_unbind(struct cachefiles_cache *);
 
-static unsigned long cachefiles_open;
-
 const struct file_operations cachefiles_daemon_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cachefiles_daemon_open,
@@ -95,16 +93,10 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	/* the cachefiles device may only be open once at a time */
-	if (xchg(&cachefiles_open, 1) == 1)
-		return -EBUSY;
-
 	/* allocate a cache record */
 	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
-	if (!cache) {
-		cachefiles_open = 0;
+	if (!cache)
 		return -ENOMEM;
-	}
 
 	mutex_init(&cache->daemon_mutex);
 	init_waitqueue_head(&cache->daemon_pollwq);
@@ -169,7 +161,6 @@ void cachefiles_put_unbind_pincount(struct cachefiles_cache *cache)
 {
 	if (refcount_dec_and_test(&cache->unbind_pincount)) {
 		cachefiles_daemon_unbind(cache);
-		cachefiles_open = 0;
 		kfree(cache);
 	}
 }
-- 
2.24.4

