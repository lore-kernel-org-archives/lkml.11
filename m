Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA340C4167E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 16:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382007AbiBGQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbiBGQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:14 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE015C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:11 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOcVm014394;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 11/42] tools/nolibc/types: move the FD_* functions to macros in types.h
Date:   Mon,  7 Feb 2022 17:23:23 +0100
Message-Id: <20220207162354.14293-12-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FD_SET, FD_CLR, FD_ISSET, FD_ZERO are supposed to be macros and not
functions. In addition we already have a file dedicated to such macros
and types used by syscalls, it's types.h, so let's move them
there and turn them to macros. FD_CLR() and FD_ISSET() were missing,
so they were added. FD_ZERO() now deals with its own loop so that it
doesn't rely on memset() that sets one byte at a time.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 14 --------------
 tools/include/nolibc/types.h  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index c96c6cb7f3ae..2267d98337ea 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -118,20 +118,6 @@ const char *ltoa(long in)
 
 /* Here come a few helper functions */
 
-static __attribute__((unused))
-void FD_ZERO(fd_set *set)
-{
-	memset(set, 0, sizeof(*set));
-}
-
-static __attribute__((unused))
-void FD_SET(int fd, fd_set *set)
-{
-	if (fd < 0 || fd >= FD_SETSIZE)
-		return;
-	set->fd32[fd / 32] |= 1 << (fd & 31);
-}
-
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 static __attribute__((unused))
 dev_t makedev(unsigned int major, unsigned int minor)
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 2f09abaf95f1..b79e10025780 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -75,6 +75,36 @@ typedef struct {
 	uint32_t fd32[FD_SETSIZE / 32];
 } fd_set;
 
+#define FD_CLR(fd, set) do {                                            \
+		int __fd = (int)(fd);                                   \
+		fd_set *__set = (fd_set *)(set);                        \
+		if (__fd >= 0 && __fd < FD_SETSIZE)                     \
+			__set->fd32[__fd / 32] &= ~(1U << (__fd & 31)); \
+	} while (0)
+
+#define FD_SET(fd, set) do {                                            \
+		int __fd = (int)(fd);                                   \
+		fd_set *__set = (fd_set *)(set);                        \
+		if (__fd >= 0 && __fd < FD_SETSIZE)                     \
+			__set->fd32[__fd / 32] |= 1U << (__fd & 31);    \
+	} while (0)
+
+#define FD_ISSET(fd, set) ({                                            \
+		int __fd = (int)(fd);                                   \
+		fd_set *__set = (fd_set *)(set);                        \
+		if (__fd >= 0 && __fd < FD_SETSIZE)                     \
+			!!(__set->fd32[__fd / 32] & 1U << (__fd & 31)); \
+		else                                                    \
+			0;                                              \
+	})
+
+#define FD_ZERO(set) do {                                               \
+		int __idx;                                              \
+		fd_set *__set = (fd_set *)(set);                        \
+		for (__idx = 0; __idx < FD_SETSIZE / 32; __idx ++)      \
+			__set->fd32[__idx] = 0;                         \
+	} while (0)
+
 /* for poll() */
 struct pollfd {
 	int fd;
-- 
2.35.1

