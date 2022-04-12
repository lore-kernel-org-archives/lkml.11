Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7009DC352A8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359130AbiDLJ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356549AbiDLIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:10:42 -0400
X-Greylist: delayed 95 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 00:41:52 PDT
Received: from outback3o.mail.yandex.net (outback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::503])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90381F3F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:41:52 -0700 (PDT)
Received: from sas1-ad1836f4152f.qloud-c.yandex.net (sas1-ad1836f4152f.qloud-c.yandex.net [IPv6:2a02:6b8:c08:793:0:640:ad18:36f4])
        by outback3o.mail.yandex.net (Yandex) with ESMTP id 8A5E51D1693E;
        Tue, 12 Apr 2022 10:40:16 +0300 (MSK)
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas1-ad1836f4152f.qloud-c.yandex.net (yaback/Yandex) with ESMTP id YxpBSLFY7v-eFOGpDVi;
        Tue, 12 Apr 2022 10:40:15 +0300
X-Yandex-Fwd: 1
Authentication-Results: sas1-ad1836f4152f.qloud-c.yandex.net; dkim=pass
Received: by kernel1.search.yandex.net (Postfix, from userid 55271)
        id 6C6035068E2; Tue, 12 Apr 2022 10:40:15 +0300 (MSK)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, mingo@redhat.com,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH 2/2] x86/unwind/orc: Fix address check size for deref_stack_iret_regs
Date:   Tue, 12 Apr 2022 10:40:04 +0300
Message-Id: <1649749204-186363-2-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For historical reasons we check only IRET_FRAME_OFFSET, but this check
is no longer valid because  we also access regs->sp field which is
located beyond IRET_FRAME, so it is reasonable to validate full structure.

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 80b878772b86..a249ecabe689 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -379,7 +379,7 @@ static bool deref_stack_iret_regs(struct unwind_state *state, unsigned long addr
 {
 	struct pt_regs *regs = (void *)addr - IRET_FRAME_OFFSET;
 
-	if (!stack_access_ok(state, addr, IRET_FRAME_SIZE))
+	if (!stack_access_ok(state, addr, sizeof(struct pt_regs)))
 		return false;
 
 	*ip = READ_ONCE_NOCHECK(regs->ip);
-- 
2.7.4

