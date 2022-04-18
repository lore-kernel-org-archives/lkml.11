Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 16:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiDRQmN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbiDRQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:42:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11F32074
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=25YuxAr1PTEePBc5J+xHwi7RoAPIjjwOJ1WIOV6Xjlc=;
  b=cc5C7Y0S5vPI2P1rMhz6zgwMuDm5mltRgTpz2sFyqlwTJJwgfOVucB5F
   KcZtCakb5NbQD6PGzfGeohj+YRI+M5Ftd/DvSpopqr5gpYxt5QdJ4wJ+B
   Z13tE1u75Vw4HkiSweG27ilaqyluu0z+FR6heZhk0hMlVhudes/jXuoxI
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,270,1643670000"; 
   d="scan'208";a="11802383"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 18:39:20 +0200
Date:   Mon, 18 Apr 2022 18:37:53 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Aliya Rahmani <aliyarahmani786@gmail.com>
cc:     clabbe@baylibre.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: media: zoran: else is not generally
 useful after a break or return
In-Reply-To: <20220418162244.15346-3-aliyarahmani786@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204181837420.13551@hadrien>
References: <20220418162244.15346-1-aliyarahmani786@gmail.com> <20220418162244.15346-3-aliyarahmani786@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Apr 2022, Aliya Rahmani wrote:

> Remove the else without affecting the logic. Fixes the checkpatch warning: else is not generally useful after a break or return

This line is still too long.

julia

>
> Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
> ---
>  drivers/staging/media/zoran/videocodec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
> index 16a1f23a7f19..19732a47c8bd 100644
> --- a/drivers/staging/media/zoran/videocodec.c
> +++ b/drivers/staging/media/zoran/videocodec.c
> @@ -98,9 +98,8 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
>
>  				h->attached += 1;
>  				return codec;
> -			} else {
> -				kfree(codec);
>  			}
> +			kfree(codec);
>  		}
>  		h = h->next;
>  	}
> --
> 2.25.1
>
>
>
