Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C37C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 21:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiGAVUk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGAVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692350728
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6245762356
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 21:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A0BC3411E;
        Fri,  1 Jul 2022 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656710436;
        bh=K7S1iwMVt9Tc6gO7LsvHgFsvq9tpH1mg4DvGikanxtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhKIX2tswW7aIYABkIs9jIKx7jtmPxHBZoDvk28tt7OWcBEcNQ+v2cFkFdDXAgZyv
         Zc900AXCfKNdAU7CesT11EGXkC+PVsTZNBlnQVlVTCepSX4vLLu4l5QfyzWblA7MS3
         9Qc0+u7NStXro9STs0Yo0HT25uo5uoTf+4S6R+ZcSfbtcGnK9gqOwKxZw2Qtl/ofOm
         aId3x8C2gew5//yYxR0fFcGQGIQAo4G7Wj7neE38aosZjriXCznxsGwNUP8TzFwXdd
         8Qb5i2NE0DXh+T/nU80rdlOzpM3p4o2nAXlcL0vu8kZPxb7P5ZnP6aeYsUlnl35tJH
         14R2BYSd70h9A==
Date:   Fri, 1 Jul 2022 14:20:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: Allow X86_X32_ABI with llvm-objcopy in some
 cases
Message-ID: <Yr9lIs6H03uq+UuV@dev-arch.thelio-3990X>
References: <20220701210437.579322-1-alex_y_xu.ref@yahoo.ca>
 <20220701210437.579322-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701210437.579322-1-alex_y_xu@yahoo.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, Jul 01, 2022 at 05:04:37PM -0400, Alex Xu (Hello71) wrote:
> According to the comment and commit message, there are issues compiling
> with IBT and/or compressed debug sections. Therefore, the condition
> should be restricted to when those are enabled.
> 
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be0b95e51df6..e5af1088420e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2847,7 +2847,7 @@ config X86_X32_ABI
>  	# compressed debug sections to x86_x32 properly:
>  	# https://github.com/ClangBuiltLinux/linux/issues/514
>  	# https://github.com/ClangBuiltLinux/linux/issues/1141
> -	depends on $(success,$(OBJCOPY) --version | head -n1 | grep -qv llvm)
> +	depends on !X86_KERNEL_IBT || !DEBUG_INFO_COMPRESSED || $(success,$(OBJCOPY) --version | head -n1 | grep -qv llvm)
>  	help
>  	  Include code to run binaries for the x32 native 32-bit ABI
>  	  for 64-bit processors.  An x32 process gets access to the
> -- 
> 2.36.1
> 

Personally, I would rather not play whack-a-mole with these dependencies
here. To me, https://github.com/ClangBuiltLinux/linux/issues/1141
appears to be a pretty fundamental problem. Right now, IBT is the only
known configuration that results in a .note.gnu.property section but
there might be other configurations in the future that will necessitate
adding other configurations here, which I am not a fan of. See commit
8cdd23c23c3d ("arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and
newer") for a similar situation on the arm64 side. I would much rather
effort be put towards fixing llvm-objcopy or coming up with a solution
that avoids using objcopy for x32 altogether.

That is just my two cents though, I'll leave it up to the x86 folks if
they want to have this allowlist of configurations.

Cheers,
Nathan
