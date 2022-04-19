Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F937C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 22:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358226AbiDSWkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbiDSWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:40:09 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43CD344DC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:37:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x39so4212960ybd.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHvW+03ED2tYu4Zc1Qx/QXTIQqIJndOUJvkwVF3dUzw=;
        b=KC1Vt+5i5fAy2PedzcgEhblxFonWCsWxZpgTS3ljUOCjn93WSPU4jpdQBgWt3mjRF8
         41qJaRHQ+sEjHpeonxCeuEz7a8/lbqS3c2u9kkrNFPwCuIEcvp0JwKLJ/b5T9/B2E7up
         VSG7LmWs28u/snGIGkbpFnNxqMCX1ah4wXYQSyr/vhGaC9DpweEVspQNWhcgF1x5UKP+
         oLqNKs5v0v9VoV6RdMWBWE/ENlCV634aNlHybelCyX5NiakDK6uLkwnVbIe3SZ/kYArb
         mMGkuaDtTlUY6otE+kIax2JVTDq9ruMVWGWXR50C+wO+uJPr+NtPRbB1Eg7qU7r7OlOJ
         gEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHvW+03ED2tYu4Zc1Qx/QXTIQqIJndOUJvkwVF3dUzw=;
        b=ekt7QJLrRpl6qvtwGbdXOSxDw89Sren/szk2YhXMggul/NkIxtZBG8F0ZWICChmPIF
         CjFwNcWSlxDNYbm6X23huurXN8kecwzi4lqHkqlUdNBHQEhzsM1IZcylGIUBvv4lhv9k
         HAVZ92w9szIyDOIKlwL9qQFQ5yLI4qQNKisMZ9c3zsg8FgaJVAt6slPfKKT65kuSjTvb
         7nDhtZfRKlAC20wI2ZZJ4ssZ6OTvfUXU+r/byF7HRS2yLHxyQQlsID5Wyg2syEWHWrUb
         FFhil16yBq7VlXVja2y2eSSXWCGTAtQPHwGBdYcVE8XSkpZBaz/4q2phNkRR1vGAibmm
         pwWg==
X-Gm-Message-State: AOAM531cYPCF89B03s5dImYjmh7BfJFZxNw3Qj97R2cy3koEFBDNgtI9
        K7IicUyxaJIh5UIgWJ11epyEhKTbw9V5MeNgtmVRTg==
X-Google-Smtp-Source: ABdhPJx4/6P6ZK+hWY3bx2/guKCQWn8dYwnr5RG5P2rZ+wpt/zD6Cml54rdbvZGo6SimeEMhGwlprEEA8+tCwbNRQ/s=
X-Received: by 2002:a25:73cc:0:b0:644:f4a3:6f4f with SMTP id
 o195-20020a2573cc000000b00644f4a36f4fmr12801929ybc.369.1650407841127; Tue, 19
 Apr 2022 15:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220328005005.72492-1-kc@postmarketos.org>
In-Reply-To: <20220328005005.72492-1-kc@postmarketos.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:37:09 +0200
Message-ID: <CACRpkdb=V_ZbtRw8_wyTyKLPO1b4VtscfHCa_40Fd0hSABZObA@mail.gmail.com>
Subject: Re: [PATCH 0/4] rockchip: support configuring pins as input
To:     Caleb Connolly <kc@postmarketos.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martijn@brixit.nl, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

On Mon, Mar 28, 2022 at 2:50 AM Caleb Connolly <kc@postmarketos.org> wrote:

 Caleb Connolly (4):
>   pinctrl/rockchip: support deferring other gpio params
>   pinctrl/rockchip: support setting input-enable param
>   gpio/rockchip: handle deferring input-enable pinconfs

Those three applied to the pinctrl tree.

>   arm64: dts: rockchip: rk3399: add an input enable pinconf

Please submit this through the SoC tree.

Yours,
Linus Walleij
