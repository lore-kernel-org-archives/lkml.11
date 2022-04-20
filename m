Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369C8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 06:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359474AbiDTGSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiDTGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:18:37 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01ED3914F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:15:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23K6FfuU014958;
        Wed, 20 Apr 2022 01:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650435341;
        bh=rYdnDK2fO07+IhtDiEbHGBLPDMmpI+z9p6e7hxWljZQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WLILfJeYbrVutuFvPo0cMLRM8g16pNnE4eJ0t9KqeJtmvsWfVwDMWY5ME9sZagoyq
         gjunQvD2WM44q8xV7BMcSzKjlROmqLhobkurx7W2voW86+hvCOxX8SRVyHg6mFzEXn
         4fWjIHIkGxrQOsN6fVjSd4vxNFM/QK7FQRZ2Vo04=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23K6Fffk003301
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Apr 2022 01:15:41 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 20
 Apr 2022 01:15:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 20 Apr 2022 01:15:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23K6FeZB120243;
        Wed, 20 Apr 2022 01:15:40 -0500
Date:   Wed, 20 Apr 2022 11:45:40 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: move spi_nor_write_ear() to winbond module
Message-ID: <20220420061540.ehte7mtrqqxohhg7@ti.com>
References: <20220418112404.2790469-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220418112404.2790469-1-michael@walle.cc>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/22 01:24PM, Michael Walle wrote:
> The "Extended Address Register" is winbond specific. If the flash is
> larger than 16MiB and is used in 3 byte address mode, it is used to set
> the remaining address bits. Move the write_ear() function the winbond
> module and rename it accordingly.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
