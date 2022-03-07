Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A878C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 15:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiCGPYq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243574AbiCGPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:24:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE4E70CC5;
        Mon,  7 Mar 2022 07:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 603CAB815E0;
        Mon,  7 Mar 2022 15:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957FFC340E9;
        Mon,  7 Mar 2022 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646666627;
        bh=lkV/7UN2kW+KOHRiC8zLasgxJcQG73Hgpx6BBaDabI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weaZrAhlIEGAGwfO9Gm6dU/DC8NMLi73mIs2pSbpVQ9besyXaj6lPLjzBLXoLBzmX
         PVOzepAC6X8w1f1XRscjVD71scLKodXhf5vrhP4ayz5R3qVxgOGXFkHFSfJy813ktm
         26iAcclWMm3ibESrPW9/rJU8kKpcAgQACB4lLFbo=
Date:   Mon, 7 Mar 2022 16:23:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 000/262] 5.15.27-rc1 review
Message-ID: <YiYjgPn8lbsD/dUb@kroah.com>
References: <20220307091702.378509770@linuxfoundation.org>
 <fe8b46f5-6c24-d749-668f-29ea51fa5d58@applied-asynchrony.com>
 <5e048582-5c63-38c2-bbcb-6a0c20cb47e4@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e048582-5c63-38c2-bbcb-6a0c20cb47e4@applied-asynchrony.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:41:15PM +0100, Holger Hoffstätte wrote:
> On 2022-03-07 11:44, Holger Hoffstätte wrote:
> > On 2022-03-07 10:15, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.27 release.
> > > There are 262 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.o
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:30:10: fatal error: dml/dcn20/dcn20_fpu.h: No such file or directory
> >     30 | #include "dml/dcn20/dcn20_fpu.h"
> >        |          ^~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > 
> > Culprit is "drm-amd-display-move-fpu-associated-dcn301-code-to-d.patch"
> > 
> > Looking over the git history of the dml/dnc20 directory I think the correct fix would
> > be to also apply upstream commit ee37341199c61558b73113659695c90bf4736eb2 aka
> > "drm/amd/display: Re-arrange FPU code structure for dcn2x"
> > 
> > CC'ing Qingqing Zhuo for confirmation.
> 
> I can confirm that applying a modified ee37341199c6 fixes the issue. \o/
> The hunk that refers to drivers/gpu/drm/amd/display/dc/dcn201 needs to be removed,
> since that directory (support for "cyan_skillfish") does not exist in 5.15.x.

I'll let you submit a working version, dropping chunks in the middle of
patches is not exactly obvious at times :)

thanks,

greg k-h
