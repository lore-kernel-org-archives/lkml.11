Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE1ECAAD3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 00:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiH3A51 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 20:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiH3A5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 20:57:11 -0400
Received: from linux.gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683D895D7;
        Mon, 29 Aug 2022 17:57:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [68.183.184.174])
        by linux.gnuweeb.org (Postfix) with ESMTPSA id 3240C374EFE;
        Tue, 30 Aug 2022 00:57:03 +0000 (UTC)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Caleb Sander <csander@purestorage.com>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH liburing v2 5/7] man: Alias `io_uring_enter2()` to `io_uring_enter()`
Date:   Tue, 30 Aug 2022 07:56:41 +0700
Message-Id: <20220830005122.885209-6-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830005122.885209-1-ammar.faizi@intel.com>
References: <20220830005122.885209-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

We have a new function io_uring_enter2(), add the man page entry for it
by aliasing it to io_uring_enter(). The aliased man entry has already
explained it.

Cc: Caleb Sander <csander@purestorage.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 man/io_uring_enter2.2 | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 man/io_uring_enter2.2

diff --git a/man/io_uring_enter2.2 b/man/io_uring_enter2.2
new file mode 120000
index 0000000..5566c09
--- /dev/null
+++ b/man/io_uring_enter2.2
@@ -0,0 +1 @@
+io_uring_enter.2
\ No newline at end of file
-- 
Ammar Faizi

