Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA20CCA481
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 14:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiGSOU7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiGSOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:20:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA950DF42
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:02:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l23so27378526ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschuetter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3xwuq8Pneb87cu0HIZ51LWMdCp9Wx/NZy613KhcwAGc=;
        b=OXo3fPsqfwTwlsjfr7CxRemIhEaTYBBssFzAZx5c+jE/84/splHTnq6Wldghao/4f5
         nI9vNLpIquUM8ARoB5ejuGuN7Z70ZWSXzAIc/BkgkvrupXtNOw9IXUZPiY+z/4e9yyzd
         Q3BKOx4n8s9PFBrDGR613qFkrz7J4ubb6/Il4GvlpG8Vet/ecLX4g/yq3L49TL2hQ63/
         5WoZBU8Xnfl4G9LJXBbZpFJsVTWASf6Z6tysJONLtG/A+icHwMElMcXjzk+JcZHGpirm
         9t8P0yyOcSgbYMqiCQTHi9bhueP4Lib2YzkjOVkYzeZezeJLLEEnGezMybw0JgORVBPM
         2jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3xwuq8Pneb87cu0HIZ51LWMdCp9Wx/NZy613KhcwAGc=;
        b=gqtLBO7iPNDdcngu3IYUHbDLpd7BGgGpjCBET/UeeG+VZ26Ha2RWWZwPZAtEoS/dTt
         E+7KpVEgXHbd92vkFZ8Z61rj68fTo218+RezYDMItMIS5rEOPd5YxrvyEVO9m0zwjBp5
         fz2S7AfuEos1jAArhWN69DLR84s5h+68EcxGlII9UcDD7natkvFPFmms8iHB9DpCnK72
         2jWHnAeqkZwWHh0zUU4KSmgnVzuGd8AMJNLdh8Ak3t1pnM/CqlMTddqlNbha29CIooa+
         epgfUDQDbn9zOGVzZTaLt4g0mjZc6YEnys0dh42nNB5RKc3jEjHKZCKcXa/QC67gVBzq
         ejGg==
X-Gm-Message-State: AJIora9krOuZlo2HTuIAWA07EzNlsVIXrL+5hdXZZ6pZ0uXdJeouNcBY
        o8Q+U5wOw1wM2adr4eSNLM5GSOx9OoXAeTiT
X-Google-Smtp-Source: AGRyM1v9DWQixLRI1UkJzmYuo2VcxXbf8p5Qs0TByTRv9xTcx3bMOl0sXNYt2OWueRJ1Z5jLPHk4Pg==
X-Received: by 2002:a17:906:7308:b0:72f:3294:8002 with SMTP id di8-20020a170906730800b0072f32948002mr9533462ejc.311.1658239361389;
        Tue, 19 Jul 2022 07:02:41 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709067c1200b006febce7081bsm6715986ejo.163.2022.07.19.07.02.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:02:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
From:   Christian Kohlschuetter <christian@kohlschuetter.com>
In-Reply-To: <Yta4NGGYyZ6Doglr@sirena.org.uk>
Date:   Tue, 19 Jul 2022 16:02:40 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11E7A207-E920-4334-8F13-8DA95244D5A7@kohlschuetter.com>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <YtVTyzLREdkzYiKS@sirena.org.uk>
 <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
 <Yta4NGGYyZ6Doglr@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 19.07.2022 um 15:57 schrieb Mark Brown <broonie@kernel.org>:
>=20
> On Mon, Jul 18, 2022 at 07:24:37PM +0200, Christian Kohlschuetter =
wrote:
>=20
>> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
>=20
> You have an umlaut in your signoff here but not in your e-mail address
> which causes tooling to complain that there's a missing signoff - you
> might get some complaints about this.

dang! Thanks for noticing. I've just sent a "rebased" patch.

