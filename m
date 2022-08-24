Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D21C32793
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 06:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiHXGlK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 02:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:41:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35585AA1;
        Tue, 23 Aug 2022 23:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6E75B82365;
        Wed, 24 Aug 2022 06:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB5DC433D6;
        Wed, 24 Aug 2022 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661323265;
        bh=TZHRSvBb0cU6FThX0k9yETXE2AsLxPMc9AozorXN7es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hsKxfb+2jcafaAWI9F5kkpnuaGWUPy+vgoyThKBnJWLWudU7gnwO1+Y/b4/M/Ohf
         OeD88VHdpSZcF4hkGyHBB6eoKtpql27ardciO23uNlfiFb6Vyksbj7Gt7xG7CTGvK4
         llPQ3417MLXQF+FgUqNDxcI3OnAS90IH1EXa/JfI=
Date:   Wed, 24 Aug 2022 08:41:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     bjorn@helgaas.com
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Stefan Roese <sr@denx.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 182/389] PCI/portdrv: Dont disable AER reporting in
 get_port_device_capability()
Message-ID: <YwXH/l37HaYQD66B@kroah.com>
References: <20220823080115.331990024@linuxfoundation.org>
 <20220823080123.228828362@linuxfoundation.org>
 <CABhMZUVycsyy76j2Z=K+C6S1fwtzKE1Lx2povXKfB80o9g0MtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUVycsyy76j2Z=K+C6S1fwtzKE1Lx2povXKfB80o9g0MtQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 07:20:14AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 23, 2022, 6:35 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> wrote:
> 
> > From: Stefan Roese <sr@denx.de>
> >
> > [ Upstream commit 8795e182b02dc87e343c79e73af6b8b7f9c5e635 ]
> >
> 
> There's an open regression related to this commit:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216373

This is already in the following released stable kernels:
	5.10.137 5.15.61 5.18.18 5.19.2

I'll go drop it from the 4.19 and 5.4 queues, but when this gets
resolved in Linus's tree, make sure there's a cc: stable on the fix so
that we know to backport it to the above branches as well.  Or at the
least, a "Fixes:" tag.

thanks,

greg k-h
