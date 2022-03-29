Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C438C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 10:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiC2KUo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 06:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiC2KT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:56 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494482414D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:18:09 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id EE7447E726;
        Tue, 29 Mar 2022 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549088;
        bh=IyJY9APPUs2Jm0t28TfIT9sgV0eTR+GH3x1eZDSz5/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARsHG3hF9MVFev9wunSZZCkONyT2C3efkgmQmEfQ17AauzFAyNh5n6IGVNXurrPuL
         raOclWhgZam5LbHBvWzkIhC7PiQihr5Gfk/cS8/kye//ks3z7KLCcw75x9oTwRgKYx
         OVbzvFKJLNLeujgAkd7UInBvvf9mNxM/S2fI0Wx5JNrvz8i6TQZnSD5baSqai+Zsqq
         PgvX0OMI4RQzumlV+A3McOE3YuPD+IkOVwetPEA+0QcJZyYeRWoa6AXS13185vu77a
         pSsxcI5kTT91EjcGEwOVxqiO+0Ebgvg4EveGwERp0v5KzS65VEgEqm4LnirTrw8XSu
         4n76w7yxbG68Q==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v2 6/9] tools/nolibc/types: Implement `offsetof()` and `container_of()` macro
Date:   Tue, 29 Mar 2022 17:17:34 +0700
Message-Id: <20220329101737.58985-7-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement `offsetof()` and `container_of()` macro. The first use case
of these macros is for `malloc()`, `realloc()` and `free()`.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
===
@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-9-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    * No changes *

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-6-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    * No changes *

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 357e60ad38a8..959997034e55 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -191,4 +191,15 @@ struct stat {
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
 #define minor(dev) ((unsigned int)(((dev) & 0xff))
 
+#ifndef offsetof
+#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
+#endif
+
+#ifndef container_of
+#define container_of(PTR, TYPE, FIELD) ({			\
+	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\
+	(TYPE *)((char *) __FIELD_PTR - offsetof(TYPE, FIELD));	\
+})
+#endif
+
 #endif /* _NOLIBC_TYPES_H */
-- 
Ammar Faizi

