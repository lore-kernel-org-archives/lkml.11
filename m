Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA20CC35273
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 16:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388555AbiBGQaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242367AbiBGQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:14 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE3E5C0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:13 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOexf014412;
        Mon, 7 Feb 2022 17:24:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 29/42] tools/nolibc/string: slightly simplify memmove()
Date:   Mon,  7 Feb 2022 17:23:41 +0100
Message-Id: <20220207162354.14293-30-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The direction test inside the loop was not always completely optimized,
resulting in a larger than necessary function. This change adds a
direction variable that is set out of the loop. Now the function is down
to 48 bytes on x86, 32 on ARM and 68 on mips. It's worth noting that other
approaches were attempted (including relying on the up and down functions)
but they were only slightly beneficial on x86 and cost more on others.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 6d8fad7a92e6..b831a02de83f 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -50,14 +50,22 @@ void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
 static __attribute__((unused))
 void *memmove(void *dst, const void *src, size_t len)
 {
-	ssize_t pos = (dst <= src) ? -1 : (long)len;
-	void *ret = dst;
+	size_t dir, pos;
 
-	while (len--) {
-		pos += (dst <= src) ? 1 : -1;
-		((char *)dst)[pos] = ((char *)src)[pos];
+	pos = len;
+	dir = -1;
+
+	if (dst < src) {
+		pos = -1;
+		dir = 1;
+	}
+
+	while (len) {
+		pos += dir;
+		((char *)dst)[pos] = ((const char *)src)[pos];
+		len--;
 	}
-	return ret;
+	return dst;
 }
 
 /* must be exported, as it's used by libgcc on ARM */
-- 
2.35.1

