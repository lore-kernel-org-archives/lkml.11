Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7786CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376416AbiDTHxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 03:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376463AbiDTHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:52:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82AB11C0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:50:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23K7nqJc038648;
        Wed, 20 Apr 2022 02:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650440992;
        bh=VlUxj43GKYHn+kpFf/gQnONEe0h0G7JMf+3O4zsf3f8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pp2xtf3XotwVURpaMJN3GCjA79CLzaiuYuO7I6AUdqin2+gV666YC/hpIoRoTAJEw
         n9cS1JdLpW86AJG8Mm3ra4FsqcqZOdY8SoFT46bOLO0cMqKOUiKRbirlooi2lbu7wf
         ytqYE3S7IO/dUvD+BLY12yvmPwP8zlmfy1Xs0OoQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23K7nqHj126378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Apr 2022 02:49:52 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 20
 Apr 2022 02:49:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 20 Apr 2022 02:49:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23K7npCx113626;
        Wed, 20 Apr 2022 02:49:51 -0500
Date:   Wed, 20 Apr 2022 13:19:50 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v3 9/9] mtd: spi-nor: Introduce templates for SPI NOR
 operations
Message-ID: <20220420074950.gy5okqwwp4c4efv2@ti.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-10-tudor.ambarus@microchip.com>
 <d912d9834a219162ef46efad7d332ef3@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d912d9834a219162ef46efad7d332ef3@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/22 01:45PM, Michael Walle wrote:
> Am 2022-04-11 11:10, schrieb Tudor Ambarus:
> > Clean the op declaration and hide the details of each op. With this it
> > results a cleanner, easier to read code. No functional change expected.
> > 
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> I haven't gone through all of it.

Same.

> 
> Acked-by: Michael Walle <michael@walle.cc>

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
