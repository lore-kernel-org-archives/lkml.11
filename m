Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3235C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 20:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiEBUFc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiEBUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:05:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CDFB7C3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qP8X/15/8rV+8XJ4DQQefhhoWHkOlTpaFMBiy1bSud4=; b=pS3s3v4yQnFWvNOILN10oo76qI
        bHBduS1ZKyRi5IxfiuPuuTxdaxK3iNRNtomp3vRB5oUtHZTeraqxVdFtY0qoreGRunNVDcdBqKPpD
        DvI+VwZO9yQ0t/g0H1gtD1Ed2vdPKs+BQf5c4rK1PfZHGgI62Kwf+EIIJqwp39GQVfKKaUoiW6VPP
        ZHmOlMShJBU4xTHGmh8TLldVq86bi7TzTp+HUqfHVP50EvjoNFj/MpR3XWk8HH1KuA/XMhSBpmjDx
        H0mMihY6/rBNLvfj2OnKUFpSqEiNjHCfp/Gr+ivtLgATclUiADkMEJWt0dwdXrF8K1svcXER4e6Ty
        sjdqfQAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlcEz-00AZc0-Os; Mon, 02 May 2022 20:01:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 617C130017D;
        Mon,  2 May 2022 22:01:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4687620288CEB; Mon,  2 May 2022 22:01:53 +0200 (CEST)
Date:   Mon, 2 May 2022 22:01:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix SLS checks
Message-ID: <YnA4sS0hA6VwFKPd@hirez.programming.kicks-ass.net>
References: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
 <20220502181547.fzz2yre2p4akph4s@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502181547.fzz2yre2p4akph4s@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 11:15:47AM -0700, Josh Poimboeuf wrote:
> On Sat, Apr 30, 2022 at 12:50:02PM +0200, Peter Zijlstra wrote:
> > 
> > Fix the SLS validation; not having a next instruction is also a fail
> > when the next instruction should be INSN_TRAP.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/check.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 3f6785415894..3354101ffe34 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -3380,7 +3380,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >  
> >  		case INSN_RETURN:
> >  			if (sls && !insn->retpoline_safe &&
> > -			    next_insn && next_insn->type != INSN_TRAP) {
> > +			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
> >  				WARN_FUNC("missing int3 after ret",
> >  					  insn->sec, insn->offset);
> >  			}
> > @@ -3428,7 +3428,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
> >  
> >  		case INSN_JUMP_DYNAMIC:
> >  			if (sls && !insn->retpoline_safe &&
> > -			    next_insn && next_insn->type != INSN_TRAP) {
> > +			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
> >  				WARN_FUNC("missing int3 after indirect jump",
> >  					  insn->sec, insn->offset);
> >  			}
> 
> My SLS rewrite in tip/objtool/core already fixed this, FWIW.  But this
> could be good for -urgent.

Urgh, I should've looked at that indeed. This didn't find any new sites
though; so I don't think this needs to go through urgent.
