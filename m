Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D16C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 16:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiD0RAk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiD0RAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D95388C;
        Wed, 27 Apr 2022 09:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAF98B8268B;
        Wed, 27 Apr 2022 16:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF90CC385A9;
        Wed, 27 Apr 2022 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651078636;
        bh=bnHxQ3h3Lg/UJsi0PXwoX9a2WzQGKD488htac3O304M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNbCrDvaxpbtVxAc4HQFB4Ib8FmcMhBjcG5hgpExJf3bU1F4V40Il3nJ2iVNOkJYb
         3JVnDfrthrD1uvOICQF3B2FnQo8r0Rz104umyb/novwQhNJ2WWexNJNE6a+uvc3P0v
         A2CN3c1rYL6ZA6mwvHqP46URueFBA6OevStpE+sM=
Date:   Wed, 27 Apr 2022 18:57:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org, jun.li@nxp.com,
        lznuaa@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/1] usb: cdns3: allocate TX FIFO size according to
 composite EP number
Message-ID: <Yml16DvnUR/tJSCO@kroah.com>
References: <20220427163525.1129887-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427163525.1129887-1-Frank.Li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:35:25AM -0500, Frank Li wrote:
> Some devices have USB compositions which may require multiple endpoints.
> To get better performance, need bigger CDNS3_EP_BUF_SIZE.
> 
> But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
> multiple endpoints.
> 
> By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.
> 
> Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
> Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
> ecnds3_device:ep_iso_burst
> 
> Using a simple algorithm to calculate ep_buf_size.
> ep_buf_size = ep_iso_burst = (onchip_buffers - 2k) / (number of IN EP +
> 1).
> 
> Test at 8qxp:
> 
> 	Gadget			ep_buf_size
> 
> 	RNDIS:				5
> 	RNDIS+ACM:			3
> 	Mass Storage + NCM + ACM	2
> 
> Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
> exceed FIFO memory.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2:
>  Add safe check for mult, buffering and maxburst

that's nice, but this is v8, not v2?

confused,

greg k-h
