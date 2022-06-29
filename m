Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E890C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 09:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiF2Juj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiF2JuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:50:04 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809E3D4A9;
        Wed, 29 Jun 2022 02:50:02 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ABBE4E0019;
        Wed, 29 Jun 2022 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656496201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4w6NTPvpwoeqhGxtMHGo8FEWQOfamO3Z8w4JG8EcO0=;
        b=LLuIwFIAdy0eTduyVd9Kj8/0KMEl9Zn4dOeRpRuTD8YZliwMzpCHdc6UwLjYh2r88ZQG5z
        GwdIjyrfJQX/tcHnD2sedm15wCFFDAOnd52xtrb/Hcx4AKVRpyxrIj9CztPBXK1Qj9W9Sj
        NPudFQQ0K5WAh0yabsnwgUUHH/9jzjCRCN5AqB0Icwe9kEJMvncpipW2EXrpQosuBw+Lu5
        TRuP4e6R74bs4KvKmkybgDhLUcXXnXgT16EYtys+7bxj4Xaq+og12RzFtBp24COd9X7oxj
        O9+NfnPG5N/QfLCpxhglP0niKGXTYh5H3hQyU0yJMbKLOVYiWyIvk8iVre7Qpg==
Date:   Wed, 29 Jun 2022 11:49:13 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <olteanv@gmail.com>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>
Subject: Re: [PATCH -next] net: dsa: rzn1-a5psw: add missing of_node_put()
 in a5psw_pcs_get()
Message-ID: <20220629114913.41670052@fixe.home>
In-Reply-To: <20220629092435.496051-1-yangyingliang@huawei.com>
References: <20220629092435.496051-1-yangyingliang@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 29 Jun 2022 17:24:35 +0800,
Yang Yingliang <yangyingliang@huawei.com> a =C3=A9crit :

> of_parse_phandle() will increase the refcount of 'pcs_node', so add
> of_node_put() before return from a5psw_pcs_get().
>=20
> Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 =
port switch driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/dsa/rzn1_a5psw.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
> index 3e910da98ae2..301171ee1061 100644
> --- a/drivers/net/dsa/rzn1_a5psw.c
> +++ b/drivers/net/dsa/rzn1_a5psw.c
> @@ -923,6 +923,7 @@ static int a5psw_pcs_get(struct a5psw *a5psw)
>  	return 0;
> =20
>  free_pcs:
> +	of_node_put(pcs_node);

of_node_put(pcs_node) should probably also be called after
miic_create(a5psw->dev, pcs_node); since it is not needed anymore.

Cl=C3=A9ment

>  	of_node_put(port);
>  	of_node_put(ports);
>  	a5psw_pcs_free(a5psw);


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
