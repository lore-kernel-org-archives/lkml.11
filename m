Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DBC43219
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377698AbiBGQaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382045AbiBGQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:25:53 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 08:25:51 PST
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 346D9C0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:25:50 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOfTp014422;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 38/42] tools/nolibc/unistd: add usleep()
Date:   Mon,  7 Feb 2022 17:23:50 +0100
Message-Id: <20220207162354.14293-39-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This call is trivial to implement based on select() to complete sleep()
and msleep(), let's add it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/unistd.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 87b448ff2191..1c25e20ee360 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -37,6 +37,14 @@ unsigned int sleep(unsigned int seconds)
 		return 0;
 }
 
+static __attribute__((unused))
+int usleep(unsigned int usecs)
+{
+	struct timeval my_timeval = { usecs / 1000000, usecs % 1000000 };
+
+	return sys_select(0, 0, 0, 0, &my_timeval);
+}
+
 static __attribute__((unused))
 int tcsetpgrp(int fd, pid_t pid)
 {
-- 
2.35.1

