Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174BEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 15:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbiBXPUw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiBXPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A015FC89
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cWrUD1KaL9aYwAdkiMBL/v8TI8q3NHQ2xjsiReq0bIM=; b=itfeLqVFCdBZnZOoM6qb7C4gF5
        gepquT8g/K3lWeW1YTUXq635XqsIPi32CxxbSWz3D1kN/C+n+E0ANcWnIEy0E6h+woVMN1hCA9TCp
        ugpejuViBgSd//aNNa0FHx5q8xT43KUCsJoaYC2s8Fs4HWJRRD6LxGpDBOKzeBzvL+nH4hTDH0T03
        hM53lD6OwPILSAzg3baowPHkmudvtACJAFLVvW4ol/QqbH2kileW88Nam+Myj5DcsVOYTmIRsbPLY
        RFjnj72TPOuDx7aAZwjseCut43myfubWtsm+qPYoUdD2+U9ei0TCiu+H1/AvSEW2KTpKDCqa0kBsG
        FY21usdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs4-004s2G-0a; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CD26302D58;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9C8AB2B3547A7; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151323.900519401@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 32/39] x86/ibt: Dont generate ENDBR in .discard.text
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having ENDBR in discarded sections can easily lead to relocations into
discarded sections which the linkers aren't really fond of. Objtool
also shouldn't generate them, but why tempt fate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/setup.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -8,6 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/page_types.h>
+#include <asm/ibt.h>
 
 #ifdef __i386__
 
@@ -119,7 +120,7 @@ void *extend_brk(size_t size, size_t ali
  * executable.)
  */
 #define RESERVE_BRK(name,sz)						\
-	static void __section(".discard.text") __used notrace		\
+	static void __section(".discard.text") __noendbr __used notrace	\
 	__brk_reservation_fn_##name##__(void) {				\
 		asm volatile (						\
 			".pushsection .brk_reservation,\"aw\",@nobits;" \


