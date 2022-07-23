Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1276C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jul 2022 10:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiGWKaY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jul 2022 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiGWKaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:30:22 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79A9FFA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 03:30:20 -0700 (PDT)
Received: from [192.168.1.101] (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1BF92201C3;
        Sat, 23 Jul 2022 12:30:18 +0200 (CEST)
Message-ID: <187ecad1-1109-2416-ea5a-f26a9d33f973@somainline.org>
Date:   Sat, 23 Jul 2022 12:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] clk: qcom: Add global clock controller driver for
 SM6375
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220723100135.91784-1-konrad.dybcio@somainline.org>
 <20220723100135.91784-3-konrad.dybcio@somainline.org>
 <a7096e65-14e3-5a99-e34d-fe924a753591@wanadoo.fr>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <a7096e65-14e3-5a99-e34d-fe924a753591@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.07.2022 12:15, Christophe JAILLET wrote:
> Le 23/07/2022 à 12:01, Konrad Dybcio a écrit :
>> Add support for the global clock controller found on SM6375.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>> Changes since v2:
>> - use parent_hws where applicable
>>
>>   drivers/clk/qcom/Kconfig      |    8 +
>>   drivers/clk/qcom/Makefile     |    1 +
>>   drivers/clk/qcom/gcc-sm6375.c | 3931 +++++++++++++++++++++++++++++++++
>>   3 files changed, 3940 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gcc-sm6375.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 415ae4ffab48..ef81eda01649 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -672,6 +672,14 @@ config SM_GCC_6350
>>         Say Y if you want to use peripheral devices such as UART,
>>         SPI, I2C, USB, SD/UFS, PCIe etc.
>>   +config SM_GCC_6375
>> +    tristate "SM6350 Global Clock Controller"
> 
> Nit: SM6375?
Yes, obviously.. I made a mistake here.

Konrad
> 
>> +    select QCOM_GDSC
>> +    help
>> +      Support for the global clock controller on SM6375 devices.
>> +      Say Y if you want to use peripheral devices such as UART,
>> +      SPI, I2C, USB, SD/UFS etc.
>> +
