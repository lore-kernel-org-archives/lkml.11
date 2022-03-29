Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4741AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiC2QyJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbiC2QyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:54:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3D6211F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:52:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZF4r-0007Lb-Sp; Tue, 29 Mar 2022 18:52:17 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZF4n-003pBv-MD; Tue, 29 Mar 2022 18:52:16 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZF4p-000Azy-LY; Tue, 29 Mar 2022 18:52:15 +0200
Message-ID: <de355d97c4a5765e930e15e3392dc0fa97ac814f.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: make static read-only array channel_offsets
 const
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Colin Ian King <colin.i.king@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 29 Mar 2022 18:52:15 +0200
In-Reply-To: <20220123223417.6244-1-colin.i.king@gmail.com>
References: <20220123223417.6244-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On So, 2022-01-23 at 22:34 +0000, Colin Ian King wrote:
> The static array channel_offsets is read-only so it make sense to
> make
> it const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/ipu-v3/ipu-dc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-dc.c b/drivers/gpu/ipu-v3/ipu-
> dc.c
> index ca96b235491a..b038a6d7307b 100644
> --- a/drivers/gpu/ipu-v3/ipu-dc.c
> +++ b/drivers/gpu/ipu-v3/ipu-dc.c
> @@ -344,8 +344,9 @@ int ipu_dc_init(struct ipu_soc *ipu, struct
> device *dev,
>                 unsigned long base, unsigned long template_base)
>  {
>         struct ipu_dc_priv *priv;
> -       static int channel_offsets[] = { 0, 0x1c, 0x38, 0x54, 0x58,
> 0x5c,
> -               0x78, 0, 0x94, 0xb4};
> +       static const int channel_offsets[] = {
> +               0, 0x1c, 0x38, 0x54, 0x58, 0x5c, 0x78, 0, 0x94, 0xb4
> +       };
>         int i;
>  
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);

Thank you, applied to imx-drm/next.

regards
Philipp
