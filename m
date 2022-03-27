Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC9C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 00:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiC0AyL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 20:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiC0AyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 20:54:10 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD366F9A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 17:52:32 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 062CC37DE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 19:52:32 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YH8xn6hTTHnotYH8xn3ZYU; Sat, 26 Mar 2022 19:52:32 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gKYE2iuv09CuEj+uGDaOjlX/j1tF/yC/Q04JpIsU1qw=; b=DFIisHyOPQGixCr1CzJyQxLIPS
        I6sO1xKjivpV4mNtD1ilDMbYnDEgwz+o9E+qjONfJ0+MyIufocJmdA2W+6ObIKGQOwH/fpHXKltVs
        wrnZk9Ev27IT4UccMeU8h1UfgmdYCwX4IvPu8Yp2vE47m0V7rDUlShmYwVSfk5w8C9r+BsIfouoXg
        G9U4XOluAsPrnXU17BWvMufzGW/ThVAkIfX6n2+v+8eELfuFdhrt27yl4ik11Uz/kkr3xNTzmVTXy
        mEjcWY35s2cB9/zOX8F/cNNhnO7JjUtt4cdP2024j+FT9aQmUZqrFFCEDnFH5M1XeaW3Dk9nyRQr4
        5cFv6zBQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57692 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nYH8x-001Ftd-9n; Sun, 27 Mar 2022 00:52:31 +0000
Date:   Sat, 26 Mar 2022 17:52:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.16 00/37] 5.16.18-rc1 review
Message-ID: <20220327005230.GG1645909@roeck-us.net>
References: <20220325150420.046488912@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325150420.046488912@linuxfoundation.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nYH8x-001Ftd-9n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57692
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 90
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 04:14:10PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.18 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 488 pass: 488 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
