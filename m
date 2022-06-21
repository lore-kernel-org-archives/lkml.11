Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A505CC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 10:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348685AbiFUK0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348627AbiFUK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:26:45 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 03:26:43 PDT
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA428726
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:26:43 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4LS2by14Kczvjfm; Tue, 21 Jun 2022 12:21:18 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: remove unused mm_copy_segments
Date:   Tue, 21 Jun 2022 12:21:18 +0200
Message-Id: <20220621102118.15803-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was already removed by commit c17c02040bf0 ("arch: remove unused
*_segments() macros/functions") but seems to have been accidentally
reintroduced by commit 0500871f21b2 ("Construct init thread stack in the
linker script rather than by union"). Remove it for good.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/um/include/asm/processor-generic.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 6a4fe8b4e686..d0fc1862da95 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -59,11 +59,6 @@ static inline void release_thread(struct task_struct *task)
 {
 }
 
-static inline void mm_copy_segments(struct mm_struct *from_mm,
-				    struct mm_struct *new_mm)
-{
-}
-
 /*
  * User space process size: 3GB (default).
  */
-- 
2.36.1

