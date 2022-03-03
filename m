Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17307C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 09:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiCCJpT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiCCJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:45:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4536178691;
        Thu,  3 Mar 2022 01:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 340B3B8245E;
        Thu,  3 Mar 2022 09:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F6CC004E1;
        Thu,  3 Mar 2022 09:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646300670;
        bh=NGcBF3AVHIhtKVC0zRW8pIu7aUMAWVmM1POSw5/aVco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgLJ23R7AA87FbdYkYtNwxhuDpACqmwMoD5KMW5h3b1YXt2c6kfKQNvbqEoj4+EXr
         3lYW6k7V3sYLgUbTal6V5xFUwItOecWgffBl0X8UgEQybQ48xM++i2N+00OVJmhUZS
         BHGctcGoDft9lBtCYOI7gruP0FrGmqUImpYygs/CUwJ+zqKMkUZRJ0YSRsidGaI85X
         qXBzOYK7oXceAAbh06hrSQseuh8gFphhPul870zUxDh7AaAIjJ2q7PwQvXPDQGOw3X
         VXJ81H2oVP7Wuyu53L7reTLJHg1ra6nN9Rtv1A023e7ufy9ZycwSqKh8YHQy/ssMUb
         sYDyVWIFaUixA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPi0Z-0002Zu-Mx; Thu, 03 Mar 2022 10:44:28 +0100
Date:   Thu, 3 Mar 2022 10:44:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Message-ID: <YiCN+x2XPiawaweY@hovoldconsulting.com>
References: <20220301224446.21236-1-eajames@linux.ibm.com>
 <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
 <YiCHPuNkMuO4uARu@hovoldconsulting.com>
 <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:24:51AM +0000, Joel Stanley wrote:
> On Thu, 3 Mar 2022 at 09:15, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Mar 03, 2022 at 08:52:29AM +0000, Joel Stanley wrote:
> > > On Thu, 3 Mar 2022 at 08:25, Johan Hovold <johan@kernel.org> wrote:
> > > >
> > > > On Tue, Mar 01, 2022 at 04:44:46PM -0600, Eddie James wrote:
> > > > > IBM manufactures a PL2303 device for UPS communications. Add the vendor
> > > > > and product IDs so that the PL2303 driver binds to the device.
> > > > >
> > > > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > > > ---
> > > > > Changes since v1:
> > > > >  - Fix commit message Signed-off-by ordering.
> > > >
> > > > Almost there. You're still missing a Co-developed-by tag, a From line,
> > > > or both.
> > >
> > > It's neither. This patch was applied to a tree by myself, and I asked
> > > Eddie to send it to mainline for merging.
> >
> > Then you are missing a From line. As the patch looks like know, Eddie is
> > considered the author and not you.
> 
> You are incorrect. Eddie is the author.

Then what is your SoB doing there in the first place? If Eddie is the
sole author as well as the submitter, and you didn't touch the patch in
between, then your SoB does not belong in the chain. 

If you applied Eddie's patch to your shared tree and Eddie generated a
patch from there, then the chain should be:

	SoB: E
	SoB: J
	SoB: E

but this is starting to look a bit ridiculous.

Johan
