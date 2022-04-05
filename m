Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 04:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiDEEwj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiDEEw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:52:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8613E1F;
        Mon,  4 Apr 2022 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649134191; x=1680670191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dgzovPjWLMeA38zv3QKSxbGukw3E5edGBH7ydLwnKv8=;
  b=prt5Nu1+FpVn6sUuBjknGG5vEhNDd7HQv4SdNUWz5hzHwAMoIQeqhU9d
   vWPBWXl3rL8kOaf/lziwq4F4MqJfXxBs+OctnOcjE3nIHOYw0bR7L3k0K
   UJMWvBFm7GrzFqx9xozid1W63SmxTin7HaZ0wYoR0LD0y2RtxJNez0kma
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Apr 2022 21:49:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 21:49:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 21:49:49 -0700
Received: from [10.216.10.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 21:49:45 -0700
Message-ID: <4d4969eb-59b2-63fc-02fb-169cff070047@quicinc.com>
Date:   Tue, 5 Apr 2022 10:19:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com>
 <1647865696-19192-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n51iMpwMXayMEbPrqO2b=wX-Lz8DYiZMNnzRNGY1BNSKYg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n51iMpwMXayMEbPrqO2b=wX-Lz8DYiZMNnzRNGY1BNSKYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/2022 1:22 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-03-21 05:28:15)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 499299a..e6ec334 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -19,6 +19,7 @@
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/sound/qcom,lpass.h>
>>   #include <dt-bindings/thermal/thermal.h>
>>
>>   / {
>> @@ -1980,6 +1981,68 @@
>>                          #clock-cells = <1>;
>>                  };
>>
>> +               lpass_cpu: audio-subsystem@3260000 {
> The unit address should match the first reg address. This should be
> 3987000. By the way, 'subsystem' looks redundant. Maybe just
> 'audio@3987000' or 'subsystem@3987000'?
Okay. Will change accordingly.
