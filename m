Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2555BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 17:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243879AbiD3Rnp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiD3Rnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:43:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9670413CC1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ergVhzb7zbR5XIJcF5vi+nItgGqPtlzwF+XGu2aPaCI=; b=Mf0aCeoF75w3Bx0h8SzPppx8/0
        02CFe4rG0191XFeXWOqugyd8lfxBZs0ozGfTlZ07+0caXOPU/+zBeyou3BCoWuqijRwPc7MRkHXrE
        Pod0pEyamB7oUbe8kRMS2ZFcv3h6oZAyRl3HTtWhsMM8l8FkWZFWjuWh2/Vs8AYCERm8yOBd58lma
        ZFiEmjTZcs6SwETviZDR2wpnxNiHYRfDmOA6zBGcp6zWlsX15rTk7UVjso6fI1/q4ste4/4auSGuZ
        zjT9apBFHPUqPCbAHCNVOWkZJ/SABBWrXz8aID7ysEhEZy66OXxf9NXY8P67WvHFDxeXHtfWgHehV
        ITAo+hQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkr4l-00DUCg-P5; Sat, 30 Apr 2022 17:40:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EFFD3001EA;
        Sat, 30 Apr 2022 19:40:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15AE42028EFE6; Sat, 30 Apr 2022 19:40:11 +0200 (CEST)
Date:   Sat, 30 Apr 2022 19:40:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     jpoimboe@redhat.com, mingo@kernel.org, bp@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: rework error handling in objtool_create_backup
Message-ID: <Ym10e9oSyKXOopJv@hirez.programming.kicks-ass.net>
References: <20220430173240.3346735-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430173240.3346735-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 01:32:40PM -0400, Tom Rix wrote:
> The cppcheck reports this issue
> [tools/objtool/objtool.c:65]: (error) Memory leak: name
> 
> This is a general problem.  When ojbtool_create_backup() fails anywhere it
> returns an error without freeing any of the buffers it allocates.  So
> rework the error handler to goto the appropriate free level when an error
> occurs.

If it fails, objtool terminates. Process termination releases all
resources.
