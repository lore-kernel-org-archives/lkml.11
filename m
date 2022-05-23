Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 22:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiEWW5F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiEWW45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:56:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252991DA64
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:56:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s23so16763421iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X1SWmkeGkSUF/9KeZ0zt+F6Uh6DFUnKj5kOBRkoubZo=;
        b=aEWsiwxQaH6b/ILJ7R2zhGPqyc4MnMEqmJJlOhRIZhBYE5033B4ouGg3H1vWyC5PdM
         iSX31tixi2e/WlaBOVoW2HLx0g62WKEca7BGVo+OVX+0qRGDQ5jmwcNlqNlD6oYXRF8T
         nPoH8auC0ewhmzo39H5Kpzza3zG2fUzUF+s0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X1SWmkeGkSUF/9KeZ0zt+F6Uh6DFUnKj5kOBRkoubZo=;
        b=fj0+ka9VaE4H+c6ZblndsU8FWx6aq0PmVXswri2dH9mmSK3ifGjvLF61vXstrWcX8i
         IvEaLFTRAGjIkQJNhl0t/353RoEKDT03AjrR0vOJabvwKz3c7/pE/+fCwWOxK+NN/7fL
         c8O0Zgs6sV1n0HOhhdS66ueaYLPIwINCKz8EGdL1OUYxtlLX3ZgggdIavmvq0zrzF3A9
         QWtWGDdFVGmrOQQmXASepdumxSo+FV+nWvUKvkCQ68FC2LLRV7lkO6noqQhCBd7HXgel
         QUliVnjgBlVTpsgslj+QXu8fcQDh8rymJxYGKzTnJyN2KRyE8s9VSsIhDlxdwd7IwvF6
         GWBg==
X-Gm-Message-State: AOAM532kCqO4Q+Np60U/K4v5pr2DKi+lXZlIIc1y0qlDnTntdwfrVrFF
        7nM3cNb2F6mNSm69wmj179y0HA==
X-Google-Smtp-Source: ABdhPJxxQN+Avt65SledOIhzbV8PnzdnQ39akjFQrfj6NyunJJDOyzaVDfyxC/6JvYVz2rpFxcCMaA==
X-Received: by 2002:a05:6638:1182:b0:32e:5c70:c89c with SMTP id f2-20020a056638118200b0032e5c70c89cmr12309820jas.45.1653346610839;
        Mon, 23 May 2022 15:56:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s15-20020a056e0210cf00b002d1639e7187sm3533592ilj.50.2022.05.23.15.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 15:56:50 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/97] 5.10.118-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220523165812.244140613@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6191920e-30e6-d5c6-460d-1e1b0a0c405d@linuxfoundation.org>
Date:   Mon, 23 May 2022 16:56:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220523165812.244140613@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 11:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.118 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.118-rc1.gz
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
