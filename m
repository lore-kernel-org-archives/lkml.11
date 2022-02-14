Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E8CC4167E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 11:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353248AbiBNLm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353779AbiBNLmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:42:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279FA66CB3;
        Mon, 14 Feb 2022 03:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1CF4B80E63;
        Mon, 14 Feb 2022 11:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACC4C340EF;
        Mon, 14 Feb 2022 11:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644838390;
        bh=mB4W/H/vrB0d77K6nBnjaR9o/mXDf3g7YMz3F6i2XPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9eOPxoPwj3QMg77pz+4V2ZXKrBN0sxp4V6IAZ7lW13IoezGtFUAgvvOXD+9lnTma
         FkRvZrj6JM1DJxfvX3OP9mVNfVwJ5iasyMQRi33pnY7/KFrfyOHH6GDblmX+gkpFJH
         MgdN3dGv0EUn/wSaNy7fi2uuEjGz4Fhb/NaCO+Wk=
Date:   Mon, 14 Feb 2022 12:33:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5pa96YyV6bS7?= <vincent.sunplus@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v1 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
Message-ID: <Ygo980Tg3aZdDQDH@kroah.com>
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
 <1644827562-17244-2-git-send-email-vincent.sunplus@gmail.com>
 <YgoVBv/z1uCsR1Y0@kroah.com>
 <CAPvp3Rhtb-g1A5FG6_1irzX2fG-VACU3T4tST1Xo99cnnL==MQ@mail.gmail.com>
 <Ygodd+TFQGnhki6A@kroah.com>
 <CAPvp3RiPVkonTtAdTcLqQuPggg6zw8yNEPf-mR0+1bbtSsdtEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPvp3RiPVkonTtAdTcLqQuPggg6zw8yNEPf-mR0+1bbtSsdtEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 05:48:20PM +0800, 施錕鴻 wrote:
> Greg KH <gregkh@linuxfoundation.org> 於 2022年2月14日 週一 下午5:14寫道：
> >
> > On Mon, Feb 14, 2022 at 05:03:00PM +0800, 施錕鴻 wrote:
> > > Hi, Greg
> > >     About this issue, my colleague Hammer Hsieh has explained it to
> > > you recently in the mail of "[PATCH v7 2/2] serial: sunplus-uart: Add
> > > Sunplus
> > > SoC UART Driver". The ehci driver and uart one are in the same Sunplus Soc.
> >
> > I do not know what you are referring to, sorry.  Remember we get
> > thousands of emails a week.
> >
> > Please be explicit and make the code work properly for each patch you
> > submit.
> >
> > thanks,
> >
> > greg k-h
> 
> Hi, Greg
>     About data incoherence issue between memory bus and peripheral bus.
> In case of AXI bus, use non-posted write can avoid data incoherence issue.
>     What if in case of post write:
> Send a specific command after last write command. SDCTRL identify specific
> command, means previous write command done. Then send the interrupt
> signal to interrupt controller. And then interrupt controller sends done signal
> to Master. Master receives done signal, means write command done. Then
> issue a interrupt or proceed next write command.

I do not understand what you are referring to here as I have no context
:(

