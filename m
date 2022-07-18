Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4649C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 17:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiGRRwO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGRRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:52:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3DD2D1D0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:52:11 -0700 (PDT)
2Message-ID: <20220718173814.731702240@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658166729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:references:references;
        bh=I1dyCgrbBhVsbqRB9CJnF7qT85c2C8VtZWCV7r/mQKE=;
        b=bGBMvO4FpgCX4tXtlE+fL8VfMzDwoujIpIhDuMOn5dLoVMz1QOtqKkiQ0NsK/sVjoxEIbV
        mgRp4gio8nNTg19NiMrHUjHHvZEC6s6c/OEaagA1LVeazWzZ1iVLEf3gZ9Po9WQMuM6guh
        ZsCgtTNEnDQqjw2ULIoOX3dtxInSfZzGHL2yf0Yp00l3eGpul9ncy4JrTNngA1r61XKSZI
        TLpiUzGOQ47/tLQzXPhL8EekQ9aKvWsAVsFXHeRRSQdBYpHxDkd+ZlEJASoiARsui9FZCv
        dcsGtmybmF2X+Gs+SEtiMOc7gwSLb8YLwKtCAEE/g0kiFbKPMA4lRs+Xegqwew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658166729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:references:references;
        bh=I1dyCgrbBhVsbqRB9CJnF7qT85c2C8VtZWCV7r/mQKE=;
        b=z5D9kijGPb+mXqLw/GMpD3/0Pgz+RzfFhq/SYvrv0Vsnouf67IAv+pIK75yYT80dWEQ9My
        xFDJHKKV3nMYlfBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220716230952.787452088@linutronix.de>
Subject: [patch 0/3] x86/cpu: Sanitize switch_to_new_gdt()
Message-Id: <20220718175208.B1F304BC0@xen13.tec.linutronix.de>
Date:   Mon, 18 Jul 2022 19:52:08 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a replacement for patch 2/38 of the call depth stuffing
series as a follow up to the review feedback.

Thanks,

	tglx

