Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21F4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 04:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbiBPEb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:31:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiBPEby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:31:54 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9036813E92;
        Tue, 15 Feb 2022 20:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644985900; x=1676521900;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=R9Ceojy+01/feljLaedmhMoOPJWYkXpoTxqx/xyeBmQ=;
  b=BG+5MJDKCTmOD1Fjul5FrWvT2BHWI7/lHBj538tndcD2nx//CeTOA6t8
   WU1KfKvQkFyoJJ8T2bpwuzZcmVAJPqWdSParfMeZfO2yAPjimPMiCLT0x
   WX7Y8ttCW1EDVZlyMPNZf6HncNwckgrxadqffGOgr2IQS5MDt1JZ2gU+D
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 20:31:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:31:39 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 20:31:38 -0800
Received: from [10.47.233.232] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 15 Feb
 2022 20:31:38 -0800
Subject: Re: [PATCH V6 2/6] dt-bindings: mfd: pm8008: Add regulators node
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644915231-7308-3-git-send-email-quic_c_skakit@quicinc.com>
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Message-ID: <e7aee447-2ef5-b9af-ea56-5c406224aa7a@quicinc.com>
Date:   Tue, 15 Feb 2022 20:31:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1644915231-7308-3-git-send-email-quic_c_skakit@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 12:53 AM, Satya Priya wrote:
> @@ -102,7 +121,7 @@ examples:
>      qupv3_se13_i2c {
>        #address-cells = <1>;
>        #size-cells = <0>;
> -      pm8008i@8 {
> +      pm8008_infra: pm8008@8 {
>          compatible = "qcom,pm8008";
>          reg = <0x8>;
>          #address-cells = <1>;
> @@ -123,6 +142,26 @@ examples:
>            #interrupt-cells = <2>;
>          };
>        };
> -    };
>  
> +      pm8008_regulators: pm8008@9 {
> +        compatible = "qcom,pm8008";

Should this be "qcom,pm8008-regulators" ?

> +        reg = <0x9>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
> +        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
> +        vdd_l5-supply = <&vreg_bob>;
> +        vdd_l6-supply = <&vreg_bob>;
> +        vdd_l7-supply = <&vreg_bob>;
> +
> +        regulators {
> +          pm8008_l1: ldo1 {
> +            regulator-name = "pm8008_l1";
> +            regulator-min-microvolt = <950000>;
> +            regulator-max-microvolt = <1300000>;
> +          };
> +        };
> +      };
> +    };
>  ...

-Subbaraman
