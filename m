Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 02:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiFHCQA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388957AbiFHBpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 21:45:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3E48C596
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B80BB82464
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA80C3411C;
        Tue,  7 Jun 2022 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654640864;
        bh=5S/z21z92weYsEvQ8sPPs+ir8hNQ+/Ya3+hZvDiMy5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cKxKBVi5rytKhSUhsR1sqCXCIPzwkOTvcLJ8meC4RfrPuYgz0kOcW6FLaTsn9gAsw
         kjk7YBdIUHrogGL/Dmwl/6mCUF9e9kG4DwbeSFZRM3cOBE915bq7MpGq+iXo0YFhjC
         HxFo+7C7nQZE2NaMqwQoSBIupxQ/cbLiNi+Glvgo=
Date:   Tue, 7 Jun 2022 15:27:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] include/uapi/linux/swab.h: add __u16 cast to __swab16
 conditional
Message-Id: <20220607152744.d7c801d092529309500ac9a6@linux-foundation.org>
In-Reply-To: <20220607222006.22719-1-jstitt007@gmail.com>
References: <20220607222006.22719-1-jstitt007@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jun 2022 15:20:06 -0700 Justin Stitt <jstitt007@gmail.com> wrote:

> if __HAVE_BUILTIN_BSWAP16__ is defined then __swab16 utilizes a __u16 cast.
> This same cast should be used if __HAVE_BUILTIN_BSWAP16__ is not defined as
> well. This should fix loads (at least a few) clang -Wformat warnings
> specifically with `ntohs()`
> 
> ...
>
> --- a/include/uapi/linux/swab.h
> +++ b/include/uapi/linux/swab.h
> @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
>  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>  #else
>  #define __swab16(x)				\
> -	(__builtin_constant_p((__u16)(x)) ?	\
> +	(__u16)(__builtin_constant_p((__u16)(x)) ?	\
>  	___constant_swab16(x) :			\
>  	__fswab16(x))
>  #endif

More explanation, please?  Both ___constant_swab16() and __fswab16()
return __u16, so why does this patch have any effect?

