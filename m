Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32534C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 09:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiCLJmq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 04:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiCLJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 04:42:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF91E7A4D;
        Sat, 12 Mar 2022 01:41:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6C3608C4;
        Sat, 12 Mar 2022 09:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3803C340EB;
        Sat, 12 Mar 2022 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647078095;
        bh=74Qk+1Lz/y7wm8qSZrARmBvUukIFHvun9Zno4jfx6FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HM+0sFoDr8Q/js1IW0R8AzUT3ch38BnyEGZlgWC1PYjK+1gEeFbKVS+yTd9Lur4LZ
         BBnCEWIItwB/QD3PLmmodkNF9byuR3N/JsA62XCmav1lMRl2iEHpGRwEinUgKoxrsJ
         3MjSzfAb5EWyTAJ6zvVXwluo1nm+xt/FUHsStGOY=
Date:   Sat, 12 Mar 2022 10:41:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Documentation: update stable tree link
Message-ID: <Yixqy++gz6pEAsmL@kroah.com>
References: <20220312080043.37581-1-bagasdotme@gmail.com>
 <20220312080043.37581-5-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312080043.37581-5-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 03:00:43PM +0700, Bagas Sanjaya wrote:
> The link to stable tree is redirected to
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git. Update
> accordingly.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: stable@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/stable-kernel-rules.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 523d2d35127..c242fe1788c 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -181,7 +181,7 @@ Trees
>   - The finalized and tagged releases of all stable kernels can be found
>     in separate branches per version at:
>  
> -	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> +	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

I should take this change right now as this should have been changed a
while ago.

thanks,

greg k-h
