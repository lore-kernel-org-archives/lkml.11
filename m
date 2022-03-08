Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D200DC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 15:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbiCHP4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348036AbiCHP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0304F9C7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Xm+VnMqRo0gjToa7sjG6D3f0R53zHIXwGGB+mwk/gHI=; b=QWRD8oqmXuqeSl7wzEN/pCjsGH
        ty843znvlXWhCxHIeFffsV6VwjedKBHxMrip5W8NrY+YHYMmJPs/iUvvYq1SzKioj3IpFfkDhrkts
        TuL8tCo5Umsg83CgXeosmRKEO2m8wuYB8PmKpnRy6StYbIMPOb/ADS/kh1UuDvLD0+WdssKFBbws2
        EeqEA6Sdt08xW+5m2O8vmQpZoh+Eyonss9bWgeDhFq5bVHKtPDy0Vd341zTt8TH3pwEtqVfusfZQD
        ZFmgRLyGSRasY16KHoKgNcMfdXWAs84xc/ej7wZxvBX+mmylpit5iYRPQ0iLKT8FmCT2x1eZdLRJT
        WoA/Oj7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAb-00GIun-G0; Tue, 08 Mar 2022 15:54:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBD59300750;
        Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BDDFB2B55FFB9; Tue,  8 Mar 2022 16:54:38 +0100 (CET)
Message-ID: <20220308154317.343312938@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 03/45] objtool: Default ignore INT3 for unreachable
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore all INT3 instructions for unreachable code warnings, similar to NOP.
This allows using INT3 for various paddings instead of NOPs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3342,9 +3342,8 @@ static int validate_branch(struct objtoo
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (next_insn && next_insn->type == INSN_TRAP) {
-				next_insn->ignore = true;
-			} else if (sls && !insn->retpoline_safe) {
+			if (sls && !insn->retpoline_safe &&
+			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after ret",
 					  insn->sec, insn->offset);
 			}
@@ -3391,9 +3390,8 @@ static int validate_branch(struct objtoo
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (next_insn && next_insn->type == INSN_TRAP) {
-				next_insn->ignore = true;
-			} else if (sls && !insn->retpoline_safe) {
+			if (sls && !insn->retpoline_safe &&
+			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after indirect jump",
 					  insn->sec, insn->offset);
 			}
@@ -3567,7 +3565,7 @@ static bool ignore_unreachable_insn(stru
 	int i;
 	struct instruction *prev_insn;
 
-	if (insn->ignore || insn->type == INSN_NOP)
+	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP)
 		return true;
 
 	/*


