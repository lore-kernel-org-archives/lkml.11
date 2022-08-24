Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80170C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 06:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiHXGHG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 02:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHXGHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C634A6F560;
        Tue, 23 Aug 2022 23:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 600F46105C;
        Wed, 24 Aug 2022 06:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD94C433D6;
        Wed, 24 Aug 2022 06:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661321221;
        bh=T4PSHcW+eSRrRSs41UJ4xXJ/QLhNiweN0QD3eOMT/4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvLR7ehpr7AAnBqQgL8avW0x9NIbcrMPd8Fzy0KNqxeujBYh0YYCURfY7mnxR/ZiF
         VdBH57J92rDj0pcbOCQZM3L7rzxb9zRAzwgq4XQW/xIqA7F/qLJf8fwA+orPC99R72
         O1Cn39jwYARSzq7vD/S+O6U1xcw+nkh5gyymnH3w=
Date:   Wed, 24 Aug 2022 08:06:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.19 000/365] 5.19.4-rc1 review
Message-ID: <YwXAAtL8082my6dh@kroah.com>
References: <20220823080118.128342613@linuxfoundation.org>
 <20220823211620.GA2439282@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823211620.GA2439282@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 02:16:20PM -0700, Guenter Roeck wrote:
> On Tue, Aug 23, 2022 at 09:58:21AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.19.4 release.
> > There are 365 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 25 Aug 2022 08:00:15 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 150 pass: 149 fail: 1
> Failed builds:
> 	um:defconfig
> Qemu test results:
> 	total: 489 pass: 489 fail: 0
> 
> arch/um/kernel/um_arch.c:447:6: error: redefinition of 'apply_returns'
> 
> I don't see the point of commit 89164a58fdc9 ("um: Add missing
> apply_returns()") because it results in two sets of apply_returns()
> functions.

Odd, the commit lied :)

I'll go delete this from 5.19.y, 5.15.y, and 5.10.y and push out a new
-rc2 for all of them.

thanks,

greg k-h
