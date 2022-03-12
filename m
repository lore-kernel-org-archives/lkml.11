Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335CEC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 05:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiCLF1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 00:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLF12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 00:27:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD31C945F;
        Fri, 11 Mar 2022 21:26:22 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q19so9168565pgm.6;
        Fri, 11 Mar 2022 21:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ArakzioBrqK8o1Rg//BoZTjKcCVB6ojSonL6m8+DLrA=;
        b=F+4gI4YFnK1Z2PIY+QM9FiLfp/ImHLfBOKGROysUnYzRCSI7mMFKEo++PE3FqxgrA8
         HFtve2DUgZmMd6Z1cqDA/ImK6jta8AuBUXGzKMMC6QxYo1rCzR4D/k/yfjtlJONpGc2Q
         Wm3Ar+1qq2dnB93IiAT2zi1wdTuINQrBcKIhEKNySHubFDpvBfOT23WEsOhOTUNbBaYI
         JsrMxgK6xOlm84UHNSADMxBn/SeHuYEcdZUoiA9Zai3yLHC0FARJWSR4aib+9vT4oQjf
         QjoDT8Pksnol0St/prkAew/Cnnofi+IKlk0dli+4DhNGeqIiZdvYHacxM3S80gySHvyY
         0ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ArakzioBrqK8o1Rg//BoZTjKcCVB6ojSonL6m8+DLrA=;
        b=gnWtYvf1XjwGlSRLSbEhrphElIkUqrzJvZwzOSzcvDtL+c2Z59C1YziLPIQ9PnNlDX
         22LE3AktKSyEhkzwxWRO8GbMCgqZSnGF6sazIMAVpVcwyRX0Q/sLXcW3uP5HNDf0/KTT
         jlZLKNnsGiI9RAwcmMJ0hEVjRmLCtUMTonwNlfjZ9UJp85/ERqVu/lkMFRBQq5O5iMpA
         j+NvBpdZkmoA4CODp2qRyNebby3eeU+u/eltzoPvdqhFmoeUyHiTMXF9qUv+VSTFzhha
         mkPzs4Nq821IvAZ/VPsHyaCdRPYb22uj32O+AZyXy2/MPjPeM3amB8NPj4nlTmK37RPQ
         ZboA==
X-Gm-Message-State: AOAM532b2iOk7RJz45xUqDEiEpgVXJyYmWkzcbBPf7F+HMdkWp2snCRd
        FaZHKvuCGZnG4pIri0ccQyI=
X-Google-Smtp-Source: ABdhPJwxwL+dXotlHPMkJ3SCeDXiR4mCL0gOJBL05ntje/d/N2nzkctJJ4uYmMWtJ92XH7MhcJ09qA==
X-Received: by 2002:a63:1350:0:b0:378:7fb4:63eb with SMTP id 16-20020a631350000000b003787fb463ebmr11246291pgt.457.1647062781984;
        Fri, 11 Mar 2022 21:26:21 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id n18-20020a628f12000000b004f743724c75sm11977684pfd.53.2022.03.11.21.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 21:26:21 -0800 (PST)
Date:   Sat, 12 Mar 2022 10:56:17 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] DT fixes for pl022 for Arm realview, versatile
 platforms
Message-ID: <20220312052617.GA13444@9a2d8922b8f1>
References: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:06:31PM +0530, Kuldeep Singh wrote:
> This patchset is an attempt to fix device trees and resolve binding
> warning for pl022. This requires updation in clock name to keep
> alignment with other platforms and spi node properties for integratorap
> platform.
> 
> This patchset is based on
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git,
> master
> 
> Kuldeep Singh (4):
>   ARM: dts: integratorap: Update spi node properties
>   ARM: dts: realview: Update spi clock name
>   ARM: dts: versatile: Update spi clock name
>   ARM: dts: ste-dbx: Update spi clock name
> 

Hi,

Commit description for patches 2-4 is incorrect.
As 'make dtbs_check' has always been working correctly and can identify
character casing proficiently, it's just that I had some mistake in my
build environment because of which no warning was observed. Kindly
consider this version as obsolete. I will update commit description
properly in next series. Thanks for your time and sorry for
inconvenience.

Regards
Kuldeep

>  arch/arm/boot/dts/arm-realview-eb.dtsi    |  2 +-
>  arch/arm/boot/dts/arm-realview-pb1176.dts |  2 +-
>  arch/arm/boot/dts/arm-realview-pb11mp.dts |  2 +-
>  arch/arm/boot/dts/arm-realview-pbx.dtsi   |  2 +-
>  arch/arm/boot/dts/integratorap-im-pd1.dts |  4 ++--
>  arch/arm/boot/dts/ste-dbx5x0.dtsi         | 12 ++++++------
>  arch/arm/boot/dts/versatile-ab.dts        |  2 +-
>  7 files changed, 13 insertions(+), 13 deletions(-)
> 
> -- 
> 2.25.1
> 
