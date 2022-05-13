Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D16C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 10:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379374AbiEMKXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379391AbiEMKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:22:55 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DFB15ECE1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:22:53 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 209A6200014;
        Fri, 13 May 2022 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652437370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKGQzMvl09aeW/JHbZLxJsWC9vk0A9Wq5iOaeINC+eU=;
        b=BqLKfOLwkIwXDjK/SWTDjdRTdeAR0xUgcw4HEWSz7zFWnQF5cjfpxqarNCJVNlwj0Ysn9Q
        8Rqf+sCNgGMegm5tM6K+DrsYPcszY/2hGubshBf1CpSvbQ2HF7+02Zl9rKD3xJXATXIHT2
        FKMUnSRHyRux9tchbskrcTrY+Pxve91A6fSh+pM0Q0gZ6rineVDbvYLYGPAA92tIcYiPIi
        FuQhDq/wY4+7OmgpB4+gcJbKYtcvKwR2/A21NWfL6hsqkxrjrksPMD5nPByWEjbYDGvmv1
        hGwyvUiUHcuWSVCOgjFnIrYdlXUpa74gllaDIMTQl91DCpOIdMKOyWXgqlPjpw==
Date:   Fri, 13 May 2022 12:22:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH -next] mtd: st_spi_fsm: add missing
 clk_disable_unprepare() stfsm_remove()
Message-ID: <20220513122248.146d6944@xps13>
In-Reply-To: <20220513100322.2664431-1-yangyingliang@huawei.com>
References: <20220513100322.2664431-1-yangyingliang@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yangyingliang@huawei.com wrote on Fri, 13 May 2022 18:03:22 +0800:

> Clock source is prepared and enabled by clk_prepare_enable()
> in probe function, but no disable or unprepare in remove function.

			 not disabled or unprepared

Otherwise looks good.

>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_sp=
i_fsm.c
> index 983999c020d6..d3377b10fc0f 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -2126,6 +2126,8 @@ static int stfsm_remove(struct platform_device *pde=
v)
>  {
>  	struct stfsm *fsm =3D platform_get_drvdata(pdev);
> =20
> +	clk_disable_unprepare(fsm->clk);
> +
>  	return mtd_device_unregister(&fsm->mtd);
>  }
> =20


Thanks,
Miqu=C3=A8l
