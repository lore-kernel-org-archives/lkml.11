Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C2FC00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 11:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiHHLkg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbiHHLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:40:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCAA5F5F;
        Mon,  8 Aug 2022 04:40:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.46.64.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F42F6601C28;
        Mon,  8 Aug 2022 12:40:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659958826;
        bh=Mz0RDPA7p3Dfvp3I4U1fgB3B0KKGWXSWNIX3BZgcrBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzWwD1wcxrwuIt0Octlu4Ol2iu4SmNmMWwgoYoRkmqZF9DCWk0SljRkPp4fvTD/e5
         4DaopepsJDHllgckmzAn8MVF8Ep2BL/vI0ssgZD0ho41Pu906GWA2ceZvvFdDRMBM4
         NGaksFFVLjyBZgcHDmA8NFkzlgv0fXoznA7IN5aQMHlxp/cSVVZJoBRM1+yUXOQXBg
         t1zQ21gD5f0Q9p+nAif9g8EgKGhbOO2L+URXd7jo16LH8CXFn4KzZoYMrdcah9Pi1A
         sGsBKCZ6GL/h7Kcn4PXAnxgswwvTVefHu0IzVltTS/9JfVF6eHqFgMb+GLo9LYGaWz
         jhSZksmzqyDxw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     Steven Noonan <steven@uplinklabs.net>, usama.anjum@collabora.com,
        kernel@collabora.com
Subject: [PATCH 3/3] x86/tsc: don't check for random warps if using direct sync
Date:   Mon,  8 Aug 2022 16:39:54 +0500
Message-Id: <20220808113954.345579-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808113954.345579-1-usama.anjum@collabora.com>
References: <20220808113954.345579-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Noonan <steven@uplinklabs.net>

There's some overhead in writing and reading MSR_IA32_TSC. We try to
account for it. But sometimes overhead gets under or over estimated.
When we retry syncing, it sees the clock "go backwards". Hence,
ignore random wrap if using direct sync.

Signed-off-by: Steven Noonan <steven@uplinklabs.net>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 arch/x86/kernel/tsc_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 2a855991f982..1fc751212a0e 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -405,7 +405,7 @@ void check_tsc_sync_source(int cpu)
 		pr_debug("TSC synchronization [CPU#%d -> CPU#%d]: passed\n",
 			smp_processor_id(), cpu);
 
-	} else if (atomic_dec_and_test(&test_runs) || random_warps) {
+	} else if (atomic_dec_and_test(&test_runs) || (random_warps && !tsc_allow_direct_sync)) {
 		/* Force it to 0 if random warps brought us here */
 		atomic_set(&test_runs, 0);
 
-- 
2.30.2

