Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5168FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 00:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiDSAuS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbiDSApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1592DD5D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB8761456
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCE7C341E2;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=94aI9qxkG30EZL+NFbTk5f0WGVrPuO81OwEwGfH5qx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUaUToYQTieIpB7eUgphM+VthoGwLj9MOhMD1LyYdfMwJaiwxLJDLXupop6OEMpfg
         1ELvTUzAv3CSoebLHsHR7FlyrizgJF0dJvYbfnjD07woViSsIUyURtjgE+SnkB5KDQ
         XJxNU1eFWsTRQAKtfIq1mFT1dw+eT7gqq96plA3ouuHqwncEVASN+P/luVNUpQrcAn
         wcszn+GAzmH3JQlqpW+AGuoQ4VCaOjR9dLu46Lzn28wFz+KudGZs7vg3ip3jal66HR
         FWOnhXHE2GMVH12ZJl3QvMtjGwOVybqkcIUOvpua+64lmqauxBtXQYUSrQdPTyyjYM
         3J0RR8ZGdyqWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 77DD35C3256; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 61/61] tools/nolibc/string: Implement `strdup()` and `strndup()`
Date:   Mon, 18 Apr 2022 17:42:25 -0700
Message-Id: <20220419004225.3952530-61-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

These functions are currently only available on architectures that have
my_syscall6() macro implemented. Since these functions use malloc(),
malloc() uses mmap(), mmap() depends on my_syscall6() macro.

On architectures that don't support my_syscall6(), these function will
always return NULL with errno set to ENOSYS.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index f43d52a44d09..bef35bee9c44 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -9,6 +9,8 @@
 
 #include "std.h"
 
+static void *malloc(size_t len);
+
 /*
  * As much as possible, please keep functions alphabetically sorted.
  */
@@ -156,6 +158,36 @@ size_t strnlen(const char *str, size_t maxlen)
 	return len;
 }
 
+static __attribute__((unused))
+char *strdup(const char *str)
+{
+	size_t len;
+	char *ret;
+
+	len = strlen(str);
+	ret = malloc(len + 1);
+	if (__builtin_expect(ret != NULL, 1))
+		memcpy(ret, str, len + 1);
+
+	return ret;
+}
+
+static __attribute__((unused))
+char *strndup(const char *str, size_t maxlen)
+{
+	size_t len;
+	char *ret;
+
+	len = strnlen(str, maxlen);
+	ret = malloc(len + 1);
+	if (__builtin_expect(ret != NULL, 1)) {
+		memcpy(ret, str, len);
+		ret[len] = '\0';
+	}
+
+	return ret;
+}
+
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
 {
-- 
2.31.1.189.g2e36527f23

