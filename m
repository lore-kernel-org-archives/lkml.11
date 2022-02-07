Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D487C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiBGVYd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiBGVYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:24:32 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC14C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:24:31 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h7so18666055iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oT+LNhuj9fD9A69yds26bgbcEp0sloDsTmyXN4K0Xmk=;
        b=Rhqz87i9T4+CxZsMtaXLI8MHvLL4EXu/XJMC9i4QlAmPc4+LVmVf+qOrml9gTiLmSh
         O1ga2RwU5p1frAuK1587Z874ZDUltdb9uPy19ipZ2ZQAUqIHuz77OcknV0fEvmmcQx0e
         Mqbi6DSmlYBbpIk1Qeht7nI39BSWRxp9GT8KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oT+LNhuj9fD9A69yds26bgbcEp0sloDsTmyXN4K0Xmk=;
        b=G+TaSsoYHeZWQFGqak1kA+RUpitO/ssd1KEmrGkpqNucIGmiQTXCRljscTCtQQWtCJ
         NADYZDkQSexOS6BBltX+vxsMg4cov6X/wX6uBsR39VZ7EpwoP2f8KGVXdWX5zfiTFxlQ
         /i/vshQYFtBoIMrA98zhJSFBKSL5udo6rrMK5fku/QbZ/hfeo2aquRhtooFtWMOPGFuu
         1uxvIjpBI8o6YAWNf3wyC4OPAQGKIWpF3D9w3tYtlX2U9Ta7KDtT8lCN5uGlNMXpKbTB
         yo4oYUga+wk36kbXl8Z7+oTjG+VQs7IewhYzcKef8/bUvyOWcx9EmyTglnCx4yq78Q/f
         Shsw==
X-Gm-Message-State: AOAM533URv9Mhizm9c3106du/BFNnWicV8lB9wjHjdcSii9tkvDt+cTy
        EVlbbkaJO9rNI1WdvS+5Z8GsGQ==
X-Google-Smtp-Source: ABdhPJxA0E2chBY0z2MCza+jd2jsW8HuoPBbISUT7x0avVdGWPrUm7HKgjsPkG+4GXe47poOWCEiaw==
X-Received: by 2002:a05:6638:1028:: with SMTP id n8mr775381jan.318.1644269071143;
        Mon, 07 Feb 2022 13:24:31 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i3sm6304980ilu.28.2022.02.07.13.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:24:30 -0800 (PST)
Subject: Re: [PATCH 5.15 000/111] 5.15.22-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207133903.595766086@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2001dae9-5137-9f0b-0672-f89bb35ce94b@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 14:24:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207133903.595766086@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 7:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.22 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Feb 2022 13:38:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.22-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
