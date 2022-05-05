Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C77C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 22:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386319AbiEEWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386276AbiEEWgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB045AE9;
        Thu,  5 May 2022 15:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DBD461E05;
        Thu,  5 May 2022 22:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A86C385AF;
        Thu,  5 May 2022 22:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651789986;
        bh=nI5TfZ+O5Xvzg7yEHblugPWPUU9wcy1OYsHpnvSqpXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrY7wwzVtmUQFp0Y9furkeCM71/j4gJg+eRrhodsRPPykVtpLWt3lS3pDBv2Z+/gW
         9LSxXLuZ57P7gsEcrpJ4i6ZWxeaPk0I++GdQFQ5rDt3prQT14MTmbnrDaLIyATBb1Q
         JBKV0TqP8yPk7Y23LAYJ6YxLnTeGnAn7Bwuih6JY=
Date:   Thu, 5 May 2022 21:31:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        linux-usb@vger.kernel.org, Jun Li <jun.li@nxp.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/1] usb: cdns3: allocate TX FIFO size according to
 composite EP number
Message-ID: <YnQmLfmHQCJX3seH@kroah.com>
References: <20220427163525.1129887-1-Frank.Li@nxp.com>
 <Yml16DvnUR/tJSCO@kroah.com>
 <CAHrpEqQzBpNej+z6Td-snWtP1OqE8u_DAB6jAs-KAUBHmKcYkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqQzBpNej+z6Td-snWtP1OqE8u_DAB6jAs-KAUBHmKcYkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:03:22PM -0500, Zhi Li wrote:
> On Wed, Apr 27, 2022 at 11:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 11:35:25AM -0500, Frank Li wrote:
> > > Some devices have USB compositions which may require multiple endpoints.
> > > To get better performance, need bigger CDNS3_EP_BUF_SIZE.
> > >
> > > But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
> > > multiple endpoints.
> > >
> > > By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.
> > >
> > > Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
> > > Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
> > > ecnds3_device:ep_iso_burst
> > >
> > > Using a simple algorithm to calculate ep_buf_size.
> > > ep_buf_size = ep_iso_burst = (onchip_buffers - 2k) / (number of IN EP +
> > > 1).
> > >
> > > Test at 8qxp:
> > >
> > >       Gadget                  ep_buf_size
> > >
> > >       RNDIS:                          5
> > >       RNDIS+ACM:                      3
> > >       Mass Storage + NCM + ACM        2
> > >
> > > Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
> > > exceed FIFO memory.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v1 to v2:
> > >  Add safe check for mult, buffering and maxburst
> >
> > that's nice, but this is v8, not v2?
> 
> Sorry, It should be v2. I made a mistake with the title.

Ok, the next version needs to be 9 to keep everything from getting
really confused.

thanks,

greg k-h
