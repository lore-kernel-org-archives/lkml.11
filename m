Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F2DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 08:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiCKIP1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 03:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiCKIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:15:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852E1017DC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:14:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 9so7088362pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vjht4VjT0qP1PrjcnyRToI5pLA60dRVnlKZQmWleY/U=;
        b=oI4ar1HB51LBrLmbj/wtrBaWW6l4roM7ESsTGMRB9dhN2Hcp29WpYsyZY9rWS9EwxH
         abeTHaIOijZcALiFhzhJ5F83AIFNnYHMsdRURSoj4fxWQAoGv6uxuLT+ac26072g9mhb
         s0V8ep9BdbVbe4ESy0g5oO0jF/UarS3a4063M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjht4VjT0qP1PrjcnyRToI5pLA60dRVnlKZQmWleY/U=;
        b=SnK4eqqZxqKwJouE6qYXPvTxNOzyNqjLwC0fSJussYs3JbFfnBfD9avRl2XR4agNSe
         HKy39HH2mU9DxKfrz7dAKyFDyICvAskyPuFHt29SjkS1iRzN33dM5IbV/VoTSSHGKqwj
         +zu+LGtuZq+UBTQN4+GAfSdW/4omzbp1M+wnTsCP5T7p/nLfgiGB+5488KAFcggnP8b8
         pBmtMWGjBFZbJQaQftKcOtYCa7255dKdiRwVaaxoc2VLK7+X0bnlq/IS9Ynt3hQhQ+uu
         EaMOKyEmS5zXc7d+5clot79KU/J08rOEx3rTLM3OlnAcJYEEhNiBXVjJlSfliWB4tlAi
         n3FA==
X-Gm-Message-State: AOAM532mlyb788t14gwBXaZYIesrTXt2Y08EcZgt0plL4uwBzW1L1Nps
        tuNS0NQ21cyG1pO2NOE57dvGdA==
X-Google-Smtp-Source: ABdhPJz/saDmNql9Jq1CQ7il2FyVSQ7Bh16oUvFbLTU8pS5XMo0dn0zdMXb1+6ruIfhTQsBNccvZGA==
X-Received: by 2002:a17:90a:e2cc:b0:1bf:711f:11e7 with SMTP id fr12-20020a17090ae2cc00b001bf711f11e7mr20407339pjb.40.1646986461176;
        Fri, 11 Mar 2022 00:14:21 -0800 (PST)
Received: from 5fcf59323384 ([203.221.136.13])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm9862257pfv.199.2022.03.11.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:14:20 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:14:11 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 00/53] 5.16.14-rc2 review
Message-ID: <20220311081411.GA7@5fcf59323384>
References: <20220310140811.832630727@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140811.832630727@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 03:09:05PM +0100, Greg Kroah-Hartman wrote:
> Note, I'm sending all the patches again for all of the -rc2 releases as
> there has been a lot of churn from what was in -rc1 to -rc2.
> 
> This is the start of the stable review cycle for the 5.16.14 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,

5.16.14-rc2 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Tiger Lake x86_64 (nuc11 i7-1165G7)

In addition - build tested on:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
