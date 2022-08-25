Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A98ECAA25
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 16:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbiHYQsf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiHYQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:48:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339BBD4FF;
        Thu, 25 Aug 2022 09:45:53 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:45:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661445927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2v6YbYZmiYDe7WfSso5jObvZ3rFRTHkQFCfrcNLUwYg=;
        b=SqHK9XadkHVcaUFO/skdpKu1AeJZRcWsxZ518P2xTNy/hZSesc9hn4WBc0CUMEGnF+CZrc
        7NRoTwl2otlb1BavnLeaGjemnh7MPIQBqOSSk2ThTjJxEnJX1YjIThZNI96atNdI62BtXz
        xdkarWTxzdNvyrhLJmGJXEc5BNPFf9RmXeTqLR6j5tGdklq3DnQGa3IgD4rkyCoIFCLHf2
        bY8oxdl6MPcvPCtxY8Co7AiNf5Tlq1W6hvq9xMBucd6XM8xQnAwdKmO4rV5XXwoad/IR9X
        UYfzXTNVHVq8cVnwEGv1tmr7dsp3eGnsEjnbrU0iWBmg5TRjbtaHNVcMD0H0XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661445927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2v6YbYZmiYDe7WfSso5jObvZ3rFRTHkQFCfrcNLUwYg=;
        b=0/LT3924Wog2G8gBv6yQb4Fw3+ip1wJFf1t8CqSsydMp06dzGgaf0dtj6qk2JIKGTuYAVx
        r2Gtct26RU8oirCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] u64_stat: Remove the obsolete fetch_irq() variants
Message-ID: <YwenJaYmzEJGZGUW@linutronix.de>
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-10-bigeasy@linutronix.de>
 <20220817112745.4efd8217@kernel.org>
 <Yv5aSquR9S2KxUr2@linutronix.de>
 <20220818090200.4c6889f2@kernel.org>
 <Yv5v1E6mfpcxjnLV@linutronix.de>
 <20220818104505.010ff950@kernel.org>
 <YwOd7Ex7W21WzQ8N@linutronix.de>
 <20220822110543.4f1a8962@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220822110543.4f1a8962@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-22 11:05:43 [-0700], Jakub Kicinski wrote:
> Guess so, but it shouldn't be extra work if we're delaying the driver
> conversion till 6.1?

I posted v2 of this series excluding 9/9 as you asked for. I will send
it later, splitted (as in net only), once the prerequisite is in Linus'
tree.

Sebastian
