Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 00:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiDSAsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241345AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96627CCC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828E161418
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CEAC34117;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=Etkq3oSDT4hNBPlmXk/Nrwh55PN7zJ9qlmJJVAirA54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUytUMAFUcybin2cWfEG1efbyazGgwLPHD3c+TYkLLDOltpdhICbxQHFioxPYsoR3
         g3lZUduEDL2jTDkFd9NBm07oVfp2uztZTyum+r33+DCZupl+nqhXhIPAUjwRZay117
         tfBl5K7a+tVlC43anAFSjE+Yh88urkIfzLofmk/8urRu7wiCXrlH+FuUKtCPsWpRy2
         AvKITRfLQr45AZRnybqIohBA+MLiiFJhbhuUcE9pWbGq33l0igLhYyYSsLvf9unbVC
         xIghEMgcn/BYt9HzNr6UfklpJ+Gxf0VNF3ryyRV4UjMOwtO5wBiOIyiMozvZUmAxyp
         muDyUVENqwdVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4FE265C322B; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 40/61] tools/nolibc/time: create time.h with time()
Date:   Mon, 18 Apr 2022 17:42:04 -0700
Message-Id: <20220419004225.3952530-40-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The time() syscall is used by a few simple applications, and is trivial
to implement based on gettimeofday() that we already have. Let's create
the file to ease porting and provide the function. It never returns any
error, though it may segfault in case of invalid pointer, like other
implementations relying on gettimeofday().

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

