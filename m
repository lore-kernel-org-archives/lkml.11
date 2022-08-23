Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D891FC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 18:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiHWSKV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHWSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:09:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010685A9F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:18:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sd33so7100050ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qBmENqBoQXy/+aSofPNfjZLLSbSwHzLJ2Q0dBEjqihk=;
        b=c2nbAKyW0RV/CCqHslllWFfK+HE+RggEN0oTuMFboUEuR3vdgq3130ADGjsOBvd1Ea
         kzXkYpD/Y/x/Jtk6QnD392r4MCN/i+u1seTWeYfdY1XOY1mCtMXhzyiFiwpbieajUNvv
         x2wCzv76IXxenL07SlB6L8U4jlW69Oyo/3gdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qBmENqBoQXy/+aSofPNfjZLLSbSwHzLJ2Q0dBEjqihk=;
        b=EMZI0IAOtt9vz2UTWh7HsvouXSDa9L6iYTqQAct/hIbYDstNgLej0FN8LTDcK07I7A
         mlPB6GdAjzG/fYEouojHyUdHPgMKsq9kx+IwUmFHDK4IZXGkHm6Xyfb81emALVKey+8q
         6qIjsc8qxD+3d3r3C7D1T1RVvMS5LtpGeGpAa2LaCtUlwhyeOT0kqKvOe6UnNjpzGlsH
         R0g6HipbE8wJd5A/c6Da4yKflMrGP+sjY/znv9rKZnnruAhWdwTkzqDaAKsO925nR0Kr
         HdCvLqJjh4jHmljLqIMbDrcrXVymKkYiuU0yoJXUlUJTXoni7LMEK3XIPFGa6/NKoUxk
         NTaQ==
X-Gm-Message-State: ACgBeo2rO/vjuN05OFtaVCXxsdUb+b3E71TzBUnR6+jrhQEp3ED+rNVf
        ATYdiALHud2jDt4RjRt4Wj2OBFgKXQCVS2C34x4=
X-Google-Smtp-Source: AA6agR4k9gznmKJP5YE9oIQZRzi8uZhr5ab8+6PKfF67EW9T/RTvndbQkKLQjTSx1cU+SKYvtJqxIg==
X-Received: by 2002:a17:907:9694:b0:73c:4e5c:fd33 with SMTP id hd20-20020a170907969400b0073c4e5cfd33mr225101ejc.331.1661271502010;
        Tue, 23 Aug 2022 09:18:22 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b007314a01766asm24865ejv.211.2022.08.23.09.18.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:18:20 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so8010034wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:18:20 -0700 (PDT)
X-Received: by 2002:a05:600c:5114:b0:3a6:1ab9:5b3d with SMTP id
 o20-20020a05600c511400b003a61ab95b3dmr2650530wms.93.1661271499947; Tue, 23
 Aug 2022 09:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220720052841.1630-1-steev@kali.org> <20220720054152.2450-1-steev@kali.org>
In-Reply-To: <20220720054152.2450-1-steev@kali.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 Aug 2022 09:18:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9Z49Qmw+Dy7C7x=c5k3NjmqaoRxbU+1BJEje3t-SW7g@mail.gmail.com>
Message-ID: <CAD=FV=V9Z49Qmw+Dy7C7x=c5k3NjmqaoRxbU+1BJEje3t-SW7g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: add IVO M133NW4J-R3 panel entry
To:     Steev Klimaszewski <steev@kali.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 10:42 PM Steev Klimaszewski <steev@kali.org> wrote:
>
> Add an eDP panel entry for IVO M133NW4J-R3.
>
> Due to lack of documentation, use the delay_200_500_e50 timings for now.

Doesn't actually match the commit, which uses "delay_200_500_p2e100".
Fixing while applying.


> Signed-off-by: Steev Klimaszewski <steev@kali.org>
>
> ---
> v2 - actually mark it as R3 in the change, not R2...
>
> I'm basing my information gathering off what I could find for the IVO
> M133NW4J panels on panelook.com.  R0 is glossy, and mine is not.  R2
> says it is discontinued, and I am just guessing that I have the R3 as
> the Thinkpad X13s just came out, roughly a month ago.
>
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 5024ba690abf..870b98041c60 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1883,6 +1883,7 @@ static const struct edp_panel_entry edp_panels[] = {
>
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
>
> +       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),

I resolved the merge conflict and applied. Pushed to drm-misc-next:

0f9fa5f58c78 drm/panel-edp: add IVO M133NW4J-R3 panel entry

-Doug
