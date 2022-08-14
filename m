Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6152C25B06
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Aug 2022 10:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiHNKmS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 06:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiHNKmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:42:17 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC312AED;
        Sun, 14 Aug 2022 03:42:14 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id F206F100D9401;
        Sun, 14 Aug 2022 12:42:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C984D325AC1; Sun, 14 Aug 2022 12:42:10 +0200 (CEST)
Date:   Sun, 14 Aug 2022 12:42:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Luke Jones <luke@ljones.dev>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
Message-ID: <20220814104210.GA22519@wunner.de>
References: <20220813092624.6228-1-luke@ljones.dev>
 <20220813105533.GA3258@wunner.de>
 <56171d4f65c02d3cba64d2f6d49e190107c12a18.camel@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56171d4f65c02d3cba64d2f6d49e190107c12a18.camel@ljones.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 09:09:43PM +1200, Luke Jones wrote:
> On Sat, 2022-08-13 at 12:55 +0200, Lukas Wunner wrote:
> > On Sat, Aug 13, 2022 at 09:26:24PM +1200, Luke D. Jones wrote:
> > > Support the hardware GPU MUX switch available on some models. This
> > > switch can toggle the MUX between:
> > > 
> > > - 0, Dedicated mode
> > > - 1, Optimus mode
> > > 
> > > Optimus mode is the regular iGPU + dGPU available, while dedicated
> > > mode switches the system to have only the dGPU available.
> > 
> > Could you please integrate this with the framework provided by:
> > 
> >   include/linux/vga_switcheroo.h
> >   drivers/gpu/vga/vga_switcheroo.c
> > 
> > vga_switcheroo will then automatically expose a sysfs interface.
> 
> I did investigate this first before submitting. The way asus does it is
> not standard at all. On switch you must reboot, and the change isn't
> reflected by the ACPI get method until reboot. It's very reflective of
> how they used dgpu_disable to work around windows issues that we do in
> Linux by removing the device from the device tree.
> 
> The key thing is a reboot is required. This is not done on-the-fly. I
> have a two year old GX502 which has the same method as exposed here,
> and also a 2022 TUF laptop with same method. My understanding of this
> pariicular method is that it isn't the same one as what Nvidia is
> advertising, and ASUS is perhaps misadvertising it - the suspision is
> raised by the fact that my GX502 machine predates what Nvidia is
> advertising.

I see, thanks for the explanation.  You may want to add that
background information to the commit message if/when respinning.
Indeed vga_switcheroo facilitates GPU switching at runtime,
not upon next reboot.

Thanks,

Lukas
