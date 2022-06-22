Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF6DC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 02:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356331AbiFVC66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 22:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356000AbiFVC64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:58:56 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69C6AA3;
        Tue, 21 Jun 2022 19:58:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 91A0C1E80CD2;
        Wed, 22 Jun 2022 10:58:45 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5cRq9H8Da_xB; Wed, 22 Jun 2022 10:58:42 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.97])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 63C8B1E80C7D;
        Wed, 22 Jun 2022 10:58:42 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] coredump: Fix typo
Date:   Wed, 22 Jun 2022 10:58:47 +0800
Message-Id: <20220622025847.13335-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'postion' to 'position'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..9efbe3d0cbc8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -756,7 +756,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		core_dumped = binfmt->core_dump(&cprm);
 		/*
 		 * Ensures that file size is big enough to contain the current
-		 * file postion. This prevents gdb from complaining about
+		 * file position. This prevents gdb from complaining about
 		 * a truncated file if the last "write" to the file was
 		 * dump_skip.
 		 */
-- 
2.25.1

