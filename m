Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15680CCA47F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 11:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiGOLlG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGOLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:41:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B865E334;
        Fri, 15 Jul 2022 04:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75749B82B88;
        Fri, 15 Jul 2022 11:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E21C34115;
        Fri, 15 Jul 2022 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657885261;
        bh=tI3obr1zjtcXRcjUQr/GYvd7f15IhY0cItLR9yFKKIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zPrjIczi/JijDz0Uvc0CV3kmxqkhdn4QcB7qN1ZNOIjgSYLahPPBNNH60GSDS4o7s
         8KHW18Gtl+lkhfPiBgTic6F4ZWeTgQm2qG7TPRFB/S2TRYMHXdCQM0sjcN0Zcruu9e
         xZvQtbnbTbpunQgBXMnNyH4UZgZZZJ8TlwVJ/BFc=
Date:   Fri, 15 Jul 2022 13:40:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: Re: [PATCH 3/3] usb: typec: tcpci_rt1711h: Add compatible with rt1715
Message-ID: <YtFSSRoeVf39pwVH@kroah.com>
References: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
 <20220715100418.155011-4-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715100418.155011-4-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:04:18PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add compatible with rt1715

I can not understand this changelog text at all.  As my bot would say:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

Please fix up.

thanks,

greg k-h
