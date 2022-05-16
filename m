Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F81C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 07:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiEPHvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiEPHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:51:14 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4085BF58
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:51:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6F4036001B;
        Mon, 16 May 2022 07:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652687471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcRXTnUer1M5l+X0FoLehOx+DusdiUpQF8ofo2RLrEA=;
        b=TBZ2hEoT6M2chW4inuB16T5f/3DlqDh9AqCVC7x/DRhhqNXu4dIblVMtwm5X6G6vqcQU0q
        QU7bwd8pYoMgOqNWK4SJ0Vlr1eBda2RnDDFqlOHRXNcJH219lJB/SbGSOTofrjAAELkUhy
        170b12prFonWwq7xBhiUEUD09IbjObHKYHycxnzHCwqxmY5d5HZGjq9K+M217ePYOR+Pu+
        NjrVBZXJLdx4RUaZbxYWBEcUIfChRnFomKaZl3vSWS3K9l1nMsFgmqqbxQTH7m7FqX/clk
        JIYdvTSjdu8lYZDFzSlJb6nz5UYfa1JbjriK17SCJZJFffJQeHt6gLUFu87XXw==
Date:   Mon, 16 May 2022 09:51:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH -next] mtd: st_spi_fsm: add missing
 clk_disable_unprepare() stfsm_remove()
Message-ID: <20220516095108.4ec6d0d9@xps13>
In-Reply-To: <0d7ee262-6286-ec41-884e-3ab5863b68b4@huawei.com>
References: <20220513100322.2664431-1-yangyingliang@huawei.com>
        <20220513122248.146d6944@xps13>
        <0d7ee262-6286-ec41-884e-3ab5863b68b4@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

yangyingliang@huawei.com wrote on Sat, 14 May 2022 10:12:55 +0800:

> Hi,
>=20
> On 2022/5/13 18:22, Miquel Raynal wrote:
> > Hi,
> >
> > yangyingliang@huawei.com wrote on Fri, 13 May 2022 18:03:22 +0800:
> > =20
> >> Clock source is prepared and enabled by clk_prepare_enable()
> >> in probe function, but no disable or unprepare in remove function. =20
> > 			 not disabled or unprepared
> >
> > Otherwise looks good. =20
> Do I need to resend it ?

Yes, please.

Thanks,
Miqu=C3=A8l
