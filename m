Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C9AC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 16:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356238AbiBGQnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390538AbiBGQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:00 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBD9DC0401EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:34:58 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOedx014410;
        Mon, 7 Feb 2022 17:24:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 27/42] tools/nolibc/sys: make getpgrp(), getpid(), gettid() not set errno
Date:   Mon,  7 Feb 2022 17:23:39 +0100
Message-Id: <20220207162354.14293-28-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These syscalls never fail so there is no need to extract and set errno
for them.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 539af457a91b..ef017cc0a580 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -458,13 +458,7 @@ pid_t sys_getpgrp(void)
 static __attribute__((unused))
 pid_t getpgrp(void)
 {
-	pid_t ret = sys_getpgrp();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return sys_getpgrp();
 }
 
 
@@ -481,13 +475,7 @@ pid_t sys_getpid(void)
 static __attribute__((unused))
 pid_t getpid(void)
 {
-	pid_t ret = sys_getpid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return sys_getpid();
 }
 
 
@@ -504,13 +492,7 @@ pid_t sys_gettid(void)
 static __attribute__((unused))
 pid_t gettid(void)
 {
-	pid_t ret = sys_gettid();
-
-	if (ret < 0) {
-		SET_ERRNO(-ret);
-		ret = -1;
-	}
-	return ret;
+	return sys_gettid();
 }
 
 
-- 
2.35.1

