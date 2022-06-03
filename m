Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E0BC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 16:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbiFCQoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344067AbiFCQob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:44:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7F44A3C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 09:44:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q1so17007314ejz.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8r/Lq2iH7lYUmC0qatILVQgk9vw3F/w16dF324mtWQ=;
        b=aZlpQAhecEI0B2kIC13P6x5Zi7SorObmX+eb4jK0LAIcvjFVxb0rxdh8NWqIqMSb7C
         Cfi4cEWw9aU39jvI2EkYKPTIqnlf8v2wWuanJWLAdi8Qmt7BGJMMLaktaKXmXK68JJRn
         bVI93mA/fdSToI5gpY/F2yumxShwPXRk5yjhc/qrABZmgOCPzaEeZv8FA6SYeLNPf4DU
         VZUBPgyyucalsVPqbohS5zxrscV8lzfGHitArpA+xclaMvrOYh1VW1QzzJRT/r4cwQbh
         +tzPOLZq7bDdKrXfbELBNy688C6F95mG2j6aIbAvBDK7BmdbMaWS790KVvPP6pUOgSAq
         sxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8r/Lq2iH7lYUmC0qatILVQgk9vw3F/w16dF324mtWQ=;
        b=ZvyEArECInPOQecJS8jnisoP5C+ihj5vAabvgsmnvmm0XX3Qg2o7aLu8bg06MdGac/
         ZG5PssJg0zpNim08OFh71wxu5QZlGOLiGg24gy8MF/0fILhQf0yHp3SKdIcHx8Hj52Zx
         qDWPQ5QLMswhb+/81/6hHnL9TZam/pCVHiThQDK2bCafFbhzDFXjR9SCmrmxZDeFKZwr
         1p9d6VXncFxn49QMBrCQGaXtC3cEYyPA7InvZG3q4bvZYBpoAU/DTS+i1PiOqMWjL/8S
         LweERxdz4NxR6Spqwo/5ovkCKlkcAcUO6kYYNdty9ZjY47mpkCiB2dkFf2vDWq+4SmrP
         kerg==
X-Gm-Message-State: AOAM531WHIWzAs5dtgt0Xs3+xFcrF6QaVZnUqHK0kEN7VzWr03KaQSt4
        bqXuSpQTD3viDXibaSf5fAkNg39/CNJ1ySoTZZK52A==
X-Google-Smtp-Source: ABdhPJx7yM9xyk1/nxIev8AjizxzrThcBDzqhNNV9o8uXxQGxlx8Dciv8+BIp9+EOrN+IcDkDlsEmboiXQXOBpz+JKg=
X-Received: by 2002:a17:907:8689:b0:6fe:e525:ea9c with SMTP id
 qa9-20020a170907868900b006fee525ea9cmr9489496ejc.720.1654274666765; Fri, 03
 Jun 2022 09:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220603131043.38907-1-linmq006@gmail.com>
In-Reply-To: <20220603131043.38907-1-linmq006@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 3 Jun 2022 09:44:15 -0700
Message-ID: <CABXOdTdZNBM=RA_72bL8nua=qajRWD3iKEDi3bai+Aghu1ygJQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chrome-platform@lists.linux.dev,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 6:11 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: b6bc07d4360d ("ASoC: cros_ec_codec: support WoV")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> changes in v2:
> - update Fixes tag
> v1 Link: https://lore.kernel.org/r/20220602114529.6303-1-linmq006@gmail.com
> ---
>  sound/soc/codecs/cros_ec_codec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index 8b0a9c788a26..11e7b3f6d410 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -995,6 +995,7 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>                         dev_dbg(dev, "ap_shm_phys_addr=%#llx len=%#x\n",
>                                 priv->ap_shm_phys_addr, priv->ap_shm_len);
>                 }
> +               of_node_put(node);
>         }
>  #endif
>
> --
> 2.25.1
>
