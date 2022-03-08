Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 15:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348037AbiCHP5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348053AbiCHP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031624F9D8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JWR1Jvatd2wRq94EgF2FFUHDrJsSm4yXOI7jdL4Xcs4=; b=RAuVSgYkc64ZPvBoryhP2e1q75
        nzGLiFM2O3pDGyI5dv+RAcq2Ldf8vkkfwyE2351g5KyobLe84eD3IvAgXlx9axF6jsmIaqbFwb0y0
        V5ssyAbKnH7RNKWi/nGXZg4UFtl6yfyJrEW31IfEm6OKimJVnMZkT+4Iza2sr3/5SKwJPCJM0LPRo
        n9fUBQu7WDTSQwmQH6nPQl74nLKO6H8R2tXrOepao0wwNwNlCPBt6RPJdq+JHsBxiBr+H6WnrCTqA
        DwG4PQuK5Y0NUI/VW9ofjY6Je0FZAs2HycBalJmwwiHe81qMoYEliQLHofj1/5YDawa/HcgNSib1Q
        nqp/hC2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUie-T3; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B1EE302DD0;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AA1D12B5649C7; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154319.113767246@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 33/45] x86/ibt: Ensure module init/exit points have references
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the references to the module init/exit points only have external
references, a module LTO run will consider them 'unused' and seal
them, leading to an immediate fail on module load.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cfi.h |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -34,8 +34,17 @@ static inline void cfi_module_remove(str
 
 #else /* !CONFIG_CFI_CLANG */
 
-#define __CFI_ADDRESSABLE(fn, __attr)
+#ifdef CONFIG_X86_KERNEL_IBT
+
+#define __CFI_ADDRESSABLE(fn, __attr) \
+	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
+
+#endif /* CONFIG_X86_KERNEL_IBT */
 
 #endif /* CONFIG_CFI_CLANG */
 
+#ifndef __CFI_ADDRESSABLE
+#define __CFI_ADDRESSABLE(fn, __attr)
+#endif
+
 #endif /* _LINUX_CFI_H */


