Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 22:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiCUWxq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiCUWxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:53:18 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0B37DD20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:32:35 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EBC282241C;
        Mon, 21 Mar 2022 23:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647900937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPKtBjHCqpwtx6hbO9m1IkCg2G97LUXk9EM0OXoh+hs=;
        b=jLjDnyDn/XYNYoeBmc8aExMX6fzSO8emLH/aPbmYIizEfaNlCYy4v+WCz99VmPWvfWinHd
        Q2BeCqzKGJ2qElfe+aBXJxJW4f8wXh1SQGu01EkS592849PqPY5iUS3lDt/+Je1/ebMfCU
        ejQGPeMK6kn/j/W+GchYPe2rtFmzwpc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Mar 2022 23:15:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 2/8] mtd: spi-nor: Introduce spi_nor_match_id()
In-Reply-To: <20220228111712.111737-3-tudor.ambarus@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-3-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f270ae65e7bf42b6aa8521c6a0db4784@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-28 12:17, schrieb Tudor Ambarus:
> Similar to spi_nor_match_name() extend the search of flash_info through
> all the manufacturers, this time doing the match by ID. There's no 
> reason
> to limit the search per manufacturer yet, do it globally, search the 
> flash
> in all the parts of all manufacturers in a single method.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Michael Walle <michael@walle.cc>

> ---
>  drivers/mtd/spi-nor/core.c | 40 ++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f3c359d03163..f87cb7d3daab 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1629,16 +1629,21 @@ static const struct spi_nor_manufacturer
> *manufacturers[] = {
>  	&spi_nor_xmc,
>  };
> 
> -static const struct flash_info *
> -spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int 
> nparts,
> -			  const u8 *id)
> +static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
> +						 const u8 *id)
>  {
> -	unsigned int i;
> +	const struct flash_info *part;
> +	unsigned int i, j;
> 
> -	for (i = 0; i < nparts; i++) {
> -		if (parts[i].id_len &&
> -		    !memcmp(parts[i].id, id, parts[i].id_len))
> -			return &parts[i];
> +	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
> +		for (j = 0; j < manufacturers[i]->nparts; j++) {
> +			part = &manufacturers[i]->parts[j];
> +			if (part->id_len &&
> +			    !memcmp(part->id, id, part->id_len)) {
> +				nor->manufacturer = manufacturers[i];
> +				return part;
> +			}
> +		}
>  	}
> 
>  	return NULL;
> @@ -1648,7 +1653,6 @@ static const struct flash_info
> *spi_nor_read_id(struct spi_nor *nor)
>  {
>  	const struct flash_info *info;
>  	u8 *id = nor->bouncebuf;
> -	unsigned int i;
>  	int ret;
> 
>  	if (nor->spimem) {
> @@ -1668,19 +1672,13 @@ static const struct flash_info
> *spi_nor_read_id(struct spi_nor *nor)
>  		return ERR_PTR(ret);
>  	}
> 
> -	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
> -		info = spi_nor_search_part_by_id(manufacturers[i]->parts,
> -						 manufacturers[i]->nparts,
> -						 id);
> -		if (info) {
> -			nor->manufacturer = manufacturers[i];
> -			return info;
> -		}
> +	info = spi_nor_match_id(nor, id);
> +	if (!info) {
> +		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
> +			SPI_NOR_MAX_ID_LEN, id);
> +		return ERR_PTR(-ENODEV);
>  	}
> -
> -	dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
> -		SPI_NOR_MAX_ID_LEN, id);
> -	return ERR_PTR(-ENODEV);
> +	return info;
>  }
> 
>  static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,

-- 
-michael
