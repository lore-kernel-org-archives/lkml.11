Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33EBC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 14:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbiEJOpW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242593AbiEJOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:38 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B007140863;
        Tue, 10 May 2022 07:03:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v65so18606115oig.10;
        Tue, 10 May 2022 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U1JMRWz4tHJAu3Gv+myx1Xb+EidiUMO/E1TJfGfSyqA=;
        b=Z1alJz5Sa7M5Uqz0J+gVmyo+d8QpIIxRXvp4bs6UAiRyQNwddoDzf9GerSP/xf9R81
         9nXWtFW2oU1UHvitqd0y0OI28JCh2XxMvJN74DlzRAXdtswGGjC39l901et4CPZZwYut
         Q4UCbX/8nLwSg1EdrdulygB04m2aRymqfBf80ipzz4i51mlsW8QivF7C8haypo2K2YB5
         X1nD/KIlLXTcbZdGjkQR+y7mlzpqKeM+Gq0sdYbN/Nsk0SD4HuuAc/baRI1sKMtURPjD
         v+H28kCiK4+l1IkNT6rVB8Ay+xSscmlHnM8MpFEuKq3Txj2KsbX0CTVOUa+gzUpOER0v
         Bm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U1JMRWz4tHJAu3Gv+myx1Xb+EidiUMO/E1TJfGfSyqA=;
        b=v2awaO2iZIO5zjeRfdxY5xgNjDm+j9yypc/FnWtD/mgThi6AUqlb9wgsu1mRUEsVI9
         b5FHfwkUxXwNRX878sGCCwt1jd/HqvcpJzoH8UGAwa+C2jsChuYSjs3vSg08ZU8FpxhN
         opfKal650Bq3zTg0LfR4PHh3ZNefEKyhe4LZA/pHKaE/bEEXIAf/8Eu19HVY+jTqmxN+
         n8U3G7/q8xqIbnZQVR7EzlCG4oB8zg4SV8D9irui5KIFcZvl/2q704Ud9SLOJbgSp5Fa
         /TpCcEq5WOYYpLbkXh6+7tfgwgF4oHJgBQgJSDhcxE++zmhcK0DTjMfHGMUTJ5iz1wz6
         Cxrw==
X-Gm-Message-State: AOAM533HlPF7MHWcf4/zKi35CLxiuk0duQHzNwvV8ZNrVoKWHvZN6sDk
        JeX4UUK0OEIOaYIi1b4zXzvEkK0+cpR9Jg==
X-Google-Smtp-Source: ABdhPJxclQOGuqU3UJlaoL7qGT9UC/IzL0vensrE4bo1vFuZbVt/+Tt8eDidFC3p8hOnhvN7OUDDhQ==
X-Received: by 2002:a05:6808:219b:b0:326:6a98:468d with SMTP id be27-20020a056808219b00b003266a98468dmr133193oib.32.1652191428830;
        Tue, 10 May 2022 07:03:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j28-20020a056830241c00b0060603221264sm5680108ots.52.2022.05.10.07.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:03:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <69d1a3be-1a39-6c92-0db7-7318033e9a52@roeck-us.net>
Date:   Tue, 10 May 2022 07:03:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220510201104.06eead74@canb.auug.org.au>
 <YnpCqh9+koMal9sD@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YnpCqh9+koMal9sD@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 03:47, Zev Weiss wrote:
> On Tue, May 10, 2022 at 03:11:04AM PDT, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the hwmon-staging tree, today's linux-next build (powerpc
>> allyesconfig) produced this warning:
>>
>> WARNING: unmet direct dependencies detected for SENSORS_NCT6775
>>    Depends on [n]: HWMON [=y] && !PPC [=y] && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
>>    Selected by [y]:
>>    - SENSORS_NCT6775_I2C [=y] && HWMON [=y] && I2C [=y]
>>
>> Probably introduced by commit
>>
>>    58f1d9ebfce6 ("hwmon: (nct6775) Add i2c driver")
>>
> 
> Ah -- yes, thanks.  The Kconfig symbols in that patch series underwent
> some changes between revisions during review and I missed a couple of
> places that should have been updated.  I believe the patch below should
> fix it.
> 

I squashed the patch below into the patch introducing the i2c driver
to avoid later bisect issues.

Thanks,
Guenter
