Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B021C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 16:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiCRQPj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiCRQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:15:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9DC1CFE4;
        Fri, 18 Mar 2022 09:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D529B824A7;
        Fri, 18 Mar 2022 16:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654FEC340E8;
        Fri, 18 Mar 2022 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647620052;
        bh=OEa4kSOpcUxd2Ktxa4MIliyQMClUaaW4AHu+nc9CldM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNwlr54+e9nPxlb8JGqOpn27YX5yaaQJb952ZKO4ws9qo2y89/9VUgZRX/8i6E30q
         qmg7gT/HH5YeL2YMHQ8FCJCaIhXf+oPuYZ2ipaMrkr5b2qShljr99D+1xwGN6dM6Aw
         qQstyhNWeOPbXQ8p/wBbnGml7OnJI/DCOlJXfsOI=
Date:   Fri, 18 Mar 2022 17:14:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.10 00/23] 5.10.107-rc1 review
Message-ID: <YjSvz2UXhmgqUEic@kroah.com>
References: <20220317124525.955110315@linuxfoundation.org>
 <20220317211922.GB5328@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317211922.GB5328@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 10:19:22PM +0100, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 5.10.107 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> 
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >     bnx2: Fix an error message
> 
> As commented during the AUTOSEL phase, this patch actually _adds_ an
> error in at least 5.10 and older. Please drop.

Now dropped, thanks.

greg k-h
