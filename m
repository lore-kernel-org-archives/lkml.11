Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D83AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 07:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiCWHUH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbiCWHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:19:51 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F420B72E33
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:18:21 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22N7IDK9014464;
        Wed, 23 Mar 2022 08:18:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 2/2] tools/nolibc/stdlib: only reference the external environ when inlined
Date:   Wed, 23 Mar 2022 08:18:07 +0100
Message-Id: <20220323071807.14413-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220323071807.14413-1-w@1wt.eu>
References: <20220323071807.14413-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with gcc at -O0 we're seeing link errors due to the
"environ" variable being referenced by getenv(). The problem is that
at -O0 gcc will not inline getenv() and will not drop the external
reference. One solution would be to locally declare the variable as
weak, but then it would appear in all programs even those not using
it, and would be confusing to users of getenv() who would forget to
set environ to envp.

An alternate approach used in this patch consists in always inlining
the outer part of getenv() that references this extern so that it's
always dropped when not used. The biggest part of the function was
now moved to a new function called _getenv() that's still not inlined
by default.

Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index aca8616335e3..8a07e263f0d0 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -60,16 +60,17 @@ int atoi(const char *s)
 	return atol(s);
 }
 
-/* Tries to find the environment variable named <name> in the environment array
- * pointed to by global variable "environ" which must be declared as a char **,
- * and must be terminated by a NULL (it is recommended to set this variable to
- * the "envp" argument of main()). If the requested environment variable exists
- * its value is returned otherwise NULL is returned.
+/* getenv() tries to find the environment variable named <name> in the
+ * environment array pointed to by global variable "environ" which must be
+ * declared as a char **, and must be terminated by a NULL (it is recommended
+ * to set this variable to the "envp" argument of main()). If the requested
+ * environment variable exists its value is returned otherwise NULL is
+ * returned. getenv() is forcefully inlined so that the reference to "environ"
+ * will be dropped if unused, even at -O0.
  */
 static __attribute__((unused))
-char *getenv(const char *name)
+char *_getenv(const char *name, char **environ)
 {
-	extern char **environ;
 	int idx, i;
 
 	if (environ) {
@@ -83,6 +84,13 @@ char *getenv(const char *name)
 	return NULL;
 }
 
+static inline __attribute__((unused,always_inline))
+char *getenv(const char *name)
+{
+	extern char **environ;
+	return _getenv(name, environ);
+}
+
 /* Converts the unsigned long integer <in> to its hex representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
-- 
2.35.1

