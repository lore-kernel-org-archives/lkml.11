Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB28C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 21:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiCGVR4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiCGVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:17:53 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5532D70929;
        Mon,  7 Mar 2022 13:16:57 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p2so2228818ile.2;
        Mon, 07 Mar 2022 13:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:in-reply-to:subject:to:cc
         :content-transfer-encoding;
        bh=l5EXFhGXFRuVLUnV8TV4Nk308uSAXsQfq7R23cqbFRM=;
        b=WZ1ibtu4xfZf/nChHEXkgTZGxeHKutEYGngYzAVQexgW3uEoXaoINV3746r2Ez+B66
         bp/bzbdVOJ+q6X2nvQ6GaIoWiyVxsuSmcuxcQuETWhdWEoq6UnPpCbtQvLj48LWfjnJs
         3YLFRoKk6Vnnikcf5WyvDjTGHI85+FMqhtHslYqxnOFoeFijKAVC9kebCPouxzLisqE0
         qQb//im7oH4rAf6vONyZMjFOsK5Y1d0jTbcwswJ/BXoNS2SH0Hx3C6TLAPNWmgPajuaI
         r7LKje4ERc8dLvEp5MROUyNwjrIt3aPqvHkCsV6BrW0uINO1Ov9L0NbY335Psu6T5alj
         bnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:in-reply-to:subject:to:cc
         :content-transfer-encoding;
        bh=l5EXFhGXFRuVLUnV8TV4Nk308uSAXsQfq7R23cqbFRM=;
        b=PE65auKpa7QvoEgwhWT3N4iLjettVxA/K/XvCbuRjoMMt5lekFzTc6T1eeutWGoM3i
         4uEMCSJyvneVXeMBjRSaHdG2Iw9CELgayxEdCmFTaw4LAb1gtkiIhYAL0wcM6EahjEKp
         fQHGIDfTUy7YI4ATODHm8MxJOIHYdkTOU2iYrTwt8s8XtUAEfRaKTdeFsQ2W9C+jb1j4
         xxZHMdJLR55n0UL/8WrbesPveflRYhWM1q10R8yx9/11+UO5FoXdjG18w6jV1VkCyul/
         UbeXyzbzZfqi2DGRsmidHCjtyMmQq5/sFw25vdjjs5pyqdOj8QO9a4aUxtLxitixsJzq
         CZtg==
X-Gm-Message-State: AOAM531UAbDtPIGQwRnkgwsHhVwxu4ErBuU127RZXnuOYoCc2Fna+uTR
        tQmHrHqf95ZrpgfRuvBzFMpKXtSfAqX8reZ2XmLYmA==
X-Google-Smtp-Source: ABdhPJwnOClQcqPNVImC5jpm2wG1glgOAFJbxJjTXMclRXTgFzSqWNcNLZ8VdB2qMYIOx7mFW/IImA==
X-Received: by 2002:a05:6e02:5d0:b0:2c6:23cb:2fa9 with SMTP id l16-20020a056e0205d000b002c623cb2fa9mr12324568ils.68.1646687816285;
        Mon, 07 Mar 2022 13:16:56 -0800 (PST)
Received: from cl-arch-kdev (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id v18-20020a6b5b12000000b00645bd8bd288sm2527937ioh.47.2022.03.07.13.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:16:55 -0800 (PST)
Message-ID: <62267647.1c69fb81.7d635.af99@mx.google.com>
Date:   Mon, 07 Mar 2022 13:16:55 -0800 (PST)
X-Google-Original-Date: Mon, 07 Mar 2022 21:16:54 GMT
From:   Fox Chen <foxhlchen@gmail.com>
In-Reply-To: <20220307162142.066663718@linuxfoundation.org>
Subject: RE: [PATCH 5.10 000/104] 5.10.104-rc2 review
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Fox Chen <foxhlchen@gmail.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Mar 2022 17:28:41 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.10.104 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 09 Mar 2022 16:21:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.104-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

5.10.104-rc2 Successfully Compiled and booted on my Raspberry PI 4b (8g) (bcm2711)
                
Tested-by: Fox Chen <foxhlchen@gmail.com>

