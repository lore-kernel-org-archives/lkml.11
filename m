Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A520C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 14:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiGKOXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiGKOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:23:17 -0400
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189586556C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:23:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1266826|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.136972-0.0747228-0.788305;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.OPswRor_1657549378;
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com fp:SMTPD_---.OPswRor_1657549378)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 22:23:02 +0800
Message-ID: <e87feac9-e00e-1c83-79fe-c790e2f99e15@allwinnertech.com>
Date:   Mon, 11 Jul 2022 22:22:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] extcon: Add EXTCON_DISP_CVBS and EXTCON_DISP_EDP
Content-Language: en-US
To:     Chanwoo Choi <cwchoi00@gmail.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
References: <20220708095714.127736-1-michael@allwinnertech.com>
 <0cef31e4-7e07-087a-1d4b-241cdce76970@gmail.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <0cef31e4-7e07-087a-1d4b-241cdce76970@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/2022 9:03 AM, Chanwoo Choi wrote:
> On 22. 7. 8. 18:57, Michael Wu wrote:
>> Add EXTCON_DISP_CVBS for Composite Video Broadcast Signal.
>> Add EXTCON_DISP_EDP for Embedded Display Port
>>
>> [1] https://en.wikipedia.org/wiki/Composite_video
>> [2] https://en.wikipedia.org/wiki/DisplayPort#eDP
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>> ---
>>   drivers/extcon/extcon.c | 10 ++++++++++
>>   include/linux/extcon.h  |  2 ++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>> index d3a32b8064994..774607a616f7b 100644
>> --- a/drivers/extcon/extcon.c
>> +++ b/drivers/extcon/extcon.c
>> @@ -167,6 +167,16 @@ static const struct __extcon_info {
>>   		.id = EXTCON_DISP_HMD,
>>   		.name = "HMD",
>>   	},
>> +	[EXTCON_DISP_CVBS] = {
>> +		.type = EXTCON_TYPE_DISP,
>> +		.id = EXTCON_DISP_CVBS,
>> +		.name = "CVBS",
>> +	},
>> +	[EXTCON_DISP_EDP] = {
>> +		.type = EXTCON_TYPE_DISP,
>> +		.id = EXTCON_DISP_EDP,
>> +		.name = "EDP",
>> +	},
>>   
>>   	/* Miscellaneous external connector */
>>   	[EXTCON_DOCK] = {
>> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
>> index 685401d94d398..3c45c3846fe94 100644
>> --- a/include/linux/extcon.h
>> +++ b/include/linux/extcon.h
>> @@ -76,6 +76,8 @@
>>   #define EXTCON_DISP_VGA		43	/* Video Graphics Array */
>>   #define EXTCON_DISP_DP		44	/* Display Port */
>>   #define EXTCON_DISP_HMD		45	/* Head-Mounted Display */
>> +#define EXTCON_DISP_CVBS	46	/* Composite Video Broadcast Signal */
>> +#define EXTCON_DISP_EDP		47	/* Embedded Display Port */
>>   
>>   /* Miscellaneous external connector */
>>   #define EXTCON_DOCK		60
> 
> Applied it. Thanks.
> 
> Do you have a plan to send extcon driver with newly added connector type?
> 

Hi Chanwoo,
Thank you for the inviting. I'd like to send more patches for extcon, 
unfortunately the SoCs I'm using only covers CVBS and EDP among the new 
connector types. Once I had a chance to verify a new type, I'll surely 
send it here.
BTW, should I send a patch-v2 with 'Reviewed-by Chanwoo Choi 
<cwchoi00@gmail.com>' or 'Acked-by Chanwoo Choi <cwchoi00@gmail.com>', 
or should I just wait?
Thanks again.

-- 
Regards,
Michael Wu
