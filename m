Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C57C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jan 2022 08:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351805AbiALIyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jan 2022 03:54:10 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58447 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351785AbiALIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:54:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1e05Wd_1641977645;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1e05Wd_1641977645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jan 2022 16:54:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jack@suse.cz
Cc:     amir73il@gmail.com, repnop@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fanotify: remove variable set but not used
Date:   Wed, 12 Jan 2022 16:54:03 +0800
Message-Id: <20220112085403.74670-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that uses the pointer info has been removed in
'https://lore.kernel.org/all/20211129201537.1932819-11-amir73il@gmail.com/'
and fanotify_event_info() doesn't change 'event', so the declaration and 
assignment of info can be removed.

Eliminate the following clang warning:
fs/notify/fanotify/fanotify_user.c:161:24: warning: variable ‘info’ set
but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/notify/fanotify/fanotify_user.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 73b1615f9d96..1026f67b1d1e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -158,7 +158,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 				 struct fanotify_event *event)
 {
 	size_t event_len = FAN_EVENT_METADATA_LEN;
-	struct fanotify_info *info;
 	int fh_len;
 	int dot_len = 0;
 
@@ -168,8 +167,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
-	info = fanotify_event_info(event);
-
 	if (fanotify_event_has_any_dir_fh(event)) {
 		event_len += fanotify_dir_name_info_len(event);
 	} else if ((info_mode & FAN_REPORT_NAME) &&
-- 
2.20.1.7.g153144c

