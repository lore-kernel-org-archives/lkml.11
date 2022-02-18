Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 17:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbiBRRQG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:16:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbiBRRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF934C7B3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0GRAegTdgi3auRe/t63t5h8YTp9nrb+yNH0x1eayzck=; b=CEvOfsf1MVCAY4XfooourffxMj
        VHvJRdWXdN6KHXYPUWM9P7EQf/iKRZxyrjNlMW91BK6dRgo57uwB6kRwvj43IJ2gqKHSa0H1nEPWw
        8n/IMSbv1Ej/BRBWlH62XxbuBuiGzCgk1/YQK375sOjevVWfv+8ypfzgLoRs6+5axlMEo74BRzmBq
        vR3EHK16KYmiyf1wXVuGXGos7yR9so0lM2I16f3ZIHk7ADIfp064+HtosyYGXws6elZboGH/8mXj7
        9QjuvRgBGPcwMo0CEPDyQSJYVLPL3iYXlOO9pvTgFcJXEodiMrG3lf3lAySAbm+O4LaAZgvSphZjc
        Jqxm8xow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6q9-00Gl8S-62; Fri, 18 Feb 2022 17:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4534E3005A3;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 04624203C1C7F; Fri, 18 Feb 2022 18:14:38 +0100 (CET)
Message-ID: <20220218171408.633523348@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 01/29] static_call: Avoid building empty .static_call_sites
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_HAVE_STATIC_CALL_INLINE there's no point in creating
the .static_call_sites section and it's related symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/vmlinux.lds.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -398,6 +398,7 @@
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 #define STATIC_CALL_DATA						\
 	. = ALIGN(8);							\
 	__start_static_call_sites = .;					\
@@ -406,6 +407,9 @@
 	__start_static_call_tramp_key = .;				\
 	KEEP(*(.static_call_tramp_key))					\
 	__stop_static_call_tramp_key = .;
+#else
+#define STATIC_CALL_DATA
+#endif
 
 /*
  * Allow architectures to handle ro_after_init data on their


