Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93697C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 12:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348235AbiCOMYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348204AbiCOMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:24:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23EA63CE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:31 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s25so26214104lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPnb1ATRmSI8xZX+veYE4aEfgSHzzxZV5zRVXcuyhkU=;
        b=MyzIMcUTwXxiaAMPib2hzET3b2cxFOda5RQjUnVvckRXHSqJouuvENc6OiZeEO3ztp
         HA9qUIM8jD4siqP0DvJW4clgq3NdrqWdX2g3rNEP4SAfZwQNf3Ijx5z/DA8wXLdArYXx
         OZfmRzA3CBNjxBzdCxoI0U12ok4oTTMCAlyxjqFXCCsvPhtJCDO7rO0zPyuepsqppvZx
         UJVuHW1nXQLNX67ohVhl1lYk4pm6P9/9z3wU1MTHEN5tBPstKXAGSbqpPtxaLMLvjiV6
         FGq8rAwXOZixu40ziJoyXF23TFGmu/feAktE2VO+dQ14wkxPGuPl0LILRZkXBbYUdlEW
         OkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPnb1ATRmSI8xZX+veYE4aEfgSHzzxZV5zRVXcuyhkU=;
        b=s+xMl383SnsOnzMOTf/vwMYGnBUizo2Xnl/IKbohc2Iv487ZWwW/i4KPYlCD3doGTp
         e2Vp08shX6SGaH6c00ocKteamlmgE36T2nzw4bbyV5NjxqD3zGY5P3nu/L1O/KBYD1zc
         vpimP/flBY+93pY4wCJ+1tZgBqpMcsUtpQRr3J9C5UINPFhiuzNBVWl3fbUMYUHl2GT4
         AW4Y1EtwX3Uu/eFLPF292WYi49vJdm0sI9YL/QTpoc3gI+Bai3X7KwzLOvWr/aaHJbEW
         GNOznj/f5D/kFZHlZv1HfNx2k2SiR63Yn5yIjsv4R06jULdQ75UaIJNY8PmLZhSBsyqM
         Yjuw==
X-Gm-Message-State: AOAM532gl4amuveSMhMUE6W4yfDsyImVFf7v7U6og4rVOaTpHJh1OQnE
        RVeCNwoLQKJM9re6FHfZuYF2f1puUqRMNkT+YRir8Q==
X-Google-Smtp-Source: ABdhPJzvZgzztoUTLaSHmueiCTGTfSPqCknLmUmw+wNq7wRGhWufTTo6/FZarCRlzAyJi8R7+Rl557qFFdU5IwbOkAs=
X-Received: by 2002:a2e:8603:0:b0:246:24c:b79c with SMTP id
 a3-20020a2e8603000000b00246024cb79cmr17459702lji.367.1647347009946; Tue, 15
 Mar 2022 05:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220308071415.1093393-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220308071415.1093393-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:53 +0100
Message-ID: <CAPDyKFoJXErrVyY3EJim3Yvn7ReeBzU5F+ic83KRBNJ1riROpg@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci_mmc: Handle error for clk_enable
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 at 08:14, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the potential failure of the clk_enable(),
> it should be better to check it and return error
> if fails.
>
> Fixes: bbce5802afc5 ("davinci: mmc: updates to suspend/resume implementation")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/davinci_mmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 2a757c88f9d2..80de660027d8 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1375,8 +1375,12 @@ static int davinci_mmcsd_suspend(struct device *dev)
>  static int davinci_mmcsd_resume(struct device *dev)
>  {
>         struct mmc_davinci_host *host = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_enable(host->clk);
> +       if (ret)
> +               return ret;
>
> -       clk_enable(host->clk);
>         mmc_davinci_reset_ctrl(host, 0);
>
>         return 0;
> --
> 2.25.1
>
