Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF94C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 17:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiF3ReZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiF3ReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:34:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4530F43
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:34:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id be10so162112oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BWbLJKNt5MQqNM+YkZAOKbF+2rTK0qxaILnlQmPjQL4=;
        b=RPsUGVKyrgf5xg0jcnzE7QB2dirFT0xK3s8TYFJ/rLTSjzy1/dXyAUJ6hsrGo0AgK3
         0CjbgD2BEaoPuX60nr6hxj0ezhnyYUT0JWa6ZFksc0onWBUOEkydiBAYyy/Tzrxq7gAI
         SkKxMDeWtegmW0N9vlbSiI3KYxzTKrTx+Kj8Z6ENoXTAViJA3vn8/djDjj8JIsXgklIU
         yeZ4shPeFr+/qpuE7zcGcRjRsXvNUQNFdRmNwA1wcFm9REPxg6dK+16MzTXQLqarCl9O
         iGFVdIyvcm3yegLnMSgzaYXgBk3I7ru2A2CE37rdIPZgPHp3MYJAkLLzQSwvfiJvlyjp
         +mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWbLJKNt5MQqNM+YkZAOKbF+2rTK0qxaILnlQmPjQL4=;
        b=yVY1smC9GyUuAS7r5oWBnfcl2oONOD5Ygje2vWO3ehmYHVflbBITwp9KdXMMkWsISY
         PBk9AInuZHALH1p2hJ/u4P97IVlLU74q1KVKHNFLBAOlheSY6xTqdlBEILj509KKVkFT
         NIosVsYEh/6ZYX6cDJ3rptdlOqa6BZVAxbC447g3mWuuFnYmrEp7Ilqk367RT3vAolp0
         Oab46671BlDeZW2oKdTOFcA+IS4XF2IT1S0ZPm+PU1MKMy4sxnMyrRuKWo+z5ID1NcRT
         hlwTXQoqnw07ei2OkaQg0X2KVj83Z52HEKoT2guXX3aIhE5bnQq0gqnOAXzUsSl/u9+6
         xLzw==
X-Gm-Message-State: AJIora8SuSswMIR33gPAAp4zHspwKxiKkHhO5YiIbO8KOPHeDfDXp9pf
        58y+s5XmEvj4oIXkeQ+Dfx83yQ==
X-Google-Smtp-Source: AGRyM1vEwKk6VMtJ6yfaI/N6IBF1oh91SChmbChO4mduVSAvClPkYqXQsh5Dy17rYEmcMyschR/Jkg==
X-Received: by 2002:a05:6808:94:b0:335:98f6:2471 with SMTP id s20-20020a056808009400b0033598f62471mr5801516oic.148.1656610460711;
        Thu, 30 Jun 2022 10:34:20 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id q10-20020a05687101ca00b000fb2aa6eef2sm13182533oad.32.2022.06.30.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:34:20 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:34:13 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH 3/7] media: hantro: HEVC: Fix chroma offset computation
Message-ID: <Yr3elVvJDfISzA3U@eze-laptop>
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
 <20220617115802.396442-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617115802.396442-4-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, Jun 17, 2022 at 01:57:58PM +0200, Benjamin Gaignard wrote:
> The chroma offset depends of the bitstream depth.
> Make sure that ctx->bit_depth is used to compute it.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index 9eac133bda68..8407ad45b7b7 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -12,7 +12,7 @@
>  
>  static size_t hantro_hevc_chroma_offset(struct hantro_ctx *ctx)
>  {
> -	return ctx->dst_fmt.width * ctx->dst_fmt.height;
> +	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 8;
>  }
>  
>  static size_t hantro_hevc_motion_vectors_offset(struct hantro_ctx *ctx)
> -- 
> 2.32.0
> 
