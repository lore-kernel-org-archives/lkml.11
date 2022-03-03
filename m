Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D378DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 11:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiCCLcx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiCCLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683C17BC6F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0GRAegTdgi3auRe/t63t5h8YTp9nrb+yNH0x1eayzck=; b=UtezQ/nvefmRflenx/sb6adANO
        aOOSp2p1LkEYJAb26JuVjc9wDe25bgDYzhkvtdWj1oKq3W8HAf8ew6o/6GSRyAI1uPVbMxSTRc2eY
        iQH1J3kSHFu2VRe3nBgBQbhDFd9KSZMcs8hkwSwr7kl4NKfHJPSWkN+aQa4n7uizUSPkMupmc0yEE
        03/mu6ZzRsnKXt1IvwNqT/0DqIisBRR1QhRRitHa19ma0krPcvZ2DqlqdlYU4wdIyU4zO+iwSYz/0
        i9xRg6h8kGGxyptkaqKVNXwmXJd+9vF8a9XcyLafzTULSSyvV5w275xX0EPUQG46XBIGZ6ZloGt+G
        6+v+qcXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjef-00EtpN-Eg; Thu, 03 Mar 2022 11:29:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62E633005BA;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 16A39300116F4; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.008114028@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 01/39] static_call: Avoid building empty .static_call_sites
References: <20220303112321.422525803@infradead.org>
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


