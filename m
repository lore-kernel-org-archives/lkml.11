Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0548C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 10:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbiFJKSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiFJKSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3203E5D6;
        Fri, 10 Jun 2022 03:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F4A61F93;
        Fri, 10 Jun 2022 10:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81020C3411E;
        Fri, 10 Jun 2022 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654856282;
        bh=Mgof106cR39tCNt2/D1vN1oOa5Rp+UIYZiiD80oMBuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgpKivqT9cZqXAgrW/tfIVrc5r8vOzX/GEqwOLFyBG2EaoIOyj128iD8Gi9w0U5MZ
         Gr/rM4W9g8rimCzQAq6pifSKCrHsQm22eg0Gkzrb14KZKep8f174nubAuG3Pem6HnX
         dhD2abwlHXkE+xhfVXWHQGjR+2/Sfz7fXjhbgmw8=
Date:   Fri, 10 Jun 2022 12:17:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <YqMaUroS87rjnCny@kroah.com>
References: <20220309023404.1221453-1-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309023404.1221453-1-xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:34:01AM +0800, Xin Ji wrote:
> USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> and a port controller (TCPC) - may require that the driver for the PD
> controller accesses directly also the on-chip port controller in some cases.
> 
> Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> V8 -> V9: Add more commit message
> V7 -> V8: Fix Guanter's comment, remove unnecessary explain
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
>  drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
>  drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
>  {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
>  5 files changed, 5 insertions(+), 7 deletions(-)
>  rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)

I need an ack by the typec maintainers/developers before I can take this
(hint...)

thanks,

greg k-h
