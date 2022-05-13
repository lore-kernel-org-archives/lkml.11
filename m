Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD640C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 07:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377611AbiEMHAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353010AbiEMHAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:00:12 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD9671DFD8E;
        Fri, 13 May 2022 00:00:11 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 59BD41C80DC4;
        Fri, 13 May 2022 15:00:11 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 13
 May 2022 15:00:10 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1847.3; Fri, 13 May
 2022 15:00:10 +0800
Received: from [172.19.1.47] (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 13 May 2022 15:00:10 +0800
Message-ID: <7902bc78-877d-4f00-171f-fbfe7167075f@nuvoton.com>
Date:   Fri, 13 May 2022 15:00:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V4 0/5] Add initial support for MA35D1 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        <ychuang570808@gmail.com>, "Rob Herring" <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        <cfli0@nuvoton.com>
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
 <8be62b40-077a-7634-7d34-7776909a2abe@linaro.org>
 <CAK8P3a3=YD7WV+Www8pf+JTv14DwcnSjD+f=YFCNMxXYT9FAZA@mail.gmail.com>
 <51ce4fca-f7b8-92ab-c9c6-1e57a2a5b5f3@nuvoton.com>
 <9b2ecc28-df1e-903a-c652-2d65fc7d41ec@linaro.org>
From:   Jacky Huang <ychuang3@nuvoton.com>
In-Reply-To: <9b2ecc28-df1e-903a-c652-2d65fc7d41ec@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/13 下午 02:55, Krzysztof Kozlowski wrote:
> On 13/05/2022 08:53, Jacky Huang wrote:
>> Thanks for your review and help.
>> I will run the dtbs_check, add binding document, and include serial
>> driver in the next version.
> Except dtbs_check you have to run dt_binding_check because this is the
> one which was failing at the first place.
>
> Best regards,
> Krzysztof

OK, I got it. Thank you very much.


Sincerely,
Jacky Huang

