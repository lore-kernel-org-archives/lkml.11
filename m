Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A672C6FA81
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 03:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiIBDno (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiIBDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:43:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F51DB1B8F;
        Thu,  1 Sep 2022 20:43:42 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2823BajF025527;
        Fri, 2 Sep 2022 03:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=72htk6PiIJYHXqt8bApvvEmrENk2JSjeEar/ghfbaDo=;
 b=DzuVs12QEuR3EfTHtHQ9gSV4jmiwSNZ2olw7yDdjTwUSLy+ClFlnjX4HPEwbHuFlpNmb
 zpbt0bDcail7rSdaYC/T4OLv/TbPeIgSHUOQCzfuukyWRAzFU6+AVWHte7JAFoO23Ls6
 UYK1j2bPi/kcECZoWjcFHzFMQkV9AhdZlVF+67x3Qz8ReLv2BbSHNDsJvlN8cJRR7ouk
 C8KHnSNepepeZCxRgEo18DxPgHjr5PShUKHlhvj+zMHHTqnmuVGoj6EB52VU/pcvXTxL
 wGN3fzua6K0Pe5RAjVObSBAzJsISBu725Spx/m246WbD4395XH3BD2dtSFUkrSHVw7Xv vQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb9pur23d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 03:43:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2823hTTH011139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 03:43:29 GMT
Received: from [10.216.15.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 20:43:24 -0700
Message-ID: <99fd7b57-3729-6a77-e2ff-3958194526b3@quicinc.com>
Date:   Fri, 2 Sep 2022 09:13:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 support for sc7280 BWMONs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20220901124730.19460-1-quic_rjendra@quicinc.com>
 <20220901124730.19460-2-quic_rjendra@quicinc.com>
 <7d28d450-c90a-398a-3074-5d8237fcd051@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <7d28d450-c90a-398a-3074-5d8237fcd051@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t5zaAjohpQ-lz9K7QkcKZ_gKTO1wac_1
X-Proofpoint-GUID: t5zaAjohpQ-lz9K7QkcKZ_gKTO1wac_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/2022 8:55 PM, Krzysztof Kozlowski wrote:
> On 01/09/2022 15:47, Rajendra Nayak wrote:
>> Add a compatible for the cpu BWMON (version 4) instance and one
>> for the llcc BWMON (version 5) found in sc7280 SoC.
> 
> +Cc of few Linaro folks.
> 
> Awesome! I see bwmon is being used! Rajendra, do you have any particular
> needs/todos for bwmon or other related pieces?

Thanks Krzysztof, nothing at the moment, things just worked out of the box
(except for the PATCH 3/4 that took a while to uncover)
We are still analyzing the perf/power numbers on sc7280 based ChromeOS devices,
along with some other yet to be posted changes to enable memory latency
based governors in firmware, but all is good with bwmon drivers for now.

> 
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> ---
>>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> index 32e2892d736b..cac915c5c2aa 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>> @@ -25,8 +25,10 @@ properties:
>>         - items:
>>             - enum:
>>                 - qcom,sdm845-bwmon
>> +              - qcom,sc7280-bwmon
> 
> Could you put it in alphabetical order, so before sdm845?

ah right, will fix and repost, thanks.
  
> With above:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
