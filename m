Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A02C32796
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 15:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiHXPir (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiHXPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:38:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4417198C;
        Wed, 24 Aug 2022 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fHn/HurE6G7lQKnc8g7UWWop7cNMxA3yDLWtujI6evg=; b=da2rKDt/rAXyxvZ704clMkCQP8
        AfMfpXFLtvIgLih9jukwzpYIS3e4LgxqaqFyGVlig0Y9LvNIHVkM62yXtAJHNrE+il3cNzJMZBhgK
        JnR3DSilRVQ6j3daaBpoJba25Vy7bhNiLXpZK/vV8POiPDz9DSRf8iFop+8wjiTz+QfM2Mc1Gi1H0
        rS6EmcA1ww6ljbbEtl0SRwg0F2WTOPlIY8M2bHgIArBg5q+zxeTp2urnti7nnoSncCQU855rA5WDy
        osM2l+mXM6VJOxcPZbpqPpDGIKvRpWxUiDeidzuV8+cc7UyNGLc9gLtPycmmBrHJtidmanA8s7GMm
        ZnO5FIiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQsSb-00GRSU-2m; Wed, 24 Aug 2022 15:38:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FCB0980BE2; Wed, 24 Aug 2022 17:38:27 +0200 (CEST)
Date:   Wed, 24 Aug 2022 17:38:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Michael Matz <matz@suse.de>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <YwZF8pvWHqFYQOVB@worktop.programming.kicks-ass.net>
References: <20220824152420.20547-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824152420.20547-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:24:20PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Mark both the function prototype and definition as noreturn in order to
> prevent the compiler from doing transformations which confuse objtool
> like so:
> 
>   vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction
> 
> This triggers with gcc-12.

You'll probably also have to add it to the
objtool/check.c:global_noreturn[] list, for the case where objtool fails
to recognise it as noreturn.

