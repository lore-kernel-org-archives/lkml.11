Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E108C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 15:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbiCOPkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344745AbiCOPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:40:02 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D342492
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:38:50 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so24860271ooh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=khkCTdEEAM7n3P/dQQhrb/HV8J+XYUq5hsAldrDxFGU=;
        b=Nqk0+w29LeOBvre06Fj4cSdo88alwYbpQrE+cuLmk5f/K9gWWBedX5rt1Gkw32yySC
         KeYyPDFEEkoNdevG4aBMWC9xva1lFOR4D4pD06KXSuzSoFcA8ZHr1eBaArzWozJDhcq+
         HrJBnQFdPnmY5Bds1loQdvMF+tunMSlaz/Yak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=khkCTdEEAM7n3P/dQQhrb/HV8J+XYUq5hsAldrDxFGU=;
        b=MMTDQxM2kFNke1ktLGiK+o3lIxo1EcA1Cxp1uhNNm+kYPvlYu2h1RRq1I+kqSheKUW
         A+UNRN06pvzsgA30dK8MnTRWbweTazx/DPuFMyuWRW5YBWr3hQZJioa5YP6y/t/gHxqm
         z4QudyCk8+IAkUWCzN55Ye3Rm3T/EoJaQRU0J6FJt8JSSIeLZ1jhStAIkm347Mg2sBTy
         fbOo5ipWa9yhK9MwPVk4anTq2224eCHBTWV4EnWHgNr9ws3uoTCa98oab8AHwrZWkP5u
         LHeZdIRE/BTboBdEtt4TOA88mIwFlU4Q/ib+02DjF6+D32PQEURodueePD2M3AM9TW0m
         ydsg==
X-Gm-Message-State: AOAM532F4ecaiQoPQMONUWfJh6qRJi+7UA4aOGpmT66awg/pEBdRkeSq
        QMv5rdJCb6zy0o/11Hi82Hr/2+aqmPtl1bU5pKU+Fw==
X-Google-Smtp-Source: ABdhPJws5kjn3G32odVO46AOfForEvxatvad2ia/nqZQ+oT27yL543G4RC11InOG91OxbM21TdaCswYoYg/ePOwb5wQ=
X-Received: by 2002:a05:6870:c0cb:b0:da:2bcc:aa09 with SMTP id
 e11-20020a056870c0cb00b000da2bccaa09mr1799556oad.63.1647358729890; Tue, 15
 Mar 2022 08:38:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Mar 2022 10:38:49 -0500
MIME-Version: 1.0
In-Reply-To: <YjADP+8mNnlkcGF7@google.com>
References: <20220314232214.4183078-1-swboyd@chromium.org> <20220314232214.4183078-2-swboyd@chromium.org>
 <YjADP+8mNnlkcGF7@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Mar 2022 10:38:49 -0500
Message-ID: <CAE-0n53waKNBBvxiK-Odff7fd+BEaWR1-3UyKSAK8dTzGksgbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tzung-Bi Shih (2022-03-14 20:08:47)
> On Mon, Mar 14, 2022 at 04:22:13PM -0700, Stephen Boyd wrote:
> > Add a binding to describe the fingerprint processor found on Chromeboks
> > with a fingerprint sensor.
>
> Nit: s/Chromeboks/Chromebooks/.
>
> > +properties:
> > +  compatible:
> > +    const: google,cros-ec-fp
>
> Not sure if it could make sense for FPS with other interfaces: would
> cros-ec-fp-spi or cros-ec-spi-fp be a better name?  I am wondering because
> there are cros-ec-spi specific properties "google,cros-ec-spi-pre-delay" and
> "google,cros-ec-spi-msg-delay" in the binding.

The delays are optional properties so I don't see much value in encoding
the bus type into the compatible string. It would only help us find
properties that are unused on a bus that isn't SPI. Let's not
overcomplicate things.

>
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: reset signal (active low).
> > +
> > +  boot0-gpios:
> > +    maxItems: 1
> > +    description: boot signal (low for normal boot; high for bootloader).
> > +
> > +  vdd-supply:
> > +    description: Power supply for the fingerprint controller.
>
> To be consistent: s/Power/power/.

I fixed the other two, thanks!
