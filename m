Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B865C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 16:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352027AbiCXQ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbiCXQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD591C5;
        Thu, 24 Mar 2022 09:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 716B4B8241E;
        Thu, 24 Mar 2022 16:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA021C340EC;
        Thu, 24 Mar 2022 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648140952;
        bh=ib+qwTs9M5Couw8u7y1nRf2k4CkR4X5BaDXmlBp3nT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1WVwOeg3Tedu/W1CIeR/pi6rNxCxQZd2lt46PtqI4i6Xg0WQb2lyEumo5FyRz2bMf
         9Hi1bgytSeUq1MRDxCJhGeg7uA5TIoZiM9CDCXnpxxLtWsfnoqkB7RHDwnyYz1F6qN
         Pl0HJ21FWFKxDlRqh1+vR4MTC34eSitaExpLvAMY=
Date:   Thu, 24 Mar 2022 17:55:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/process: Update ARM contact for embargoed
 hardware issues
Message-ID: <YjyilfhMgbqTo3eL@kroah.com>
References: <20220324151605.266645-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324151605.266645-1-catalin.marinas@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:16:05PM +0000, Catalin Marinas wrote:
> With Grant taking a prominent role in Linaro, I will take over as the
> process ambassador for ARM w.r.t. embargoed hardware issues.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Grant Likely <grant.likely@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index 6f8f36e10e8b..41a2afaaea75 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -244,7 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
>  an involved disclosed party. The current ambassadors list:
>  
>    ============= ========================================================
> -  ARM           Grant Likely <grant.likely@arm.com>
> +  ARM		Catalin Marinas <catalin.marinas@arm.com>

Nit, no tab is needed.  I missed this on the next line:

>    AMD		Tom Lendacky <tom.lendacky@amd.com>

But no need to follow bad decisions :)

thanks,

greg k-h
