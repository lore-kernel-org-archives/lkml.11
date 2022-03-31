Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B996C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 11:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiCaMAV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiCaL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:59:52 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836A208C26;
        Thu, 31 Mar 2022 04:58:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8imT7F_1648727881;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8imT7F_1648727881)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Mar 2022 19:58:02 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v7 05/19] cachefiles: enable on-demand read mode
Date:   Thu, 31 Mar 2022 19:57:39 +0800
Message-Id: <20220331115753.89431-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable on-demand read mode by adding an optional parameter to the "bind"
command.

On-demand mode will be turned on when this parameter is "ondemand", i.e.
"bind ondemand". Otherwise cachefiles will work in the original mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index d155a6da90d3..bd902a4c4cd8 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -738,11 +738,6 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 	    cache->brun_percent  >= 100)
 		return -ERANGE;
 
-	if (*args) {
-		pr_err("'bind' command doesn't take an argument\n");
-		return -EINVAL;
-	}
-
 	if (!cache->rootdirname) {
 		pr_err("No cache directory specified\n");
 		return -EINVAL;
@@ -754,6 +749,14 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 		return -EBUSY;
 	}
 
+	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
+	    !strcmp(args, "ondemand")) {
+		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+	} else if (*args) {
+		pr_err("'bind' command doesn't take an argument\n");
+		return -EINVAL;
+	}
+
 	/* Make sure we have copies of the tag string */
 	if (!cache->tag) {
 		/*
-- 
2.27.0

