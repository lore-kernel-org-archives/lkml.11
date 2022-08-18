Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDCC00140
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 05:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiHRFBB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 01:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbiHRFA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9209998D2C;
        Wed, 17 Aug 2022 22:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA356154E;
        Thu, 18 Aug 2022 05:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A743C433C1;
        Thu, 18 Aug 2022 05:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660798855;
        bh=mEALzKSXUSj05kRLAXDJ62yjkkR8x8USffuQpBbT1CA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lBPEYdJuyYImiDKOesgjuRytfNrwPG7eqoAUBRk9ANGOXM7Al49HhfOwWOSgGXeIP
         SEHYcnDleGfpDUgS+34UONGPLphDPE/OMyYKcYIFXK9/3AVEx/xlPu+4RNavHGNgAK
         p/4+JHDug4jmid0ll8buDTfdtg2zEmehd/O37VoqWBJJ2L1dcvaqL4KD5o7kjUFLlD
         Nhk0V9uOxjukYwuX/YDJ9QNYytFWs/NHAvIqeSVUyqMe+KwzOIbip/9pQjnxMZTWKE
         J8b8IUk5YjIgUQPp2cHDQDIhh6fJUT6pZaNHznyMyEHMkaspV/aqTPVE+UA65Rvsi7
         qP0uU47u9V/rQ==
Message-ID: <47aa5e68-a41c-bb22-bce6-ab11a33b3d9c@kernel.org>
Date:   Thu, 18 Aug 2022 08:00:51 +0300
MIME-Version: 1.0
Subject: Re: linux-next: build failure after merge of the icc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220818115326.407aa3e0@canb.auug.org.au>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220818115326.407aa3e0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.22 4:53, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the icc tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/interconnect/imx/imx8mp.c: In function 'imx8mp_icc_remove':
> drivers/interconnect/imx/imx8mp.c:245:16: error: void value not ignored as it ought to be
>    245 |         return imx_icc_unregister(pdev);
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/interconnect/imx/imx8mp.c:246:1: error: control reaches end of non-void function [-Werror=return-type]
>    246 | }
>        | ^
> 
> Caused by commit
> 
>    d761e0e9c8f2 ("interconnect: imx: Make imx_icc_unregister() return void")
> 
> I have used the icc tree from next-20220817 for today.

Thanks Stephen! Fixed.

BR,
Georgi

