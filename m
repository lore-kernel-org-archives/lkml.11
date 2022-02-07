Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644AC35272
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 16:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389885AbiBGQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387604AbiBGQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:25:59 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CE12C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:25:58 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOga5014424;
        Mon, 7 Feb 2022 17:24:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 40/42] tools/nolibc/time: create time.h with time()
Date:   Mon,  7 Feb 2022 17:23:52 +0100
Message-Id: <20220207162354.14293-41-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time() syscall is used by a few simple applications, and is trivial
to implement based on gettimeofday() that we already have. Let's create
the file to ease porting and provide the function. It never returns any
error, though it may segfault in case of invalid pointer, like other
implementations relying on gettimeofday().

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h |  1 +
 tools/include/nolibc/time.h   | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 tools/include/nolibc/time.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 0f375e901a36..561dcdb83cee 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -92,6 +92,7 @@
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
+#include "time.h"
 #include "unistd.h"
 
 /* Used by programs to avoid std includes */
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
new file mode 100644
index 000000000000..d18b7661fdd7
--- /dev/null
+++ b/tools/include/nolibc/time.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * time function definitions for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_TIME_H
+#define _NOLIBC_TIME_H
+
+#include "std.h"
+#include "arch.h"
+#include "types.h"
+#include "sys.h"
+
+static __attribute__((unused))
+time_t time(time_t *tptr)
+{
+	struct timeval tv;
+
+	/* note, cannot fail here */
+	sys_gettimeofday(&tv, NULL);
+
+	if (tptr)
+		*tptr = tv.tv_sec;
+	return tv.tv_sec;
+}
+
+#endif /* _NOLIBC_TIME_H */
-- 
2.35.1

