Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A72AC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 03:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiEYDdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 23:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiEYDdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46D77F2E;
        Tue, 24 May 2022 20:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E9A560E26;
        Wed, 25 May 2022 03:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431D3C34100;
        Wed, 25 May 2022 03:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653449609;
        bh=/3mCiceS1LkYBHMvE4U6h0kEyWQEeCNrAyqF7kpGXPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cd8qvEwRO1nrbGI1tUHX75JI0NQ3JjRWVtSlA+v6198CJG867QhtnR+DAvAkASDfQ
         OA6uDhZ0pnDP1kG3GARZudKkSyHPaPR3h9XKn/m/rCy4zNi2tgBmPSPsS7h7WFnYIe
         MEL3pJHEa3yBcLy+tFoQtA93vn/bxfCEFfiNESUlr5caKK/fOTsW4YhoQChzzEbzdz
         5ukyDemvSVcTNpSxHoNllP1b7vJZpXA2VPOfRK54WdkQcgN8XZhGBBiRQIKPrGmzGV
         J/fcnYvoTJyDpw3lTLFIE/ecd/Z6puxtf5mdNUFM4/0Qe+mShfnQRrK6ws0pJXU+bj
         7yYhzq0Hrt4Yw==
Date:   Wed, 25 May 2022 11:33:25 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 4/5] platform/chrome: cros_kbd_led_backlight: support
 OF match
Message-ID: <Yo2jhTpsa5Vw4+61@google.com>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
 <20220523090822.3035189-5-tzungbi@kernel.org>
 <Yo07IDqYuQUzeL+N@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo07IDqYuQUzeL+N@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 01:08:00PM -0700, Matthias Kaehlcke wrote:
> On Mon, May 23, 2022 at 05:08:21PM +0800, Tzung-Bi Shih wrote:
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id keyboard_led_of_match[] = {
> > +	{
> > +		.compatible = "google,cros-kbd-led-backlight",
> > +	},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
> > +#endif
> > +
> >  static struct platform_driver keyboard_led_driver = {
> >  	.driver		= {
> >  		.name	= "chromeos-keyboard-leds",
> >  		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
> > +		.of_match_table = of_match_ptr(keyboard_led_of_match),
> 
> You need to put this assignment inside an '#ifdef CONFIG_OF' block,
> otherwise the compiler won't find 'keyboard_led_of_match' when
> CONFIG_OF isn't set.

It doesn't need as of_match_ptr() already guarded it.
