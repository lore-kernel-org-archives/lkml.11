Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376902AbiFPMHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 08:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiFPMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:07:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D79CB182;
        Thu, 16 Jun 2022 05:07:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64DF3113E;
        Thu, 16 Jun 2022 05:07:29 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749E83F73B;
        Thu, 16 Jun 2022 05:07:28 -0700 (PDT)
Message-ID: <9b005c7d-e434-c215-288d-3926f483b07a@arm.com>
Date:   Thu, 16 Jun 2022 13:07:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: fix overlapping GICD memory
 region
Content-Language: en-GB
To:     Matt Ranostay <mranostay@ti.com>, Marc Zyngier <maz@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616105112.289719-1-mranostay@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220616105112.289719-1-mranostay@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-16 11:51, Matt Ranostay wrote:
> GICD region was overlapping with GICR causing the latter to not map
> successfully, and in turn the gic-v3 driver would fail to initialize.
> 
> This issue was hidden till commit 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
> replaced of_iomap() calls with of_io_request_and_map() that internally
> called request_mem_region().
> 
> Respective console output before this patchset:
> 
> [    0.000000] GICv3: /bus@100000/interrupt-controller@1800000: couldn't map region 0

Oh, it's nice that this finds bugs, but it seems I hadn't fully 
considered that making the simple easy change in the DT paths results in 
different behaviour from ACPI.

Marc, would you like a fix for this to remain non-fatal even in the face 
of a dodgy DT, or are you happy with being a bit stricter now?

Thanks,
Robin.

> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index be7f39299894..19966f72c5b3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -33,7 +33,7 @@ gic500: interrupt-controller@1800000 {
>   		ranges;
>   		#interrupt-cells = <3>;
>   		interrupt-controller;
> -		reg = <0x00 0x01800000 0x00 0x200000>, /* GICD */
> +		reg = <0x00 0x01800000 0x00 0x100000>, /* GICD */
>   		      <0x00 0x01900000 0x00 0x100000>, /* GICR */
>   		      <0x00 0x6f000000 0x00 0x2000>,   /* GICC */
>   		      <0x00 0x6f010000 0x00 0x1000>,   /* GICH */
