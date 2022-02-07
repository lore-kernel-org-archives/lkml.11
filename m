Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C28C4167D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 16:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382229AbiBGQaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389773AbiBGQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:56 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD5CFC0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:53 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOfEK014416;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 32/42] tools/nolibc: move exported functions to their own section
Date:   Mon,  7 Feb 2022 17:23:44 +0100
Message-Id: <20220207162354.14293-33-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions like raise() and memcpy() are permanently exported because
they're needed by libgcc on certain platforms. However most of the time
they are not needed and needlessly take space.

Let's move them to their own sub-section, called .text.nolibc_<function>.
This allows ld to get rid of them if unused when passed --gc-sections.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 2 +-
 tools/include/nolibc/string.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 4cc1fdf6791e..da08ff30c15a 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -314,7 +314,7 @@ int msleep(unsigned int msecs)
 }
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
-__attribute__((weak,unused))
+__attribute__((weak,unused,section(".text.nolibc_raise")))
 int raise(int signal)
 {
 	return sys_kill(sys_getpid(), signal);
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index c550c9ba8f4c..c1661589cb3c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -69,7 +69,7 @@ void *memmove(void *dst, const void *src, size_t len)
 }
 
 /* must be exported, as it's used by libgcc on ARM */
-__attribute__((weak,unused))
+__attribute__((weak,unused,section(".text.nolibc_memcpy")))
 void *memcpy(void *dst, const void *src, size_t len)
 {
 	return _nolibc_memcpy_up(dst, src, len);
-- 
2.35.1

