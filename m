Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F1BC4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 12:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiCVMTF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiCVMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:19:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246446B0BD;
        Tue, 22 Mar 2022 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dJ422ss62r7rZu3jI8a997imtPu85DLNk93ombUC2VE=; b=T0d8wfhmyz9UgHHMyMUjT8jefM
        IyT3R8r/biQg6U7B8TCLSHsTMfsGKhqSo742277RRT9O3imiTofH5AFllEMfhNUy/rQ5dqo4I6yAs
        yPZMGySA6fZytLcHji/IcciScLZTzaINCZ+5IlMH5zRm9a6zQusxfPX+4JldbNkEY2fguhZpJRNEf
        6ihqWrWBVO3NqVPI4YNkQOO8l53qxefKJiqiNnmsmVWmdkUtc2H1wLT7xLD4ayZSFgz/WVgV6QoJG
        WBYKIl0rOZwe5WPobHAWXHO4s7SiUFZdtwAmj9Hf+9QrXtFcTw9pfb94yuBkXPtRAtsOffxX5+16l
        CVDcvXsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWdRu-00BZXn-Sf; Tue, 22 Mar 2022 12:17:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7EC8B3001CD;
        Tue, 22 Mar 2022 13:17:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F4F02D3EAA6D; Tue, 22 Mar 2022 13:17:18 +0100 (CET)
Date:   Tue, 22 Mar 2022 13:17:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rostedt@goodmis.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <Yjm+TmKyO+HDOBgN@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
 <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:31:36PM +0900, Masami Hiramatsu wrote:

> > But I still think it's fairly terrible to get a (flawed) carbon copy of
> > the kretprobe code.
> 
> Indeed. I would like to replace the trampoline code of kretprobe with
> rethook, eventually. There is no reason why we keep the clone.
> (But I need more arch maintainers help for that, there are too many
>  archs implemented kretprobes)

CONFIG_KPROBE_ON_RETHOOK - and then implement archs one by one?
