Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B087EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 22:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379239AbiFPWze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378754AbiFPWzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:55:33 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DE06212F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:55:32 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1016409cf0bso3592816fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EyvJseAKA33VxLuSPD/KqIItoVoJnWsD5tPgzIRSfk0=;
        b=cFQc89Kh8mS8WI32omCWsF28H+iEoG4YWcqt4G3xmV+tMBK1JUB7e6Tk467rlvKL+q
         Wcnrx+ik/BIePyQBAKdV6g9IqaTryblxJY7oy1DJ1dKuMhynHExaqm1FYFRin0c+i89F
         qGr2aje+WK1A8HZFoAqv8lEzXf0ccT3z1Diss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EyvJseAKA33VxLuSPD/KqIItoVoJnWsD5tPgzIRSfk0=;
        b=RE9/j8vsF0UaisclEHzRY4tQwyaCjSR+l2NeLypVQiEbj+fDniOfqaRJNjzHgTQ0lk
         gy47w6aBmCvlm5zUdmk5zBBgC/W3panNkBu267wbLzytCzyB/lwkn07UfNCGpdwNbH0h
         /h+gjar1Zhu0Z0Cq0aX/ZMu22P/hpr4/G4J5Z6aKSKEyS2aW/9pLqMF5mFZ71LwJ3m/G
         8oVlr4RrTLkSD/YXUYt9QN50Igdb8l72+Gk7iYD8XbweHJXn+c7wDvV8e4kyUgYW+XV7
         WgXhiCmvNDeboMha84NepPg0yrLf85l/1Iz5Kcci8FRIqhf3E/W2VbAlZjrV1aoxpflC
         A17w==
X-Gm-Message-State: AJIora8QpG4IOX+0jXqhj//1CyWC80BxPKZABtptUV1HCBjPgYyINtNk
        mtiDsGrzveNZ6FxgWaWCYivNeA==
X-Google-Smtp-Source: AGRyM1tSctUJdSQ/TjLU6aUpm/5aGOC4Xrd/5azPNZHjH7a2JYSM9SAM8WKr+m0btTzn9hdWxUchQA==
X-Received: by 2002:a05:6870:c890:b0:fe:5223:29f0 with SMTP id er16-20020a056870c89000b000fe522329f0mr10067851oab.6.1655420131764;
        Thu, 16 Jun 2022 15:55:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k2-20020a4adfa2000000b0041ba545a844sm1674431ook.32.2022.06.16.15.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:55:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] selftests/x86: AMX-related test improvements
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220401221014.13556-1-chang.seok.bae@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <86661dd7-6ca3-dc72-dff7-782a83ba7bc5@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 16:55:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220401221014.13556-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 4:10 PM, Chang S. Bae wrote:
> A couple of test updates are included:
> 
> * With this option [1,2], the kernel's altstack check becomes stringent.
>    The x86 sigaltstack test is ignorant about this. Adjust the test now.
>    This check was established [3] to ensure every AMX task's altstack is
>    sufficient (regardless of that option) [4].
> 
> * The AMX test wrongly fails on non-AMX machines. Fix the code to skip the
>    test instead.
> 
> The series is available in this repository:
>    git://github.com/intel/amx-linux.git selftest
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/Kconfig#n2432
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n5676
> [3] 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
> [4] 4b7ca609a33d ("x86/signal: Use fpu::__state_user_size for sigalt stack validation")
> 
> Chang S. Bae (2):
>    selftests/x86/signal: Adjust the test to the kernel's altstack check
>    selftests/x86/amx: Fix the test to avoid failure when AMX is
>      unavailable
> 
>   tools/testing/selftests/x86/amx.c         | 42 +++++++++++++++++------
>   tools/testing/selftests/x86/sigaltstack.c | 12 ++++++-
>   2 files changed, 42 insertions(+), 12 deletions(-)
> 
> 
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> 

These are fixes and I can take them through kselftest once the review
comments are addressed and get an ack from x86 maintainers.

thanks,
-- Shuah
