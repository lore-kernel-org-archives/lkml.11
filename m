Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26224C4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 23:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiCYX15 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 19:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiCYX1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:27:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC769515BE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:26:13 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z6so10688107iot.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yy74rA8noXhQ5yzpgAKEc9dblaA2puoqp1eQzGKa4AQ=;
        b=TaG2N2nXrnOVsIeHhVTma4w32cGs/g5sIG27D0TSou0xpUu1js4f/fXQLA9V6Uwffp
         +SMS0Sn00wa9EYV5Ws7kTtAjzoRrlo03ct3eBx0LfDDpPlc4zOPOQ7YGu+shmTH4JFSz
         4o3LMTHrvFfl27/bTbxL2QiyAnslW4mbWU7Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yy74rA8noXhQ5yzpgAKEc9dblaA2puoqp1eQzGKa4AQ=;
        b=fyPWyDAIkYKn5rQRLIMYkRWoixw/cMA67i+06cJVCKxyuSYw7VRkRroxPH32/ZxB8G
         u2mo1EkFpRjk9V7zEqHUhkwe8zgan56ycHRXPpS/9+HQVo2s2eqdY99Iv2Vp2R0FYwQg
         4+/HHB58FXTUsXh0mYMBxzfnYtLLyfinpnNH7wh97zctxVK/Ff3y2VwT8ELENUMpGUsw
         vdRxFsXmdIkk0/uY8Hz0FKIwviYeKJQNWHYJrJEPQ9wEewQmZlcwqesh+I/fnfGVLaMO
         pGCp6p5GBdVP8JN6tZ2nPof1KYa6N9eXPbb02oIPyuIPXfZx8Fkpb9yyHn0sHdvBjV3M
         uZIw==
X-Gm-Message-State: AOAM5325SYmSm53lAgzfaTn1Gwm1E4rheFwDEWOhPFXa+SaVbSunYRxS
        NOPPJ+qq/xFi3SeGQw4dY2c9/g==
X-Google-Smtp-Source: ABdhPJxvbKKIHSTkK76iJyXXUp7M+m0Nhg3S7b+AbYFC1GdS1eMWcecPII+MlycEQwHcu3OCC8bZjQ==
X-Received: by 2002:a05:6638:2395:b0:321:23d9:9b30 with SMTP id q21-20020a056638239500b0032123d99b30mr7313594jat.289.1648250773212;
        Fri, 25 Mar 2022 16:26:13 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y3-20020a92c983000000b002c7dce8329fsm3510321iln.72.2022.03.25.16.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 16:26:12 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/14] 4.9.309-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220325150415.694544076@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8fe8dc16-9980-5ea7-04fa-65470b050010@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 17:26:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220325150415.694544076@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 9:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.309 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Mar 2022 15:04:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.309-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
