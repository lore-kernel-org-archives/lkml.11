Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF25CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 19:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiBYTBD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBYTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:01:02 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC67914A214
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:00:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a23so12633991eju.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuoHZFfe4VhL+9akOtIr8uKsSu1XQ7Boerqjey2wsS8=;
        b=F1T2/ffVJigokYSZwybQUxcRrHW3LhIlcc53+SXarX+KTYiMbNhjWznF3iQxXyJwxX
         qGrOJCWxjkL4Bx06YQW68r96u56ExR2i0XwRzZkFhg5Tx1G5PBifPkxBj3FrGfNR9EFK
         wA5Ye15pi2tpo3OJdpKWdmu3WLXVqrPQ0j2681XrHuQat8IS4CbY3UwKH4kMKTshlnMr
         D1ozhDGQUA+xqyqBJFHbwS7/wmgd/PLWQ2uMfM3wDjBrfXqBAOaEf59tt3mA2a787gYp
         hVH33KrOoNWfZN5TrfUAb8EvMRfRGhgvfgvXqINqIRQTmQMIX2++NA7IzB1+ApIN+fa4
         XlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuoHZFfe4VhL+9akOtIr8uKsSu1XQ7Boerqjey2wsS8=;
        b=BoB85RSn/xFDbSGvOBMafhTK8Q0gcDXV4NzTVIoX5hneHM27rKEahcyROmLwK5rkg2
         oiRbjvQLCidhEqc3rC3iK1hpW2r6W/ecomf7r029D1Gs2JNOGcL8ufwjTCFu3qhRfwJU
         4K+iRUxDvFfwbX2B16cLdZyzZlpGAb4v/LlFia7W44wWgu1VvFCnlkewsHfaYWiyTxpx
         L6WSoamL5gH4LSzXU7CM4BwY6T/6wrtNg8ScB9vxUp0urwxHLKsIDKNVllVXrzRTclaL
         m8AbDI4eXtqqzNUHNneV2DxVyUZEHWpG8fHFf30Zk3WIDja+B9xf20ARICYkOaoRgLzx
         FjfA==
X-Gm-Message-State: AOAM533vDA+CdsfTlCDaPFLo1HjEcyr1AYmm13FVKkvIn8CWezVJjWK6
        +M6IDmn0mU9tMBBavIMUo3DrGeP6eKjcaRNC7ceVIA==
X-Google-Smtp-Source: ABdhPJwyyA6g1SrYGeLDPJvmc5qMeT5+R08f+J0eSJ9AbDl4H3y46+ZP1o+DC8gOvHrr/YnMznJIEPcVqn89L3OKy/8=
X-Received: by 2002:a17:906:2b97:b0:6cd:6d67:ab5d with SMTP id
 m23-20020a1709062b9700b006cd6d67ab5dmr7244075ejg.723.1645815628341; Fri, 25
 Feb 2022 11:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20220225101520.3188373-1-shraash@google.com>
In-Reply-To: <20220225101520.3188373-1-shraash@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 25 Feb 2022 11:00:17 -0800
Message-ID: <CABXOdTcMj_=XqTnTiUmT8r585W2N2-12ddg4OGDHpwaiTp-Tjw@mail.gmail.com>
Subject: Re: [PATCH] mfd: Avoid unused variable 'atmel_flexcom_pm_ops' warning
To:     Aashish Sharma <shraash@google.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 2:15 AM Aashish Sharma <shraash@google.com> wrote:
>
> Fix this kernel test robot warning:
>
> drivers/mfd/atmel-flexcom.c:108:32: warning: unused
> variable 'atmel_flexcom_pm_ops' [-Wunused-const-variable]
>
> The variable atmel_flexcom_pm_ops is unused when CONFIG_PM
> is not selected, so marking it as __maybe_unsed.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>

Reviewed-by: Guenter Roeck <groeck@google.com>

> ---
>  drivers/mfd/atmel-flexcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 559eb4d352b6..33caa4fba6af 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -105,7 +105,7 @@ static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
>         return 0;
>  }
>
> -static const struct dev_pm_ops atmel_flexcom_pm_ops = {
> +static const struct dev_pm_ops __maybe_unused atmel_flexcom_pm_ops = {
>         .resume_noirq = atmel_flexcom_resume_noirq,
>  };
>
> --
> 2.35.1.574.g5d30c73bfb-goog
>
