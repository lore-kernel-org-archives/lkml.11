Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AEDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 03:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiGTDhv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 23:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiGTDht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:37:49 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23948491D7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:37:47 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26K3bjpU003140;
        Wed, 20 Jul 2022 05:37:45 +0200
Date:   Wed, 20 Jul 2022 05:37:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH nolibc v1] selftests/nolibc: Avoid generated files being
 committed
Message-ID: <20220720033745.GC3106@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>

After running the nolibc tests, the "git status" is not clean because
the generated files are not ignored. Create a `.gitignore` inside the
selftests/nolibc directory to ignore them.

Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Fernanda Ma'rouf <fernandafmr2@gmail.com>
Signed-off-by: Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---

Paul,

Fernanda sent me this which I think is a desirable cleanup to the
series I sent you. If you're fine with adding it on top of what you
already have, that's great. Otherwise I can queue it here for next
time, but this should improve the user's experience.

Thanks,
Willy

--
 tools/testing/selftests/nolibc/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/.gitignore

diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
new file mode 100644
index 000000000000..4696df589d68
--- /dev/null
+++ b/tools/testing/selftests/nolibc/.gitignore
@@ -0,0 +1,4 @@
+/initramfs/
+/nolibc-test
+/run.out
+/sysroot/

base-commit: 1e93ece89dd1c6217b92ef6fc100df9ba202c30c
