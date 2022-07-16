Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBDFC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 10:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiGPKRE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jul 2022 06:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGPKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 06:17:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A291F606;
        Sat, 16 Jul 2022 03:17:01 -0700 (PDT)
Date:   Sat, 16 Jul 2022 10:16:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657966619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=03rJrkcm4eRexferty6ACY8Inioj54wnKeQjgCXIcls=;
        b=Vu9MhKB4PCtnzUOXR4ILMp01toVOKH69SJUkCdOGBmykhX81F2k0yGlPuA0wjGW2+5K1VE
        JG+lETVh0YbGlYk+V5dU/LKdPkDyAO4nhVMVmnZsYVI6ukOaQLrJqqV8BxdYN2tdf0JIYn
        ogLTwB/7f5nyOhgWnYKKD7OPQkacpISTNJ8TwZvqPxXLQsMs6o2iLnSanl4bd/tz1E9c6c
        dry2x69n9mf/wOSvQBsSag0qGKZXiNQME3iEZ4OWCrX7nLxFoghM3bptpcYam43IkBOklV
        k3w9SzXBLLaqg/iwhkk+K/g/9enc3THZQ9BR62XBhS5rE1VN7S2J2Py+LRYvQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657966619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=03rJrkcm4eRexferty6ACY8Inioj54wnKeQjgCXIcls=;
        b=qdg/3BoBedHbK35QvH4p7AlrF3JWJ+VopY+fwg4mKWoM6Apavm7NGM1YqDJfNwhYcwJclo
        LfM7rOwpgni/40AQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Remove apostrophe typo
Cc:     Kim Phillips <kim.phillips@amd.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <165796661764.15455.12429701839910697115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bcf163150cd37348a0cb59e95c916a83a9344b0e
Gitweb:        https://git.kernel.org/tip/bcf163150cd37348a0cb59e95c916a83a9344b0e
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Fri, 08 Jul 2022 16:21:28 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 16 Jul 2022 11:39:23 +02:00

x86/bugs: Remove apostrophe typo

Remove a superfluous ' in the mitigation string.

Fixes: e8ec1b6e08a2 ("x86/bugs: Enable STIBP for JMP2RET")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3a0787a..aa34f90 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1181,7 +1181,7 @@ spectre_v2_user_select_mitigation(void)
 	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET) {
 		if (mode != SPECTRE_V2_USER_STRICT &&
 		    mode != SPECTRE_V2_USER_STRICT_PREFERRED)
-			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation'\n");
+			pr_info("Selecting STIBP always-on mode to complement retbleed mitigation\n");
 		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
 	}
 
