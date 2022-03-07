Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1215C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 15:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiCGPS7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbiCGPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:18:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41EA50069;
        Mon,  7 Mar 2022 07:17:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51A62CE10C2;
        Mon,  7 Mar 2022 15:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163CAC340EB;
        Mon,  7 Mar 2022 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646666276;
        bh=uqyrsemsbiCBvuiaRtl+MNqCGa0Z70W2a9m+jp91M2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+ZNWJ4u53E/YpV5raYTl+5IC5U0clCuC5RCbgduh3lxqdScg2YReRgLnhroSqSOf
         GI573HeHE/KMYy/TtC2jPDXZtatuJZcsnsX7b7iGM2a29//G83m16ggLoo6nnz6s10
         rFjfMe7UdORTF5uPVmXAcfa0k/CX3GfzUZg8x0Bk=
Date:   Mon, 7 Mar 2022 16:17:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.10 000/105] 5.10.104-rc1 review
Message-ID: <YiYiIZMJTUkx6cu2@kroah.com>
References: <20220307091644.179885033@linuxfoundation.org>
 <d71d84d2-5aa2-7d72-9fdb-a0ac203cefb2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71d84d2-5aa2-7d72-9fdb-a0ac203cefb2@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:15:02AM -0800, Guenter Roeck wrote:
> On 3/7/22 01:18, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.104 release.
> > There are 105 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 09 Mar 2022 09:16:25 +0000.
> > Anything received after that time might be too late.
> > 
> 
> 
> Building powerpc:allmodconfig ... failed
> 
> In file included from include/linux/module.h:12,
>                  from drivers/net/ethernet/ibm/ibmvnic.c:35:
> drivers/net/ethernet/ibm/ibmvnic.c: In function 'ibmvnic_reset':
> drivers/net/ethernet/ibm/ibmvnic.c:2349:23: error: 'entry' undeclared

I'll go drop the offending patch, thanks!

greg k-h
