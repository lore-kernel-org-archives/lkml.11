Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8C1C4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 12:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiCGMTQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbiCGMTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:19:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1235D642
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:18:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z11so10469405lfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ir/rPEzTgBLKB8JMU8C+SpZVAErsjWczEwy3W0PY9us=;
        b=NAi9Hp76EZ0pg4WrnyReVA+F7lei8tkpibMWNH21fjc57P+SJgE3Xgk4S0GFafjgB+
         gIFfuXwI7r38wU64qeUsHVsaUewPetwyvYik6XcX8z8DV2pJJ+6Y1GWmQFK495DZOqGl
         1oLxIeyFAFXKC4+df6C/B0cQ4lzb7Qq9GxBwjP0mLP2FEOmuLRjWYwaMjCN1QVMlBIhV
         uu9b27aKEI4bWIzlPaXUpLLl+aSoMHceenNXf8zitHEUsfdiNAtGo9opE5LhVYaEl/+p
         zu4Mbpi2qkfWlN3nDlZDsujXHEQTtNqhRQ0FzAN2KyAys19ogoXR7lB4AiPXVCNvFBfv
         /hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ir/rPEzTgBLKB8JMU8C+SpZVAErsjWczEwy3W0PY9us=;
        b=bWAmzuGUq6ZWLcTQ3Ei/eleN46qOPUvMZLtZHAG2IjDoNVasghRJjxe/Tv8ZvWnXCo
         mFL8LBg48nhd51UotzWljVEyuCU2SD3Y17Pej9zJrpVFfS8k0sRsbHyjJhlx4KNSvwef
         uesfug0G50aWf3id6/GcgLKcCJ40sKMGOGtJ9L0aHsZrJtvORCcIpMspdHJc0LMg+zB1
         yHoB9hJdf+opdI27H7ZlDmLpAamW2iiA8QL0xgFF+JehcD5upbQA38sBe9aUykl8sXZn
         KQJjPUrQRCLN7l4o2YgZvoi4+cNmBaoeQ7WYO23QTOIs4BBB/3XueindB39+jSC1DlC5
         qqTA==
X-Gm-Message-State: AOAM53317YRpB1mbJ4YKj6lBeCgn4tE+RCNYPBPuk8/npmtPih25/wYD
        dVDXkRM4dhey6ldeeRUz/w241hqHWH4eQAbq6BnTMg==
X-Google-Smtp-Source: ABdhPJz/PIFiiW6ET6enYPE2YnpMXMFruAGL0j5yT0Z210W/RQmAZibs1/nuAT2qmU93HoHUPgWF8feZ2nDStus7cEU=
X-Received: by 2002:ac2:5f0b:0:b0:448:1e32:4531 with SMTP id
 11-20020ac25f0b000000b004481e324531mr7445670lfq.167.1646655484705; Mon, 07
 Mar 2022 04:18:04 -0800 (PST)
MIME-Version: 1.0
References: <bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Mar 2022 13:17:28 +0100
Message-ID: <CAPDyKFpyhS2poZj2E4oYfGOSoH6AuiUnL79_6-mozg5hxcT2gA@mail.gmail.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     cjb@laptop.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2022 at 18:44, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A dma_free_coherent() call is missing in the error handling path of the
> probe, as already done in the remove function.
>
> Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I've not been able to find a Fixes tag because of the renaming of
> function and files.
> However, it looks old (before 2008)

Let's keep the above and monitor what the backport process reports.

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/wmt-sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 163ac9df8cca..8e18f01c0938 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -863,6 +863,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         return 0;
>  fail6:
>         clk_put(priv->clk_sdmmc);
> +       dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> +                         priv->dma_desc_buffer, priv->dma_desc_device_addr);
>  fail5:
>         free_irq(dma_irq, priv);
>  fail4:
> --
> 2.32.0
>
