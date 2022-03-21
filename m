Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3641FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 11:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbiCULzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346475AbiCULzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:55:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084A626DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:54:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22LBrpxs129379;
        Mon, 21 Mar 2022 06:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647863631;
        bh=d88Otb0kIMljIcclrz/rDFMAepVS3BcWvi6rOXAC88g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LOKrhhypuM3dMGW8PzlITIn1Z/LVh9YAZa8pji9EVqAry7yENrQxtCjbY2QKGHRo8
         iLKNjjKohh9Bd58a/z/QfnTOeE8+eNrTrsblsAgAeEoI5xWi3agTqKseXjJgo0vzJv
         UEHeOYxYNtp5MDM2LDEi9Ji0h7xR9titnaSQc9Ag=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22LBrp8k022885
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Mar 2022 06:53:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Mar 2022 06:53:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Mar 2022 06:53:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22LBroj5024841;
        Mon, 21 Mar 2022 06:53:50 -0500
Date:   Mon, 21 Mar 2022 17:23:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v6 1/7] mtd: spi-nor: Rename method,
 s/spi_nor_match_id/spi_nor_match_name
Message-ID: <20220321115349.vffvanluf5b2wzhh@ti.com>
References: <20220209133656.374903-1-tudor.ambarus@microchip.com>
 <20220209133656.374903-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220209133656.374903-2-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/22 03:36PM, Tudor Ambarus wrote:
> The method is matching a flash_info entry by searching by name. Rename
> the method for better clarity.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
