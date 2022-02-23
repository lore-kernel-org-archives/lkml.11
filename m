Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9552C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 11:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiBWLjc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 06:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiBWLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:39:30 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988118BF2B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:39:03 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NBcvng068890;
        Wed, 23 Feb 2022 05:38:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645616337;
        bh=2LkD5YBwfGax8FSb4kF5KhkTV5+/YMmcx2pkuCKsJLo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ViuIV4AgvNNIfK+ZngMWiLaYKoDLSUqyzIxZa0HgIWYs3S2eZiP9wjuxwruZBsw79
         HPd/QgTgL8IfL5XtmHCMryDmG9NO2ee/IUOUtnWfOANC5+JhFXN/JSzcxdTNC4ZKKM
         8lyAWNBFSxc0Eh8/lg9JwHt/nu+iNIYhgejiBAuM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NBcvtH020894
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 05:38:57 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 05:38:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 05:38:57 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NBcufq011742;
        Wed, 23 Feb 2022 05:38:56 -0600
Date:   Wed, 23 Feb 2022 17:08:55 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <yaliang.wang@windriver.com>
Subject: Re: [PATCH v4 14/32] mtd: spi-nor: winbond: unify function names
Message-ID: <20220223113855.4pkxptnw7ivk7ilt@ti.com>
References: <20220221120809.1531502-1-michael@walle.cc>
 <20220221120809.1531502-15-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220221120809.1531502-15-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/22 01:07PM, Michael Walle wrote:
> To avoid name clashes unify all the function and static object names and
> use one of the following prefixes which should be sufficiently unique:
>  - <vendor>_nor_
>  - <flash_family>_nor_
>  - <flash_part>_
> 
> There are no functional changes.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
