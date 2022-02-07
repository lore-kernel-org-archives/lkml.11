Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FB3C4167B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 16:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359519AbiBGQnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390502AbiBGQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:34:53 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2807C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:34:50 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOdBd014406;
        Mon, 7 Feb 2022 17:24:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 23/42] tools/nolibc/stdio: add perror() to report the errno value
Date:   Mon,  7 Feb 2022 17:23:35 +0100
Message-Id: <20220207162354.14293-24-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't contain the text for the error codes, but instead displays
"errno=" followed by the errno value. Just like the regular errno, if
a non-empty message is passed, it's placed followed with ": " on the
output before the errno code. The message is emitted on stderr.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index a73cf24cb68d..5f1cf32470d3 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -286,4 +286,10 @@ int printf(const char *fmt, ...)
 	return ret;
 }
 
+static __attribute__((unused))
+void perror(const char *msg)
+{
+	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
+}
+
 #endif /* _NOLIBC_STDIO_H */
-- 
2.35.1

