Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18E6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 11:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiCCLeW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A217CC56
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pvJTiNP5ceLdw6/edn6fcpO+Sqt+miAq8Ka0H1NrBcI=; b=H/Btv6NqLwBX5EAGyhKlL4qSy1
        7impNalefrL1EVsltTaz4fRqP+kFI7CgXC3GMJ1R/sI2ZH/y49D2RG8j/8t7Ak4aMyL8TZf1g4HY1
        dC5yd3Z4xes3fzY579V5OKNe9ugL/a8r4GaVoqR4ix2AwvKSYxsS400VXKwlU/jmoIpvnfB0k4F2P
        v2QObjMTnMuhutM534vIp6WyIwm5f/AycresokaXA2QiOumVVOOiboJuILDIYHElZx2i6nSRjB8AS
        kJs4rNINYsUFiXyGngdigH6s9jfZNUchd5Ptsra9bysjKG7lAnu4lcJxn7BnBp/i5N5wBpagaCw4B
        FpP9JByg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjei-00Etpr-0g; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 115F1302DC3;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9FAB63012B080; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112827.029502185@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 34/39] objtool: Have WARN_FUNC fall back to sym+off
References: <20220303112321.422525803@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently WARN_FUNC() either prints func+off and failing that prints
sec+off, add an intermediate sym+off. This is useful when playing
around with entry code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/include/objtool/warn.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -22,6 +22,8 @@ static inline char *offstr(struct sectio
 	unsigned long name_off;
 
 	func = find_func_containing(sec, offset);
+	if (!func)
+		func = find_symbol_containing(sec, offset);
 	if (func) {
 		name = func->name;
 		name_off = offset - func->offset;


