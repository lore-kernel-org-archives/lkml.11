Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC826C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 28 May 2022 15:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiE1PqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 May 2022 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiE1PqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:46:15 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3157186C0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:46:14 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24SFjqm4008308;
        Sat, 28 May 2022 17:45:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/3] tools/nolibc: make the default target build the headers
Date:   Sat, 28 May 2022 17:45:45 +0200
Message-Id: <20220528154546.8261-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220528154546.8261-1-w@1wt.eu>
References: <20220528154546.8261-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help in "make -C tools" enumerates nolibc as a valid target so we
must at least make it do something. Let's make it do the equivalent
of "make headers" in that it will prepare a sysroot with the arch's
headers, but will not install the kernel's headers. This is the
minimum some tools will need when built with a full-blown toolchain
anyway.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/Makefile                | 3 +++
 tools/include/nolibc/Makefile | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/Makefile b/tools/Makefile
index c074e42fd92f..e497875fc7e3 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -78,6 +78,9 @@ bpf/%: FORCE
 libapi: FORCE
 	$(call descend,lib/api)
 
+nolibc: FORCE
+	$(call descend,include/nolibc)
+
 nolibc_%: FORCE
 	$(call descend,include/nolibc,$(patsubst nolibc_%,%,$@))
 
diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index e8bac6ef3653..9768819abd55 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -29,7 +29,7 @@ all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
              sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
-all:
+all: headers
 
 # Note: when ARCH is "x86" we concatenate both x86_64 and i386
 headers:
-- 
2.17.5

