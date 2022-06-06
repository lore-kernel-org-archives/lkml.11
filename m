Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 16:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiFFQiO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiFFQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4847713D25
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B188060C93
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F07CC385A9;
        Mon,  6 Jun 2022 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654533490;
        bh=m3OKX/0tOW57YAFAXNwERMVq2/lnf8KwKOn8zar2Lso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpVN7csIWXjt7AI3jZa9ap09T2BX5+GW1R8WvxJ+/sTWSY7qAFWlQDB02FqogZqLE
         rH7zpQ0H9V6UHsyLhf0nAk6fBkcqmwDPpre2zP7Edy2Heb/jLXc0E7TT3v0Od/dijR
         h8ydbzzaKRZ2Ag56D9ddTCDEaw+/TGySb1RA03IpX7QVlajkor5DYIJwvRqjJ4CZHE
         rmp4xeAZzPjtJNPjTSjt9B89qaywMyO0kBQKBeDMpS9C52iBYCa6tWGJ8qqToFbDOE
         G6C3txMShThaNGvigGRetLZDuBpDvExbxIS7CSlmSDpM9PBOVvig0SW2QBlOGdtruH
         yuXXMbyDvsfCA==
Date:   Mon, 6 Jun 2022 10:38:06 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
        Richard Wurdack <riwurd@microsoft.com>,
        Nathan Obr <Nathan.Obr@microsoft.com>
Subject: Re: [PATCH v2 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Message-ID: <Yp4tbtPZzDe038Kz@kbusch-mbp.dhcp.thefacebook.com>
References: <1654278961-81423-1-git-send-email-mikelley@microsoft.com>
 <1654278961-81423-2-git-send-email-mikelley@microsoft.com>
 <Yppfm5n41NEcrRlU@kbusch-mbp.dhcp.thefacebook.com>
 <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 02:28:11PM +0000, Michael Kelley (LINUX) wrote:
> From: Keith Busch <kbusch@kernel.org> Sent: Friday, June 3, 2022 12:23 PM
> > 
> > On Fri, Jun 03, 2022 at 10:56:01AM -0700, Michael Kelley wrote:
> > 
> > This series looks good to me. Just one concern below that may amount to
> > nothing.
> > 
> > > +static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
> > > +{
> > > +	u32 csts;
> > > +
> > > +	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
> > > +
> > > +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) != 0 ||
> > 
> > The reg_read32() is non-blocking for pcie, so this is safe to call from that
> > driver's irq handler. The other transports block on register reads, though, so
> > they can't call this from an atomic context. The TCP context looks safe, but
> > I'm not sure about RDMA or FC.
> 
> Good point.  But even if the RDMA and FC contexts are safe, if a
> persistent error is reported, the controller is already in trouble and
> may not respond to a request to retrieve the CSTS anyway.  Perhaps
> we should just trust the AER error report and not bother checking
> CSTS to decide whether to do the reset.  We can still check ctrl->state
> and skip the reset if there's already one in progress.

That sounds good to me. Christoph noted RDMA isn't safe to do this in the
callback anyway, and it's probably a bad idea in general to dispatch new
requests within another's completion: that may prevent reclaiming the only
available tag, and then deadlock.

So with that in mind, this AER persistent error handler could call
nvme_should_reset() with NVME_CSTS_CFS as a constant value for the csts
parameter.
