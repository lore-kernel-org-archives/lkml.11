Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637CC19F2B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 07:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiG2Hjt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiG2Hjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:39:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1D21E04;
        Fri, 29 Jul 2022 00:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50E061B11;
        Fri, 29 Jul 2022 07:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4586C433D6;
        Fri, 29 Jul 2022 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659080385;
        bh=CIAxurvW34TFYojlhWRAlU5T6Eu7gc+rEwe+x0Mtino=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+SxERHiCrTIjRI9h6fjOj7xS/sldrl1ohbjaawfiy44HBXDn7KRyg/Xa9josPkfl
         qoeFu7L8pa++aEAyaSA4mAm377895yF/8//fDs2wGyGAasKF841WLb3PDvc9WeGQw1
         s1nTqDzGjlZ4AlPBtj/h8WM/8LLMz3Id/1RQapyk=
Date:   Fri, 29 Jul 2022 09:39:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor
 Lake IOM device
Message-ID: <YuOOvqoF4jJ3Tpmw@kroah.com>
References: <20220729003033.771761-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729003033.771761-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 05:30:33PM -0700, Utkarsh Patel wrote:
> Intel Meteor Lake IOM uses 64bit IOM BASE address than previous Intel
> Generations which use 32bit.

I can not parse this sentence, sorry.

> Added code to support 64bit IOM BASE address change with necessary ACPI
> resource extraction support.

Again, I do not understand :(

> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

No need to backport this to stable kernels?

> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 47b733f78fb0..a8e273fe204a 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -571,9 +571,11 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
>  
>  static int is_memory(struct acpi_resource *res, void *data)
>  {
> -	struct resource r;
> +	struct resource_win win = {};
> +	struct resource *r = &win.res;
>  
> -	return !acpi_dev_resource_memory(res, &r);
> +	return !(acpi_dev_resource_memory(res, r) ||
> +		 acpi_dev_resource_address_space(res, &win));

I don't understand, what is the extra check here doing?  Why is that
needed and why aren't you triggering off of a platform type?

thanks,

greg k-h
