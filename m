Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097E4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiDZKiL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349175AbiDZKhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1F93B7;
        Tue, 26 Apr 2022 03:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEDEC615AB;
        Tue, 26 Apr 2022 10:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23B3C385A0;
        Tue, 26 Apr 2022 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650968459;
        bh=upRt5cWmk45sKqQhG085JLpi7qzRTD4ZA5fWWha7b9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2IvDGzM7d6NMwW8m92qobOdm0KxYklDlSURqj6xlGZ0Lip7LGAnU2Fpks5QkSrft4
         sASZeINeZGJUxM4cpu/oZrFdKN0962p2fvAgOqkUzmgArFQNca0JSbPF7qTKRuQR6a
         eKgsPIxgjxGnv46EGxVygB2m+AiB2KNXn5o0unmQ=
Date:   Tue, 26 Apr 2022 12:20:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <YmfHiEneCRlnJA3e@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
 <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:18:48PM +0900, Daehwan Jung wrote:
> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> driver mainly and extends some functions by xhci hooks and overrides.
> 
> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> on specific address with xhci hooks. Co-processor could use them directly
> without xhci driver after then.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/Kconfig       |   8 +
>  drivers/usb/host/Makefile      |   1 +
>  drivers/usb/host/xhci-exynos.c | 567 +++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-exynos.h |  50 +++

Why do you need a .h file for a simple single driver like this?  Just
put it all into the .c file please.

thanks,

greg k-h
