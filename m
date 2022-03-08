Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7116C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 19:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349540AbiCHT31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349531AbiCHT3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:29:24 -0500
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Mar 2022 11:28:25 PST
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1552E6A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:28:25 -0800 (PST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id B18F3F418F8; Tue,  8 Mar 2022 20:18:29 +0100 (CET)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Subject: [PATCH] ARM: fix compilation error when BPF_SYSCALL is disabled
Date:   Tue,  8 Mar 2022 20:18:20 +0100
Message-Id: <20220308191820.18270-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was missing a semicolon.

Fixes build error introduced in
25875aa71dfefd1959f07e626c4d285b88b27ac2.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/arm/kernel/spectre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/spectre.c b/arch/arm/kernel/spectre.c
index e7fea962d632..0dcefc36fb7a 100644
--- a/arch/arm/kernel/spectre.c
+++ b/arch/arm/kernel/spectre.c
@@ -10,7 +10,7 @@ static bool _unprivileged_ebpf_enabled(void)
 #ifdef CONFIG_BPF_SYSCALL
 	return !sysctl_unprivileged_bpf_disabled;
 #else
-	return false
+	return false;
 #endif
 }
 
-- 
2.35.1

