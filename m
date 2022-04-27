Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 17:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiD0RfM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbiD0Rez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:34:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FBFC1DFE48
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D2001477;
        Wed, 27 Apr 2022 10:31:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C48B73F73B;
        Wed, 27 Apr 2022 10:31:39 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 03/13] stackleak: remove redundant check
Date:   Wed, 27 Apr 2022 18:31:18 +0100
Message-Id: <20220427173128.2603085-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427173128.2603085-1-mark.rutland@arm.com>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __stackleak_erase() we check that the `erase_low` value derived from
`current->lowest_stack` is above the lowest legitimate stack pointer
value, but this is already enforced by stackleak_track_stack() when
recording the lowest stack value.

Remove the redundant check.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/stackleak.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 753eab797a04d..f7a0f8cf73c37 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -78,10 +78,6 @@ static __always_inline void __stackleak_erase(void)
 	unsigned int poison_count = 0;
 	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
 
-	/* Check that 'lowest_stack' value is sane */
-	if (unlikely(kstack_ptr - boundary >= THREAD_SIZE))
-		kstack_ptr = boundary;
-
 	/* Search for the poison value in the kernel stack */
 	while (kstack_ptr > boundary && poison_count <= depth) {
 		if (*(unsigned long *)kstack_ptr == STACKLEAK_POISON)
-- 
2.30.2

