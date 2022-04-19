Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B26C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 00:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbiDSAqO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C1B21E2A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46599613E2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A19C385D8;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=4wdTW/ATqBPa+Y50ldF5wO/O2ikho0Gb+MhgDDS0lK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oF1f4WZjON0KxFJLtuU5Nby4hQtxx4ted4rEKbMcpN+aV/nBWlwkVdszguPISWJyP
         iZqmDg4kHzw60MR5BMd/RPLCGFcZsMbo7Y7Yel16VcWSfqeM7Z42z7cftP8ySASDzj
         ++zBqOKEQBCHBI9aB+KzEeWujM6eztUP+ktYvPq1g4JFw6DwUmMRQ4fWyV1IwPB76u
         d1qKADcqFb1lzJh3gNw7ywuICaCDxlZmPRsxP+Yy3b0JsVFm51vazW8VI8gUVFovI8
         WdsMAOUGeGcMZQ0UPUprOrMmPLPcSusISC3/YXuvpG0H1d8WTr/uAFtxtqfrjeaSbB
         O52uTmtXD0D9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3C2475C3100; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 29/61] tools/nolibc/string: slightly simplify memmove()
Date:   Mon, 18 Apr 2022 17:41:53 -0700
Message-Id: <20220419004225.3952530-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The direction test inside the loop was not always completely optimized,
resulting in a larger than necessary function. This change adds a
direction variable that is set out of the loop. Now the function is down
to 48 bytes on x86, 32 on ARM and 68 on mips. It's worth noting that other
approaches were attempted (including relying on the up and down functions)
but they were only slightly beneficial on x86 and cost more on others.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
 	}
-	return ret;
+
+	while (len) {
+		pos += dir;
+		((char *)dst)[pos] = ((const char *)src)[pos];
+		len--;
+	}
+	return dst;
 }
 
 /* must be exported, as it's used by libgcc on ARM */
-- 
2.31.1.189.g2e36527f23

