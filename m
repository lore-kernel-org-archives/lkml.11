Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3C7C32793
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 21:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiHWVsz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 17:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiHWVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:48:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B71AE48
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:48:52 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o204so10082493oia.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=lXCRqCCIH1YAB4gL938QpUCgeP2WdQkQh7g9W54pV3w=;
        b=W6F3nJETDAwqVpM0XnT5cj35I2KYLgWg8OXMNtTl862CSIKgQXpme5xk1Y8Y44xwgJ
         6+WGwvGK7/z+lawTZtsOiY/q9CWgALGyBxNtMKgyf2QYGPyuzDbidRTzMLxKey06c20w
         lZrSKAUcpJstDAV4eXoI6XW+X4YiTVvUhFdpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=lXCRqCCIH1YAB4gL938QpUCgeP2WdQkQh7g9W54pV3w=;
        b=nUG20i1oMUqMCVV6DOjh64ApL1V44oPrdibHFPHFkpwPgW0rhKSKzvP+N2DvoAdxmW
         1Qoen8gnTYE/dRYDVL9kZS+1PpDgd9tSeIpVkmXZbxCVayJMc5VKQuibXd4MEDXABWgi
         MujB1daq+SN0TIVmBXrqyYRxAZtHrv9ygrTuyhADZBv9iLsPntiBDq0Y4l/TiccdetWq
         jVCdQZuoGTLWjG+eme7kSOJ1xN9NyP5K1erc7xRTXfjBg2SNf83bkBbWYx9tP3TgyJ9y
         VgWzgBOmT/qjD2X9lPblEeQglR7IdrJWJTpp6F45proP5M2Fvek6KmsSXPXJYS2f3wCs
         vLXw==
X-Gm-Message-State: ACgBeo08pnki02J0gZHF5KzejEsM6JwFPQsqEKolnkqWH4TWQbE+645S
        G7WY2LLtKQLHfrnRYZQMApbmFA==
X-Google-Smtp-Source: AA6agR43gF4It8UKNsgaVMc7vb/J+OXIAUUI1iSGeRfGcxOF8DqfwOnjZcLxVy27ajbnTA33gN4jYw==
X-Received: by 2002:a05:6808:f15:b0:344:92cf:22b with SMTP id m21-20020a0568080f1500b0034492cf022bmr2208885oiw.90.1661291331914;
        Tue, 23 Aug 2022 14:48:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h17-20020a056808015100b0032f0fd7e1f8sm3692713oie.39.2022.08.23.14.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 14:48:51 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/159] 5.10.138-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220823083146.854628728@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a6698036-4e42-0634-1a91-4ba851dda417@linuxfoundation.org>
Date:   Tue, 23 Aug 2022 15:48:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220823083146.854628728@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 2:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.138 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Aug 2022 08:31:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.138-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
