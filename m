Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89BEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 17:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349498AbiCURfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348720AbiCURe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:58 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D7C36A072
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:31 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXNUw007573;
        Mon, 21 Mar 2022 18:33:23 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 4/8] tools/nolibc/string: add strcmp() and strncmp()
Date:   Mon, 21 Mar 2022 18:33:10 +0100
Message-Id: <20220321173314.7519-5-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need these functions all the time, including when checking environment
variables and parsing command-line arguments. These implementations were
optimized to show optimal code size on a wide range of compilers (22 bytes
return included for strcmp(), 33 for strncmp()).

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 4554b6fcb400..0d5e870c7c0b 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -102,6 +102,17 @@ char *strchr(const char *s, int c)
 	return NULL;
 }
 
+static __attribute__((unused))
+int strcmp(const char *a, const char *b)
+{
+	unsigned int c;
+	int diff;
+
+	while (!(diff = (unsigned char)*a++ - (c = (unsigned char)*b++)) && c)
+		;
+	return diff;
+}
+
 static __attribute__((unused))
 char *strcpy(char *dst, const char *src)
 {
@@ -184,6 +195,18 @@ char *strncat(char *dst, const char *src, size_t size)
 	return orig;
 }
 
+static __attribute__((unused))
+int strncmp(const char *a, const char *b, size_t size)
+{
+	unsigned int c;
+	int diff = 0;
+
+	while (size-- &&
+	       !(diff = (unsigned char)*a++ - (c = (unsigned char)*b++)) && c)
+		;
+
+	return diff;
+}
 
 static __attribute__((unused))
 char *strncpy(char *dst, const char *src, size_t size)
-- 
2.35.1

