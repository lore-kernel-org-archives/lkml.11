Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29BDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 00:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiFNAsu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiFNAss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:48:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F22B254
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655167726; x=1686703726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zMvaLG5fr7e0A8364yt7KMOJ+b17CQQted93WjMHcX4=;
  b=I7c73gIo2N7XEcZW8rWvF+9ArJyyoaICrsIlxQ3TvZ3UlL/s8Xl58f3M
   6j51RiSwCwArl+KSA7hLQYh/ACrSdUXwrbyAWPemZFW7zEXQvkzA9794R
   8TA7dD5+7s9jVE75y0xnmAPlbS44zr3Ev+ydenk7xxKjWQj+LtGFZkQ24
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Jun 2022 17:48:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 17:48:46 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 17:48:32 -0700
Received: from [10.253.77.15] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 17:48:30 -0700
Message-ID: <d14f0409-351f-873e-b7ca-82ff444bf809@quicinc.com>
Date:   Tue, 14 Jun 2022 08:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
Content-Language: en-US
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
References: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
 <1654171861-24014-2-git-send-email-quic_linyyuan@quicinc.com>
 <9a7e0b6087540c9f868d60cbfc88ccefa8070a1b.camel@kernel.org>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <9a7e0b6087540c9f868d60cbfc88ccefa8070a1b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Tom,

On 6/14/2022 5:01 AM, Tom Zanussi wrote:
> Hi Linhu,
>
> On Thu, 2022-06-02 at 20:10 +0800, Linyu Yuan wrote:
>> traceprobe_parse_event_name() already validate group and event name,
>> there is no need to call is_good_name() after it.
>>
>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>> ---
>> v2: drop v1 change as it is NACK.
>>      add it to remove duplicate is_good_name().
>> v3: move it as first patch.
>> v4: no change
>>
>>   kernel/trace/trace_eprobe.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace_eprobe.c
>> b/kernel/trace/trace_eprobe.c
>> index 7d44785..17d64e3 100644
>> --- a/kernel/trace/trace_eprobe.c
>> +++ b/kernel/trace/trace_eprobe.c
>> @@ -878,16 +878,12 @@ static int __trace_eprobe_create(int argc,
>> const char *argv[])
>>                  sanitize_event_name(buf1);
>>                  event = buf1;
>>          }
>> -       if (!is_good_name(event) || !is_good_name(group))
>> -               goto parse_error;
> traceprobe_parse_event_name() is only called if (event).  In the
> !event case, wouldn't the is_good_name() checks still be needed (since
> in that case buf1 is assigned to event)?

when user input no  event name, it will generate event name from second  
SYSTEM.EVENT,

and it will validate with following traceprobe_parse_event_name().


(

if you agree, i will send a new version to update a minor issue in 
second patch,


         sys_event = argv[1];
-       ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
-                                         sys_event - argv[1]);
-       if (ret || !sys_name)
+       ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
+       if (!sys_event || !sys_name)
                 goto parse_error;

)

>
>>   
>>          sys_event = argv[1];
>>          ret = traceprobe_parse_event_name(&sys_event, &sys_name,
>> buf2,
>>                                            sys_event - argv[1]);
>>          if (ret || !sys_name)
>>                  goto parse_error;
>> -       if (!is_good_name(sys_event) || !is_good_name(sys_name))
>> -               goto parse_error;
> I agree this one isn't needed.
>
> Thanks,
>
> Tom
>
>>   
>>          mutex_lock(&event_mutex);
>>          event_call = find_and_get_event(sys_name, sys_event);
