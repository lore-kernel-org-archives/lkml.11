Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB96C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiEXSxt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 14:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbiEXSxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:53:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A9857B01
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:53:33 -0700 (PDT)
Received: from zn.tnic (p200300ea974657c6329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57c6:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22FE81EC0622;
        Tue, 24 May 2022 20:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653418412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2M9QqqRLgX47depXRiMTQ6cBUd+HXGc9LcO2mQh+QJw=;
        b=SmoLtmPmAbF13I1yW9wrv0Q5YztH/n6IHFGKodaR7ouySLSF1qc4J87FrytACnl2rt1Bjo
        vBaomNdkeCq8Du2G1gBXSLtAx18DTBvW7AN4Bd0cyEHg5jGZUXLfhYuuHZXUmdQw00DIfq
        TMibL4vCNCKDJVm0M40jzZCVFChWi+Y=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Date:   Tue, 24 May 2022 20:53:24 +0200
Message-Id: <20220524185324.28395-4-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524185324.28395-1-bp@alien8.de>
References: <20220524185324.28395-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Warn when done and taint the kernel.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c717db6b6856..f7ded2facaa0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -501,6 +501,8 @@ static int microcode_reload_late(void)
 		microcode_check();
 
 	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
+	pr_err("However, late loading is dangerous and it taints the kernel.\n"
+	       "You should switch to early loading, if possible.\n");
 
 	return ret;
 }
@@ -541,6 +543,8 @@ static ssize_t reload_store(struct device *dev,
 	if (ret == 0)
 		ret = size;
 
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 	return ret;
 }
 
-- 
2.35.1

