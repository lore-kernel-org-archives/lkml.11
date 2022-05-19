Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9485C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 15:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbiESPZE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiESPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:25:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24653EAD1D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 811D5CE2464
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BB4C385AA;
        Thu, 19 May 2022 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652973898;
        bh=p08/j1WxhZikdsAQC/lS92StwB6HxvqmVgWwVp5hjpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fE+byQ/x+ZHJXRVWSn88JLnLQYKo4cOYh7c65rmTQdf67deNkyyRO2UBOz5Sz5xxf
         ygVScF19Q9Go/NlG4eh5WbRZJJNFUGEXZu9NLKqYL5bSqbZLqGlvCGKOGyQ+5Yf0uy
         1z2qnzbVvD3yWIw6JxuZXnG7IAFHA9zsXtg6dFLw=
Date:   Thu, 19 May 2022 17:20:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [GIT PULL] lkdtm updates for -next
Message-ID: <YoZgLzTvDqyCSaHW@kroah.com>
References: <202205171451.EE8E27685@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205171451.EE8E27685@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:52:58PM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Please pull these lkdtm updates for -next (preferably for the coming
> merge window).
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit 2a0338769f27a38b5dd60b6bef5b83003789439b:
> 
>   lkdtm: cfi: Fix type width for masking PAC bits (2022-04-26 17:11:05 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/lkdtm-next

Pulled and pushed out, thanks.

greg k-h
