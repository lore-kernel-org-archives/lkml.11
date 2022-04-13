Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B14C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 07:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiDMHsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiDMHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374642ED8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB7A61328
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3679C385A4;
        Wed, 13 Apr 2022 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649835965;
        bh=cuHoYy+Y/Fb3+nw6/VecCrtTq1QAy9QdjGKgoL/poqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmlzhwBbGtoURc3KLo63sFtjYdieuPef+ooftDxxxC60JuW09JhI6E5G172AcCZoO
         HWD3aEqewYBFDouSEwYUkPmd8ohjM3D2nCyRCr/WwqYd1hj/mKVicbvPUFeEFQSWrd
         F455iUSsCpQvOGd1CRtAzAtXRNuL5YKvRgQA5tjA=
Date:   Wed, 13 Apr 2022 09:45:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uio: make MAX_UIO_MAPS & MAX_UIO_PORT_REGIONS
 configurable
Message-ID: <YlZ/tK/51GiQI8uP@kroah.com>
References: <20220413071137.4023184-1-rfried.dev@gmail.com>
 <YlZ7fQIpXNJSbd+P@kroah.com>
 <CAGi-RULbkLS0wRQni8mQ0Dp_dAGuRSj96TmqD7oD+Tj=zSo3Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGi-RULbkLS0wRQni8mQ0Dp_dAGuRSj96TmqD7oD+Tj=zSo3Gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:40:09AM +0300, Ramon Fried wrote:
> On Wed, Apr 13, 2022 at 10:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 13, 2022 at 10:11:37AM +0300, Ramon Fried wrote:
> > > MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS are hard-coded to 5.
> > > This is not always sufficiant for some drivers.
> >
> > Why not?  What in-kernel drivers need more than this?
> Obviously kernel drivers don't need more, but I'm developing a driver
> that needs more.

Great, let's consider this change at the same time you submit your
driver, otherwise it doesn't make much sense now, right?

thanks,

greg k-h
