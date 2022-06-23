Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF734C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 19:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiFWTRa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiFWTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:17:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E881503;
        Thu, 23 Jun 2022 11:21:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25NILUxm065339;
        Thu, 23 Jun 2022 13:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656008490;
        bh=IoWdi0H4t6rANy/Wec8MqCScwdls3DsawSyu0mvvJH0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UaQKBwC0XKuL7WbEcMo88ShbiwfkSHQVQHESL3lXYz3LMSxptLSS3MQsg+5Zms/ev
         HdlpbBEaPGeBEOioCeEYPqkMbHKg02k8oLhKXA5dlZr7YBxyCId6fPzd8Xnkhh9ppJ
         0bW/tMwrYsap6uHs8j33ATA/7kZ5YoXt74PihwiE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25NILUVh127625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 13:21:30 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 13:21:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 13:21:29 -0500
Received: from [10.250.33.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25NILSCG077352;
        Thu, 23 Jun 2022 13:21:29 -0500
Message-ID: <10ee5d87-47bd-d423-75a5-611fefe7a656@ti.com>
Date:   Thu, 23 Jun 2022 13:21:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Enable crypto accelerator
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220623095955.161307-1-j-choudhary@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20220623095955.161307-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/22 4:59 AM, Jayesh Choudhary wrote:
> Add the node for sa3ul crypto accelerator.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> On local testing, crypto self-tests and tcrypt tests were passing
> for SHA256, SHA512, ECB-AES and CBC-AES algorithms.
> RNG node has not been added due to the indirect access of the
> hardware random number generator from OP-TEE.
> 
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index df3b9883e887..30bd22ff2fc9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -165,6 +165,19 @@
>   		};
>   	};
>   
> +	crypto: crypto@40900000 {
> +		compatible = "ti,am62-sa3ul";
> +		reg = <0x00 0x40900000 0x00 0x1200>;
> +		power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;


Change to TI_SCI_PD_SHARED as OP-TEE uses this too, otherwise looks good,

Acked-by: Andrew Davis <afd@ti.com>


> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
> +
> +		dmas = <&main_pktdma 0xf501 0>, <&main_pktdma 0x7506 0>,
> +				<&main_pktdma 0x7507 0>;
> +		dma-names = "tx", "rx1", "rx2";
> +	};
> +
>   	main_pmx0: pinctrl@f4000 {
>   		compatible = "pinctrl-single";
>   		reg = <0x00 0xf4000 0x00 0x2ac>;
