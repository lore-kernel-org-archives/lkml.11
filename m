Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C043AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 12:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352771AbiBNMR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:17:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbiBNMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:17:26 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F96749258;
        Mon, 14 Feb 2022 04:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644841038; x=1676377038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z5TBL2tXvs2G8s52nqE7Jh27muVmJgYzHuAp9GiJJtE=;
  b=jRkUCW44dkSsBXeefltIUTHtrRGhxc3c6gyQkni2FzmTZuNK78z4jz4Q
   9KYg8dLg4/B2RqBSp7rF4pFMr5mCopL30Z2i3+X0hgxANb6reaYHu3A5I
   JrdXd+Id7igcvxKq6dvhEtB6nR7p2imtiRuxf8QxmOujQciMlXC7SniYr
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Feb 2022 04:17:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:17:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 04:17:17 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 04:17:14 -0800
Date:   Mon, 14 Feb 2022 17:47:10 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>
Subject: Re: [PATCH] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220214121710.GA31021@hu-pkondeti-hyd.qualcomm.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <Ygo+zxEu0gVh4THE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ygo+zxEu0gVh4THE@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Feb 14, 2022 at 12:36:47PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 04:34:23PM +0530, Pavankumar Kondeti wrote:
> > From: Daehwan Jung <dh10.jung@samsung.com>
> > 
> > xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> > controller reset and controller ready operations can be fatal to the
> > system when controller is timed out. Reduce the timeout to 1 second
> > and print a error message when the time out happens.
> > 
> > Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> >  drivers/usb/host/xhci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index dc357ca..ec4df72 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -196,7 +196,7 @@ int xhci_reset(struct xhci_hcd *xhci)
> >  		udelay(1000);
> >  
> >  	ret = xhci_handshake(&xhci->op_regs->command,
> > -			CMD_RESET, 0, 10 * 1000 * 1000);
> > +			CMD_RESET, 0, 1 * 1000 * 1000);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -210,7 +210,7 @@ int xhci_reset(struct xhci_hcd *xhci)
> >  	 * than status until the "Controller Not Ready" flag is cleared.
> >  	 */
> >  	ret = xhci_handshake(&xhci->op_regs->status,
> > -			STS_CNR, 0, 10 * 1000 * 1000);
> > +			STS_CNR, 0, 1 * 1000 * 1000);
> >  
> >  	xhci->usb2_rhub.bus_state.port_c_suspend = 0;
> >  	xhci->usb2_rhub.bus_state.suspended_ports = 0;
> > -- 
> > 2.7.4
> > 
> 
> I do not see any "print an error message" change here.  Where is that
> addition?
> 

Thanks for taking a look. The "error messages prints" are in my working tree
unstaged :-( sorry for the confusion. I will fix it and resend the patch.

Thanks,
Pavan
