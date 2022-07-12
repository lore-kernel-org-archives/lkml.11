Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ECAC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 12:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiGLMpF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGLMpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:45:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DCF9C250;
        Tue, 12 Jul 2022 05:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6720DB81815;
        Tue, 12 Jul 2022 12:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55488C341C8;
        Tue, 12 Jul 2022 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657629898;
        bh=ua5RqLgj1pT4fISxEKfLQGWLQOzwOavenhptwtXM0n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kG2llNRiY3/bYpj6fbak6UwigPSxVTjUUkdsIukEV1GzMkKABNHT5Tm3j8OoepEzK
         BKaG0ATFKTzf9CNcFTBHVYfNXibE0u6HYjQ8yHgPafqOKxy8pUfASpBn8j7bheEYgW
         VpTYT1S7NZg3vNi4e3vLGIR1+MUE+/PIvEctCvdc=
Date:   Tue, 12 Jul 2022 14:44:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ben Kao <ben.kao@intel.com>
Cc:     mathias.nyman@intel.com, mathias.nyman@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci-pci: Enable runtime PM on Alder Lake-N PCH xHCI
 controller
Message-ID: <Ys1sxRT0i/NXSui7@kroah.com>
References: <20220712122442.22504-1-ben.kao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712122442.22504-1-ben.kao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:24:42PM +0800, Ben Kao wrote:
> There are two Alder Lake-N xHCI host controllers with PCI IDs
> 0x464e and 0x54ed, now we add the quirk to default enable runtime
> PM for 0x54ed.
> 
> Signed-off-by: Ben Kao <ben.kao@intel.com>
> ---
>  drivers/usb/host/xhci-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index dce6c0ec8d34..44486156bd5d 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -61,6 +61,7 @@
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI		0x464e
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
> +#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed

I think we ask this every time, but why don't we enable this for all
devices and then only disable it for the tiny number that don't need it?

Why do you all force us to add this for every new device created?

thanks,

greg k-h
