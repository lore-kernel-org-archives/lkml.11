Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B526C3F6B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 09:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiG1J4y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 05:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiG1J4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7D63916;
        Thu, 28 Jul 2022 02:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 638A7614B6;
        Thu, 28 Jul 2022 09:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B3DC433D6;
        Thu, 28 Jul 2022 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659002209;
        bh=boCRpvTjs+becvjTUzbhpSoR5geBGJA5S2zg5QWdSzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoaQAlgH4ipQj1MmkAM7/6TnXhLNauUGd+9Etc2xZJqqfbSBFcNVbfzo2lnGlaIve
         SNaOdjL/t5ZKtXB2+QwsSpo6InQok9ULaiGkOKxuyEtN5Teq0zzfBIBjIy3aAc3gBT
         9nN4fpMlXB0Qaw0iT6ORhqeCWxnD6Z6P9wXSoxy0=
Date:   Thu, 28 Jul 2022 11:56:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, elder@linaro.org,
        f.fainelli@gmail.com, linus.walleij@linaro.org,
        Michael.Srba@seznam.cz, jeffrey.l.hugo@gmail.com,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH RFC v1 1/2] bus: add Wiegand write-only GPIO driver
Message-ID: <YuJdXk7eqSGlDpjj@kroah.com>
References: <20220728091712.13395-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220728091712.13395-1-m.zatovic1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:17:11AM +0200, Martin Zaťovič wrote:
> --- /dev/null
> +++ b/drivers/bus/wiegand-gpio.c
> @@ -0,0 +1,661 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Wiegand write-only GPIO driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

No need for the license "boilerplate" if you have the SPDX line, so
these two paragraphs can be dropped entirely.

You might want to add a copyright line though, lots of companies want to
see that, don't know if yours cares or not :)

thanks,

greg k-h
