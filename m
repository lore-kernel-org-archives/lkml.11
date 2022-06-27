Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03736C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiF0OyU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiF0OyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:54:17 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C053915839
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:54:15 -0700 (PDT)
Received: (qmail 121138 invoked by uid 1000); 27 Jun 2022 10:54:14 -0400
Date:   Mon, 27 Jun 2022 10:54:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Message-ID: <YrnEli0fdOERpIXe@rowland.harvard.edu>
References: <20220624021916.318067-1-neal_liu@aspeedtech.com>
 <YrXJss4cTtfenu90@rowland.harvard.edu>
 <HK0PR06MB320272ACB1CA4ADFF8DDABC080B99@HK0PR06MB3202.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB320272ACB1CA4ADFF8DDABC080B99@HK0PR06MB3202.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:56:40AM +0000, Neal Liu wrote:
> > On Fri, Jun 24, 2022 at 10:19:16AM +0800, Neal Liu wrote:
> > > Add read TOC with format 1 to support CD-ROM emulation with Windows
> > > OS.
> > > This patch is tested on Windows OS Server 2019.
> > >
> > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > ---
> > >  drivers/usb/gadget/function/f_mass_storage.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > > b/drivers/usb/gadget/function/f_mass_storage.c
> > > index 3a77bca0ebe1..9edf76c22605 100644
> > > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > > @@ -1209,7 +1209,8 @@ static int do_read_toc(struct fsg_common
> > > *common, struct fsg_buffhd *bh)
> > >
> > >  	switch (format) {
> > >  	case 0:
> > > -		/* Formatted TOC */
> > > +	case 1:
> > > +		/* Formatted TOC, Session info */
> > 
> > This comment is a little misleading.  0 is formatted TOC, and 1 is
> > multi-session info.  The way you wrote it, it looks like the comment applies to
> > both formats.  Do it like this:
> > 
> > 	case 0:		/* Formatted TOC */
> > 	case 1:		/* Multi-session info */
> > 
> 
> Okay, looks more clear. I'll fix it in next patch.
> 
> > >  		len = 4 + 2*8;		/* 4 byte header + 2 descriptors */
> > >  		memset(buf, 0, len);
> > >  		buf[1] = len - 2;	/* TOC Length excludes length field */
> > 
> > It looks like you ignored one of the problems I pointed out in my earlier email:
> > 
> > > When format is 1, the driver is supposed to ignore the start_track
> > > value.  Your patch does not do this.
> > 
> > Please fix this.
> > 
> 
> Do you mean ignore the "start_track > 1" above?

Yes, that's what I mean.

> Do this check only for format 0? Or format 0 & 2?

According to the MMC spec, the Track/Session Number is ignored for 
format 1.  For format 0 it is valid as a Track Number, and for format 2 
it is valid as a Session Number.  Therefore it should be checked for 
formats 0 and 2 but not for format 1.

Alan Stern
