Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724FAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 07:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiB1Hsk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiB1Hsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:48:38 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE113F50;
        Sun, 27 Feb 2022 23:47:59 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21S7lkwQ129728;
        Mon, 28 Feb 2022 01:47:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646034466;
        bh=XaVajIyYolMkwb7z4/mnEHAALnLb4cevLOQSWippJ7Q=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SZ3AE5JG+Gu4PTuDhvy9QmR/qNqeRS9joRkp6UsSKiIXOqhGy19zyh+H/NiKwltNv
         RDfGQhv42RtlnfB28NRUV0NZeW7SS7IrxPkljAalTFPxD8dwr/ezQVHC1Q62OmRLBh
         vL4RFy0AYFJk8Og1Sg6xeFhq7X1gub09WtNpfGyM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21S7lksL027669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 01:47:46 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 01:47:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 01:47:46 -0600
Received: from [10.250.233.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21S7lhOG035509;
        Mon, 28 Feb 2022 01:47:44 -0600
Message-ID: <e0786653-9470-f7b3-c744-5fd9c08c25aa@ti.com>
Date:   Mon, 28 Feb 2022 13:17:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am64-main: Add GPMC memory
 controller node
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <nm@ti.com>
CC:     <kishon@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220204111533.10787-1-rogerq@kernel.org>
 <20220204111533.10787-2-rogerq@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220204111533.10787-2-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/22 4:45 pm, Roger Quadros wrote:
> The GPMC is a unified memory controller dedicated for interfacing
> with external memory devices like
>   - Asynchronous SRAM-like memories and ASICs
>   - Asynchronous, synchronous, and page mode burst NOR flash
>   - NAND flash
>   - Pseudo-SRAM devices
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  4 ++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  4 ++++
>  3 files changed, 27 insertions(+)
> 

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

[...]

Regards
Vignesh
