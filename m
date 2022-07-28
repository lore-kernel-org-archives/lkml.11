Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CB9C04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 12:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiG1MPR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiG1MPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:15:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C6A22B0D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:15:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 130482223A;
        Thu, 28 Jul 2022 14:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659010509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+iB+y4UmlKWdeQTVxa4fIZkk162vSuzYY7Z6Mms0feo=;
        b=eRYFdqz2fx5llgTDNvLBmUKDpRFg4BwptGeeBb26uAvHV/QilbqJXphE7otOcrQ82AQjxy
        xaRsiheInsQF2bmrQfMCW7gBfdU6iwAJcjYMEG41hrMclA9veRA4L/LoTBT6sMeCzVryPu
        YHUKvG/o5oxz8yDT7EtrFnI47U8L9go=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Jul 2022 14:15:05 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: core: Add an error message when failing to
 exit the 4-byte address mode
In-Reply-To: <20220728030159.68680-1-tudor.ambarus@microchip.com>
References: <20220728030159.68680-1-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <27c95d5e17906f5e45c04cec7c1bda9d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-07-28 05:01, schrieb Tudor Ambarus:
> Add an error message when failing to exit the 4-byte address mode. Do 
> not
> stop the execution and go through the spi_nor_soft_reset() method if 
> used,
> in the hope that the flash will default to 3-byte address mode after 
> the
> reset.
> 
> Suggested-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f2c64006f8d7..1cdbdad97136 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2841,7 +2841,8 @@ void spi_nor_restore(struct spi_nor *nor)
>  	/* restore the addressing mode */
>  	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
>  	    nor->flags & SNOR_F_BROKEN_RESET)
> -		nor->params->set_4byte_addr_mode(nor, false);
> +		if (nor->params->set_4byte_addr_mode(nor, false))
> +			dev_err(nor->dev, "Failed to exit 4-byte address mode\n");

Could we stick to the ususal pattern:

ret = func()
if (ret)
    err("blubb (%d)", ret);

I know it is more lines but imho it makes the code much more readable.
And that way you could also print the error code. You could also use
dev_err("bla (%pe)\n", ERR_PTR(ret));

-michael
