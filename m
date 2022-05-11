Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA5C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 03:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiEKD3d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 23:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiEKD3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:29:30 -0400
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C732415F6D9;
        Tue, 10 May 2022 20:29:27 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id B75EC4405D7;
        Wed, 11 May 2022 06:28:13 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1652239705;
        bh=hLkOr9Q3wOOxVxVqfRPVJC9npyiSf6OayQQDHuAhlug=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=rVQoBExujuCZYosFgWxBdp2r/XDI/UPoL+0AslXUaS0tcPrBtQZlOFULsi5kGucjQ
         GRrjAZ2qOrIiD+38mxyDTCLvsBtdrd59kZPin/o7C2FCrtUArzqujf3P9QwCiXKleQ
         vXi4P47nmvBRYZY2DI65/4nLroL0/TEwdnu0e4EQs3HOVsD0wHujStZt3Oxff98PNr
         /xVHSoUPDJXjkHqWZYQs+WNyxIsEuiaFlXQCBA24sQv0yifez2uifHdCKtltaWB9h0
         2vXSKiwW4Ye1KJ+HqGuPz6pbUvQkINHvXe+u2ySUZnpF62ERotkcyX5Aql1Q+xJm/F
         9+ppGVxEoqZqg==
References: <20220510171003.952873904@linutronix.de>
 <20220510171254.655035023@linutronix.de>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [patch 05/10] clocksource/drivers/digicolor: Convert to SPDX
 identifier
Date:   Wed, 11 May 2022 06:28:23 +0300
In-reply-to: <20220510171254.655035023@linutronix.de>
Message-ID: <87h75w9285.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, May 10 2022, Thomas Gleixner wrote:

> The license information clearly states GPL version 2 only. The extra text
> which excludes warranties is an excerpt of the corresponding GPLv2 clause
> 11.
>
> So the SPDX identifier covers it completely.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/clocksource/timer-digicolor.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> --- a/drivers/clocksource/timer-digicolor.c
> +++ b/drivers/clocksource/timer-digicolor.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Conexant Digicolor timer driver
>   *
> @@ -11,10 +12,6 @@
>   * Copyright (C) 2013 Maxime Ripard
>   *
>   * Maxime Ripard <maxime.ripard@free-electrons.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
>  
>  /*


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
