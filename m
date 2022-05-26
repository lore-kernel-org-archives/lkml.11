Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BCDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 15:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbiEZPEQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiEZPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7E6A42C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E81AE61BD1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF142C385A9;
        Thu, 26 May 2022 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653577450;
        bh=DAb6Mdf0L5zLMXVmixeygXYc8MEZ6Kt1EcneRZH0ja0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIk+Spsefgrihz/Ij8Nj75Ys69J7KtYhwaUGRgBVdYtP0Z4qsP77FSz2uklqRpYCZ
         3Exf4aANOHEv2OtNlQZa0PaBmWVheUmLcG1ih236qzadRs4zLx3hQQ1YlneE8CDbx5
         2YVIG0RKFuoHHG/HoLoGwFOyng4p1czKDhtORg/Td5PgVgwsNHcIDRW5XVjgWzz9xT
         84UTtw5SSlp4lUeLgfMquOOKxdU1kNh9MTEY1AD7TSUZGrACvM+07/8GWywrAXZ5Qf
         Z+lj/3z3tYBLrIZpho6Kqd8dPsXYCxmmuzVL8ShRac4G3oHE0J0gK5wGGmYt+ZrERF
         Hl4DdX9k8H4+g==
Date:   Thu, 26 May 2022 08:04:07 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 1/7] x86/entry: Anchor annotation
Message-ID: <20220526150407.bsagwksr5osgde62@treble>
References: <20220526105252.440440893@infradead.org>
 <20220526105957.754830839@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220526105957.754830839@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:52:53PM +0200, Peter Zijlstra wrote:
> x86_64-allmodconfig gives:
> 
>   vmlinux.o: warning: objtool: entry_SYSCALL_compat+0x0: ANNOTATE_NOENDBR on ENDBR
> 
> This is due to:
> 
> 	ANNOTATE_NOENDBR
> SYM_CODE_END(entry_SYSENTER_compat)
> SYM_CODE_START(entry_SYSCALL_compat)
> 	UNWIND_HINT_EMPTY
> 	ENDBR
> 
> And the hint then landing on the first instruction of the next symbol,
> which happens to be ENDBR. Stick in an int3 to anchor the annotation
> in the previous symbol.
> 
> Fixes: 3e3f06950434 ("x86/ibt: Annotate text references")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64_compat.S |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -124,6 +124,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
>  	jmp	.Lsysenter_flags_fixed
>  SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
>  	ANNOTATE_NOENDBR // is_sysenter_singlestep
> +	int3
>  SYM_CODE_END(entry_SYSENTER_compat)

Hm, I get the feeling this warning is pretty much useless anyway.  Can
we just get rid of the warning instead?

-- 
Josh
