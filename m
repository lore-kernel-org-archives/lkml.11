Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488A3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiCURfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348534AbiCURe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F2566617
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXNrS007571;
        Mon, 21 Mar 2022 18:33:23 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 2/8] tools/nolibc/stdlib: add a simple getenv() implementation
Date:   Mon, 21 Mar 2022 18:33:08 +0100
Message-Id: <20220321173314.7519-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implementation relies on an extern definition of the environ
variable, that the caller must declare and initialize from envp.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 733105c574ee..aca8616335e3 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -60,6 +60,29 @@ int atoi(const char *s)
 	return atol(s);
 }
 
+/* Tries to find the environment variable named <name> in the environment array
+ * pointed to by global variable "environ" which must be declared as a char **,
+ * and must be terminated by a NULL (it is recommended to set this variable to
+ * the "envp" argument of main()). If the requested environment variable exists
+ * its value is returned otherwise NULL is returned.
+ */
+static __attribute__((unused))
+char *getenv(const char *name)
+{
+	extern char **environ;
+	int idx, i;
+
+	if (environ) {
+		for (idx = 0; environ[idx]; idx++) {
+			for (i = 0; name[i] && name[i] == environ[idx][i];)
+				i++;
+			if (!name[i] && environ[idx][i] == '=')
+				return &environ[idx][i+1];
+		}
+	}
+	return NULL;
+}
+
 /* Converts the unsigned long integer <in> to its hex representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
-- 
2.35.1

