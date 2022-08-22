Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF73C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 06:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiHVGZv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiHVGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:25:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8710FDD
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:25:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7509967373; Mon, 22 Aug 2022 08:25:37 +0200 (CEST)
Date:   Mon, 22 Aug 2022 08:25:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
Message-ID: <20220822062537.GA21455@lst.de>
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com> <20220821055745.GA26064@lst.de> <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 07:12:23AM +0200, Jinpu Wang wrote:
> On Sun, Aug 21, 2022 at 7:57 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Please don't send me just two random patches out of a series, as I
> > have no way to review them.  If the patches are independent, send them
> > independently and if they depend on common prep work send the entire
> > series to everyone.
> Hi Christoph,
> 
> As mentioned in the cover letter, the bugfixes are all independent,
> for each of the drivers.

I still haven't seen the cover letter as it was never sent to me.
But if patches are independent please send a series per subsystem
as that makes that very clear.
