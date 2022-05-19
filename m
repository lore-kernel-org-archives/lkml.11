Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247EFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 22:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiESWED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiESWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:04:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92AC8BFA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FRhvNyoi9JNty0fezPLmqEugjyT5imBlcHaOEqSVPXQ=; b=ipGU7OB9CdsPzvr6GdVEfEuEsa
        S/So5FAv5z7ntO6PlfcsNhUi0wE1vP4uLvi6DlLhEeGATiepF248vN+eSxGIwg2XAzsZDqGC+/tGB
        z73xIXXGDbjkUGKLC51+SZBGpZrsrBYkN4Pqla3n+7juMCiki2+XFPOgxjzX6zq/0TbpAr/50c36U
        QFHoe4l5il3VdceNVUK8SQwiNjlUoBom+mYvi/ws5vz7eKwrjaO4B/fsTPaoUQ/0hY3h2B3pHdJO4
        E4qPlZgtHs5hHL/Y8ut755g/KTH6vwKyOU8yLMNZlSX6X3oZxQNM0FEacD2obIw64p4DV1+4B5ktw
        Gey5CQBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nroFL-00D8Hs-HE; Thu, 19 May 2022 22:03:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2506981005; Fri, 20 May 2022 00:03:49 +0200 (CEST)
Date:   Fri, 20 May 2022 00:03:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, kirill.shutemov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <20220519220349.GM2578@worktop.programming.kicks-ass.net>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519213422.119695559@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 19, 2022 at 11:27:59PM +0200, Peter Zijlstra wrote:
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -178,6 +178,9 @@ void __cpuidle tdx_safe_halt(void)
>  	 */
>  	if (__halt(irq_disabled, do_sti))
>  		WARN_ONCE(1, "HLT instruction emulation failed\n");
> +
> +	/* XXX I can't make sense of what @do_sti actually does */
> +	raw_local_irq_disable();
>  }
>  

Kirill, Dave says I should prod you :-)
