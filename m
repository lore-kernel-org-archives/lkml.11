Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED9ECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiHaS1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiHaSZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAEDF325E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D96EFB82289
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E2FC4315B;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=kvIGUGvWGjbnatoeWWWTTFZH4v3qpwz0HmIzMW+k0bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMco6OtjNymKmvXqe4YO3uA2mhCo1vVXYbahavRhIjVb+2ZDbdtsG2T/x+3G3rDoi
         S1aoqaqmRwvSOps2WbWSv1x0kVu+RxCryZS5HbCadxXXpNjom4zqU39BI/HTjTAHzT
         GbkqpBy1iRqYLI6Eg7+vw+Kv279nEeTvWEHfmYjNXCP0t71SKO3zKRtxF5UkwSJaCn
         EPk19OwY3aq7DBmig38IOwtbagy/h30wicniiChKPtKRe/sY98Ur2KrJ9s6szrrsOf
         De4qUP8TOBkUnLXbW3dvPUs4XZj4aOMM37ynYvsJNbEjWX880Qhog3HqJDWiKariR4
         PWSdRux+59RBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F24275C0EAC; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Fernanda Ma'rouf <fernandafmr2@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 18/18] selftests/nolibc: Avoid generated files being committed
Date:   Wed, 31 Aug 2022 11:21:48 -0700
Message-Id: <20220831182148.2698489-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>

After running the nolibc tests, the "git status" is not clean because
the generated files are not ignored. Create a `.gitignore` inside the
selftests/nolibc directory to ignore them.

Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Fernanda Ma'rouf <fernandafmr2@gmail.com>
Signed-off-by: Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/.gitignore

diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
new file mode 100644
index 0000000000000..4696df589d68e
--- /dev/null
+++ b/tools/testing/selftests/nolibc/.gitignore
@@ -0,0 +1,4 @@
+/initramfs/
+/nolibc-test
+/run.out
+/sysroot/
-- 
2.31.1.189.g2e36527f23

