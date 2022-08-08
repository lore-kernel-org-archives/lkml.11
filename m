Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ED6C19F2A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 02:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbiHHClq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Aug 2022 22:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiHHCli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A0D2195
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iecNj4WrMIq076EGFI4G8r6T8aFWcjvbvosteNe+9mQ=; b=Ez13KjVAlCu0nKB9Ummsx8Cb9J
        ZpbWKQD3ZMlfkTWkRTHdByuUqWF3IjBQ1Y/G3rzTPzh3v2frnGV2TXnl8vzGxxOrcwNjHnlDu/G7E
        kSfZVPrhAH7HuZTCyV+4yzgClAu/Rs95nNPmw1+DnHsli8RQArVoV/ewIQ4FARb/XMqSHrNXrQ2Fd
        Q8Y15fG12X4YgNdSLGgvuvSAmZAf1jBkRIGt6yKAbOt9VNPJvEaMBHrzHXKzMx2tK8OalV89wGIdh
        XTB7z1zEKKsv+Bi69FbZhNAINgSjXB0jcSUEAkCVX7epTYBSpy1wPpzf2F4cjWCDccxeMzC30NmHi
        fG8av77Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRX-1J; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v5 05/32] lib/string_helpers: string_get_size() now returns characters wrote
Date:   Mon,  8 Aug 2022 03:41:01 +0100
Message-Id: <20220808024128.3219082-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

printbuf now needs to know the number of characters that would have been
written if the buffer was too small, like snprintf(); this changes
string_get_size() to return the the return value of snprintf().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 include/linux/string_helpers.h | 4 ++--
 lib/string_helpers.c           | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 67de398944e8..52e0f1d283b9 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -19,8 +19,8 @@ enum string_size_units {
 	STRING_UNITS_2,		/* use binary powers of 2^10 */
 };
 
-void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
-		     char *buf, int len);
+int string_get_size(u64 size, u64 blk_size, enum string_size_units units,
+		    char *buf, int len);
 
 #define UNESCAPE_SPACE		BIT(0)
 #define UNESCAPE_OCTAL		BIT(1)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 7be20bcc6137..d247bf945f16 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -33,8 +33,8 @@
  * at least 9 bytes and will always be zero terminated.
  *
  */
-void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
-		     char *buf, int len)
+int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
+		    char *buf, int len)
 {
 	static const char *const units_10[] = {
 		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
@@ -127,8 +127,7 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	else
 		unit = units_str[units][i];
 
-	snprintf(buf, len, "%u%s %s", (u32)size,
-		 tmp, unit);
+	return snprintf(buf, len, "%u%s %s", (u32)size, tmp, unit);
 }
 EXPORT_SYMBOL(string_get_size);
 
-- 
2.35.1

