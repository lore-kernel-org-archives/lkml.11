Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CBFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 10:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiDNKLt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiDNKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:11:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C9DB6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:09:21 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 03F842222E;
        Thu, 14 Apr 2022 12:09:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649930959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RK59Z34qpZOchcwXuSsdRUcPTe2qzh+QrqzPE04VL94=;
        b=eez+xibiVp6z1DbgnH7st5RcWJxJ4xaUDQXjLIxljjCWf/+Uqhteb4hA7yKYDw2WMJQRgR
        QQya3nqxLGvGVHVOb3LlhfADhfGBxCvKucCwv+lov8z16cIz/Duea6HW1OHjJzhvzpM3Qk
        X3MLsaPBrPhi54KxtwUA6w6J5DrRuIs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Apr 2022 12:09:18 +0200
From:   Michael Walle <michael@walle.cc>
To:     niravkumar.l.rabara@intel.com
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: issi: Add IS25WP512 device
In-Reply-To: <20220414130004.945924-1-niravkumar.l.rabara@intel.com>
References: <20220414130004.945924-1-niravkumar.l.rabara@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d805708b94dc4a00b854f3769c5013b1@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add is25wp512 info to spi_nor_ids[] table entry.
> 
> Rename is25lp256_post_bfpt_fixups to is25xx_post_bfpt_fixups
> as a common function for all is25xx post_bfpt fixups.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

We require SFDP dumps of new flashes. Therefore, you can only add
flashes which you actually have (and have tested). See [1] how to
provide such a dump.

> ---
>  drivers/mtd/spi-nor/issi.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index c012bc2486e1..14fe07e55f85 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -9,24 +9,27 @@
>  #include "core.h"
> 
>  static int
> -is25lp256_post_bfpt_fixups(struct spi_nor *nor,
> +is25xx_post_bfpt_fixups(struct spi_nor *nor,

Please use is25_post_bfpt_fixups. But how sure are you that
this affects their whole nor flash line? is25 is the prefix
for all their SPI NOR flashes, no?

I'm not arguing against using this name and it can certainly
be changed in the future if we know more.

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
