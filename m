Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA05C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 19:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiCZTJX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiCZTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:09:20 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A1C14
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:07:40 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id l184so5957045vkh.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+ZMgF8rHzqNlDkErLZI/DheSIs9iRBaxXLkva+BiWM=;
        b=MD7VvaQZmHal8Xv/fx01kI1KmByj2fQOUC5MgJ6KApMYVC8a8wU+KoSpFvPXYq0TGZ
         zZ2tBixUPv0UFU5ecP4ePgSX6FGzi52qYj9VBVhnrhp4+XRO0qCg8aKY50WPgsneX8/c
         105dltBOkBstFSRzmSwraSUeA6g4EIHpqMS2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+ZMgF8rHzqNlDkErLZI/DheSIs9iRBaxXLkva+BiWM=;
        b=tS/1gv3VmN5HM4792CAWznjt6PGRRZ2344wFy9RpXnFCdePNkHiic3cPBME9wjsWcK
         mRgmQRXGi6ncujxAGmVNd4VmgygxD01RzZOSbH1qK7uC3Jdv95P5uRDtCWkSjpR188A1
         mSCMKiqdxrtF66ypHo3uP8oJNucluwTHhBlWOrUSLNtcUyPgEzYKRtYPz8VwrO9+L/DY
         GyxbORm8vJk6nqmoeV3k3hvakdFFhkj+dEso8F/7ecyHrOeFmU0EeBIoTEVcrWBWnApK
         zXUvilih88iXDAx1QK7Od5zx/5nVGq+suHaMLUAZfNjVOEbX/uqCeApUfQkU7EgvmopY
         xwKw==
X-Gm-Message-State: AOAM533AalWb7l5c5bVcKn1BzgtcbHpGMzTFRC1YZmibBO/5snQ/K0SK
        7V6wm+0DtzpMTSb5qnAMsw3s/5vteNg/qQCjDTFMJvPkYzQ=
X-Google-Smtp-Source: ABdhPJz7w1eEIH1Yjli6v9gw/q4r6yOcjoplh2ugVMhe4rGKmJyp/buoks/Yv7HcJOH7R6CVnmvS6bbI6l+0An3OS2U=
X-Received: by 2002:a05:6122:1245:b0:33f:e889:f353 with SMTP id
 b5-20020a056122124500b0033fe889f353mr5624016vkp.17.1648321659222; Sat, 26 Mar
 2022 12:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220326073326.3389347-1-yangyingliang@huawei.com>
In-Reply-To: <20220326073326.3389347-1-yangyingliang@huawei.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Sun, 27 Mar 2022 03:07:13 +0800
Message-ID: <CAJMQK-hA+k8hsQiBq7v9QROQyDkrzy+J40b2uF4AcmrXDe0gKw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: add missing destroy_workqueue() in anx7625_i2c_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xji@analogixsemi.com, robert.foss@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 3:24 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Add the missing destroy_workqueue() before return from
> anx7625_i2c_probe() in the error handling case.
>
> Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through aux channel")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

>  drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 31ecf5626f1d..1895e3448c02 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2654,7 +2654,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>         if (ret) {
>                 if (ret != -EPROBE_DEFER)
>                         DRM_DEV_ERROR(dev, "fail to parse DT : %d\n", ret);
> -               return ret;
> +               goto free_wq;
>         }
>
>         if (anx7625_register_i2c_dummy_clients(platform, client) != 0) {
> @@ -2669,7 +2669,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>         pm_suspend_ignore_children(dev, true);
>         ret = devm_add_action_or_reset(dev, anx7625_runtime_disable, dev);
>         if (ret)
> -               return ret;
> +               goto free_wq;
>
>         if (!platform->pdata.low_power_mode) {
>                 anx7625_disable_pd_protocol(platform);
> --
> 2.25.1
>
