Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F7CC433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 01:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiCZBXq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 21:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiCZBXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:23:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8332A5AA7;
        Fri, 25 Mar 2022 18:22:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t4so4719072pgc.1;
        Fri, 25 Mar 2022 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:in-reply-to:subject:to:cc
         :content-transfer-encoding;
        bh=D7K0kdAFx5XSFJ+m4rzI3hM8NM4+hMJqlBRG593utMQ=;
        b=VWNrITceuY8rPGZesl1dtoB+Sc7wOGazalX8UymCmNcRDrABBh/Li+VAFma6TvqoM1
         dOndekWIlNlYAXoVdUOSUZtZbyVV8YcWKdKP4iBdTE9iqLkhswAUYMZbGAD0YBIabi67
         0d+0P0PVxSOCISkU6TDA1HEk1D2qol4XXd67AYAwujHfk+Nk45WnBMGCRDOh4H4/WGYv
         6ueOHY9zEFFRxXzPEUvFBxCdScLIedT6ZXOaq+nBAxjbtpsrKx3fAzTnk0YMrMugb+N1
         xyzrWxLXTUyU+uDFNgj9C1P8/QR1Dls/bl/cT6udO/aEeqPmleTp35HG5xeZqM34VErL
         FDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:in-reply-to:subject:to:cc
         :content-transfer-encoding;
        bh=D7K0kdAFx5XSFJ+m4rzI3hM8NM4+hMJqlBRG593utMQ=;
        b=We1dwykusUy5cYMhF2OBe95SSxi6uGZd8gZxqeCyfVkyPrGl5nodWQ5l72YGp7DTeK
         iO9oAErnXhFubV9SreYSgVQ4vVBc9n5I9wvfY+MbAPvgBTw+mOJQ+neh83aRUHF7ytSJ
         F4/arc0jihktuMSM3bIP5pHMYnwWdLELJEaYZjaE2tmXb0Ca/tNvPTnNOdYQM9KSzemL
         oX6HM60p+48iQtBwqjmahiQtuGP2w7bE964h0MuX0AImSXX+x83sYOarVo5KtHH4Rpqp
         48TVk294EKsRVdaYB9ogwCOKbe+RPbK9QEU5tMo+AZsIJ0VBPu1Y74OJ9zhB+jN3/myn
         96aA==
X-Gm-Message-State: AOAM533IsqHbAhnqjE6ChG0wPb7Bwot53uRK8eDnSssxq4MbWkuSupBx
        2Ps2By1gVUtw/HRNtWYxLSRZfOvz7/tpmjJdNK5uXw==
X-Google-Smtp-Source: ABdhPJxX+9IZeItEcA/px1aSyFLpCMmkvZt1fSYolg8tN/DGuCFl4sYK1KgA3W8j1sQW2xeR8pj/AA==
X-Received: by 2002:a05:6a00:b51:b0:4fa:ece9:15e4 with SMTP id p17-20020a056a000b5100b004faece915e4mr11284456pfo.27.1648257726809;
        Fri, 25 Mar 2022 18:22:06 -0700 (PDT)
Received: from cl-arch-kdev (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a8b0300b001c735089cc2sm6926131pjn.54.2022.03.25.18.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 18:22:06 -0700 (PDT)
Message-ID: <623e6abe.1c69fb81.52568.3eb6@mx.google.com>
Date:   Fri, 25 Mar 2022 18:22:06 -0700 (PDT)
X-Google-Original-Date: Sat, 26 Mar 2022 01:22:04 GMT
From:   Fox Chen <foxhlchen@gmail.com>
In-Reply-To: <20220325150420.245733653@linuxfoundation.org>
Subject: RE: [PATCH 5.17 00/39] 5.17.1-rc1 review
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

On Fri, 25 Mar 2022 16:14:15 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.17.1 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 27 Mar 2022 15:04:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

5.17.1-rc1 Successfully Compiled and booted on my Raspberry PI 4b (8g) (bcm2711)
                
Tested-by: Fox Chen <foxhlchen@gmail.com>

