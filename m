Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC7C32772
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 06:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiHQGzc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiHQGz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:55:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD45AC4D;
        Tue, 16 Aug 2022 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jh2VN7EbEuHp495bhU0IKbapcwYQ6kWiZIPUqwKXuFY=; b=Z8qxUhi9EYdI0kDbkJFgMlejj9
        c4VZitB2+3rDHJKVcz3YUxCT9tb5949gZKJ4QpVIf+pBRkHdkmUkHLigv/hsaBniXEjB1U0SJneNj
        ioZbEkl89M91K/E20QmO15aNAX/tjYY7yWZRW0HUI0+3LjxfrYa1Oqau3sjHJVJS1Erb/E8VKrYMz
        NUepYeO9cSAq1kx/5l9VXimY45qu5u27qZyiA6VaiAMtWdtIm7324711ibQtVaphODqmQ5mqTLvEN
        tA03SKi82Gq7Jgch03O1oLMqtiEQHC7MEpqwmKjB652ceRY4/AUOwdh3VzhywiFxOt952FKFjmlX/
        m2NLFIpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOCxK-007rJk-RU; Wed, 17 Aug 2022 06:55:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8DE198007F; Wed, 17 Aug 2022 08:55:08 +0200 (CEST)
Date:   Wed, 17 Aug 2022 08:55:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/nospec: Unwreck the RSB stuffing
Message-ID: <YvyQzHzLJpalcvbZ@worktop.programming.kicks-ass.net>
References: <20220809175513.345597655@linuxfoundation.org>
 <20220809175513.979067723@linuxfoundation.org>
 <YvuNdDWoUZSBjYcm@worktop.programming.kicks-ass.net>
 <839e2877-bb16-dbb5-d4da-bc611733c7e1@linux.intel.com>
 <84f4b1ea-d837-9a53-a21c-4ac602ff8e75@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f4b1ea-d837-9a53-a21c-4ac602ff8e75@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:04:36AM -0700, Daniel Sneddon wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 1a31ae6d758b..c5b55c9f2849 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -420,7 +420,7 @@
>  #define X86_FEATURE_V_TSC_AUX          (19*32+ 9) /* "" Virtual TSC_AUX */
>  #define X86_FEATURE_SME_COHERENT       (19*32+10) /* "" AMD hardware-enforced
> cache coherency */
> 
> -#define X86_FEATURE_NEVER              (-1) /* "" Logical complement of ALWAYS */
> +#define X86_FEATURE_NEVER              (0x7FFF) /* "" Logical complement of
> ALWAYS */


Bah, I initially spelled that: ALT_NOT(X86_FEATURE_ALWAYS), but Boris
made me do the -1 thing there. Oh well, Boris can fix that :-)
