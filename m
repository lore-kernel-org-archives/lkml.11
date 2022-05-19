Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD68C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiESQNo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiESQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15BCC8BC5;
        Thu, 19 May 2022 09:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AF4361C44;
        Thu, 19 May 2022 16:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8195EC385AA;
        Thu, 19 May 2022 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652976816;
        bh=81OaKyVNWmaXHa4F4LnauX9fnfls2XYBMy6iEUMaH/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mF0DcOju2Tq07iFUb2PCuTbb0qta67wAVmAydPw0Igk/YOesy6KhoVHOA3ieGMszG
         hEspJBMLtXJgnn0QfAl1Qf7cJz/tRm7GMTI4ZfWs6RBg2xWzQieMzA0kFG5JNnbjg+
         HT2Fqp1fN5LaQICZfxMYmkLqdBuni+TEx5sYGq3c=
Date:   Thu, 19 May 2022 18:13:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushagra Verma <kushagra765@outlook.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB / dwc3: Fix multiple checkpatch warnings and
 typos
Message-ID: <YoZsrrXE1AUk6KsG@kroah.com>
References: <HK0PR01MB2801538F9FA06A3B8F2B59CFF8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB2801538F9FA06A3B8F2B59CFF8D09@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:48:22PM +0530, Kushagra Verma wrote:
> This patch series fixes multiple checkpatch warnings and typos in drivers/usb/dwc3.
> 
> Kushagra Verma (3):
>   USB / dwc3: Fix bare use of unsigned warning
>   USB / dwc3: Fix a repeated word in ep0.c
>   USB / dwc3: Fix typos in Kconfig
> 
>  drivers/usb/dwc3/Kconfig | 4 ++--
>  drivers/usb/dwc3/core.c  | 4 ++--
>  drivers/usb/dwc3/ep0.c   | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> -- 
> 2.36.1
> 
> 

For some reason you did not thread these properly at all, so our tools
can not pick them up as they think these are all individual commits.

Also, please fix up the subject lines to match the driver style, and
your changelog text needs some work, see the kernel documentation for
how to write better ones (hint, never say "this patch")

thanks,

greg k-h
