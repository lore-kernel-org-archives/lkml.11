Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A568DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 13:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiCLNiq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 08:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:38:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19734FC6A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:37:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC670CE0AC8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 13:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF52C340EE;
        Sat, 12 Mar 2022 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647092256;
        bh=X/zhcuPARtS2RBxWYzKuWywppQAoJVDBd5mUibA8Ji4=;
        h=Date:From:To:Cc:Subject:From;
        b=ajdgaoBdi5LrVd/J88gU0opx2womct1lz8KT+KJdUtepgN/h5Huo/D0ewv5JzatOU
         YckhO1V2iYJ/+6HStepRmWzwp5vmhsmXD3QBvQgfKi9W8rEShiTJ3pMB0U+PxVlEQR
         lcWYAieA931GIjgGjojTtkRSgBzI1Vi1Lb3hYyQp5CAiYw7TEivmwAoa7Xr/yM5Ilk
         H3kxLIgpIZ1IfzaWxT0RnMUg2AXeD1xmxTKRUG88dye4hqg+G23P75BIk3a9mkea0h
         SxKUj+L1UOlIMQs+rxfa9jT2y8BfWgBcbnNaUYFJlANrvLkMF7Qx/GCWtkoid3WCAy
         S3GEUB2iRplQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17B34403C8; Sat, 12 Mar 2022 10:37:33 -0300 (-03)
Date:   Sat, 12 Mar 2022 10:37:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools headers cpufeatures: Sync with the kernel sources
Message-ID: <YiyiHatGaJQM7l/Y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I'm carrying this on the perf tools tree,

Regards,

- Arnaldo

---

To pick the changes from:

  d45476d983240937 ("x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFENCE")

Its just a comment fixup.

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ab4e53715d8ad8ae..65d147974f8d95e6 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -204,7 +204,7 @@
 /* FREE!                                ( 7*32+10) */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
 #define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCEs for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCE for Spectre variant 2 */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
 #define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
 #define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
-- 
2.35.1

