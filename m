Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCBEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiGGUTo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiGGUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:19:42 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2B1E3F2;
        Thu,  7 Jul 2022 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657225179; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjIa6VCGeD+ksTrcQqfh2dLYucU0urZhX3yUpGkF3xc=;
        b=KaHF4/9ji/Pl7Q4Ldp9NVY0eJMtvhriRAjKe+0mLozVZ8pA64lkWk+Vl/gNmda2gSJAWan
        zLrPhWQWW3wj+lSm3DxLXUHSIJERZ4Re6/5fyuGMWQP/qdD/SApuiAVPtS1StzuvITTCCT
        zLclWuo5r7i4xqyKf1rK0+mJiNfiwig=
Date:   Thu, 07 Jul 2022 21:19:24 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 01/11] ASoC: jz4740-i2s: Remove unused 'mem' resource
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <C43OER.T16CTN9Q6E0U1@crapouillou.net>
In-Reply-To: <20220707194655.312892-2-aidanmacdonald.0x0@gmail.com>
References: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
        <20220707194655.312892-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le jeu., juil. 7 2022 at 20:46:45 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> This isn't used and doesn't need to be in the private data struct.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index ecd8df70d39c..c4c1e89b47c1 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -93,7 +93,6 @@ struct i2s_soc_info {
>  };
>=20
>  struct jz4740_i2s {
> -	struct resource *mem;
>  	void __iomem *base;
>=20
>  	struct clk *clk_aic;
> --
> 2.35.1
>=20


