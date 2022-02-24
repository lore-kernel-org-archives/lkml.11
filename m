Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D742C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 15:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiBXPSn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiBXPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8348144F40
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0GRAegTdgi3auRe/t63t5h8YTp9nrb+yNH0x1eayzck=; b=gEnnCA4LkdGpaiBOUBx5uvctSM
        hA18IdgDuH1l+O9WKKRyfjdW1TP7vt5doa0927zINmAr73ACwuguCoVIE33u9pOdivJhGbCS/m8Bs
        TRdwNIyoWOc1dtqnlanlEqdO7wcnN53lVjKgeV53DgiB2ActM77Z5NFh/Hi/TjlQo24c5eM2GU5UI
        BWhLByNeQLhDaQyJ0HQNam2IhjmjFBV7DqOwrMp0X68jbV47lmVYUENKwYjcSdjz5wCbu5e1NPqgo
        D+/scCjnqxubV7w3KPmJZGvsV89cvAx8JquGval9Hr0htK5tV/ZZYwQwUk4tQ21TAK+IOecsZUV/9
        XcNgduNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs2-004s1n-K0; Thu, 24 Feb 2022 15:17:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62142300483;
        Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2229629E75E4B; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.130666048@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 02/39] static_call: Avoid building empty .static_call_sites
References: <20220224145138.952963315@infradead.org>
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


