Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3837C25B0C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Aug 2022 07:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbiHFHMM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 03:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiHFHMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7D14D33;
        Sat,  6 Aug 2022 00:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26A360B06;
        Sat,  6 Aug 2022 07:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE29CC433D6;
        Sat,  6 Aug 2022 07:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659769927;
        bh=TspJkEYpf9ANM09LzpWrxNOo37sDV+jPfAlRlt+nlFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHQT8NrYjMTz4MEAhKuyH5AJLuFcwBTKCAG7ZxUydJtnog369c8TBnfpZ/IRyWwgL
         ITWNffi3qCmccO1MvTV9jBwGhd+FGx01hD1rcLH5+sEo9XlPGPXIJBZIs0+AyvRAXQ
         7DMn+g/DCegv4SX54JRtfL3fFUuwGc5ElOyWXGUw=
Date:   Sat, 6 Aug 2022 09:12:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     tglx@linutronix.de, jgg@ziepe.ca, ira.weiny@intel.com,
        dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
        wonchung@google.com, list@mail.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver core: Define dev_err_probe() as __cold
Message-ID: <Yu4URNSoKRiNWmyj@kroah.com>
References: <0d4391f85d916508dba096caf132b0a973b08800.1659768386.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4391f85d916508dba096caf132b0a973b08800.1659768386.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 08:49:23AM +0200, Christophe JAILLET wrote:
> Give a hint to the compiler that dev_err_probe() is used for error
> handling. So calling paths are unlikely.
> 
> >From gcc documentation:
> 	The paths leading to calls of cold functions within code are marked
> 	as unlikely by the branch prediction mechanism.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  include/linux/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 424b55df0272..4ac16bde9bf7 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1093,7 +1093,7 @@ void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>  
>  extern __printf(3, 4)
> -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> +int __cold dev_err_probe(const struct device *dev, int err, const char *fmt, ...);

As the probe() path is by default "slow", does this actually help
anything?  I never recommend using any sort of manual likely/unlikely
hints unless the results can be seen, otherwise the compiler and CPU
almost always do a better job over time.

thanks,

greg k-h
