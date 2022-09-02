Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EBECAAD5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 14:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiIBO2b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiIBO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC6F145C55
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i3Uz19PgVRfZIUacrE/ZrBQkKie5hxegnp8/5GnSRe0=; b=CvLdc8+8GZmSFm4gLwiOwmrHci
        xBUm8kMJl8ycTLFvH3Bik6Eko1xvJbJyQjV/dprYAuVLqGK6p+ZOI79jK6IAQx0cDxfum1Fx8WEC6
        3Swr9pVmuSLrh5FRAg0r1fUWX5uA6vtplHyz4J7KjtmLoHzj5UioY9Q7Qov1oajhnQDYH8HbATqw4
        0YbDwzjX6czeg0XOXrMm0V5NZsz+uBfL70wOnZAOtV3d5KDtEU5mj3o5rtjE0XO9C5O9i5sfTnuU3
        4OyEey/C9Gmmtj+qd7SWBQr+dbIhBQMZcIFFr1Y8vZbcKhjF7gkOdkRKr+ck867ejnnIsEXA+1iyt
        zo237iOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-0074TA-UL; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 144F4301C36;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 609552B572DF7; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130947.914005103@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 15/59] crypto: x86/crct10dif-pcl: Remove redundant alignments
References: <20220902130625.217071627@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Also, with having pushed the function alignment to 16 bytes, this
custom alignment is completely superfluous.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/crct10dif-pcl-asm_64.S |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/crypto/crct10dif-pcl-asm_64.S
+++ b/arch/x86/crypto/crct10dif-pcl-asm_64.S
@@ -94,7 +94,6 @@
 #
 # Assumes len >= 16.
 #
-.align 16
 SYM_FUNC_START(crc_t10dif_pcl)
 
 	movdqa	.Lbswap_mask(%rip), BSWAP_MASK


