Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CDFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 10:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiCVKXm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiCVKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:34 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A4811B7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:22:04 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id EF33E7E343;
        Tue, 22 Mar 2022 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944523;
        bh=vWuQhpoAXiBJj3wfUX35L7A8raKBOQqVL60x1T1gmI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpwcf9F07dn3br1s8e47fpUodg+PtsS/O7sdpWg5xam/tebk5YqqseF4WV9nLvrLx
         R0f/cjcT6EqBf5GPINaxgDQ9GE+xhkinW9uEsebfZBKILuMtZB0nHnQrLrmm0l9GQS
         EZtTy9oxqFrpZrJT9NF9LEfShN1WJ8ljl8Iuwa62dQDP3TszQm5Q9DkcC4CiTXY2dN
         FjdvNr+FsnUlWPJDnOnxWUisClxdqu+PB89BpDiAO8UfcfN+ZzLUgC6eDr3W1mJfUV
         Xg+2LqxbmcNrxI1+Rk9bWUZk9om8jBNWbzTz6enf9EGZgaVIp89NxTMcV08rclNRoI
         TrWTRN2LMdHzA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v2 8/8] tools/include/string: Implement `strdup()` and `strndup()`
Date:   Tue, 22 Mar 2022 17:21:15 +0700
Message-Id: <20220322102115.186179-9-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are currently only available on architectures that have
my_syscall6() macro implemented. Since these functions use malloc(),
malloc() uses mmap(), mmap() depends on my_syscall6() macro.

On architectures that don't support my_syscall6(), these function will
always return NULL with errno set to ENOSYS.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

@@ Changelog:

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-7-ammarfaizi2@gnuweeb.org/
   RFC v1 -> RFC v2:
    - Update strdup and strndup implementation, use strlen and strnlen to get
      the string length first (comment from Willy and Alviro).
    - Fix the subject line prefix, it was "tools/include/string: ", it should be
      "tools/nolibc/string: ".
    - Update the commit message.
---
 tools/include/nolibc/string.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 1426eefc1ef2..bcc76f89199e 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -9,6 +9,8 @@
 
 #include "std.h"
 
+static void *malloc(size_t len);
+
 /*
  * As much as possible, please keep functions alphabetically sorted.
  */
@@ -147,6 +149,36 @@ size_t strnlen(const char *str, size_t maxlen)
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
Ammar Faizi

