Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0BBC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 11:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348027AbiFOLbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347949AbiFOLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:31:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FEF53A52
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:31:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43DD768AA6; Wed, 15 Jun 2022 13:31:06 +0200 (CEST)
Date:   Wed, 15 Jun 2022 13:31:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <pankydev8@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "R, Monish Kumar" <monish.kumar.r@intel.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was:
 Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests]
Message-ID: <20220615113106.GA10697@lst.de>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com> <Ykyf5Zuz1W8yHhNY@zx2c4.com> <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com> <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com> <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com> <YqG/pybFg0P5yQ9a@zx2c4.com> <20220610061449.GD24331@lst.de> <YqMMo2Dv9SZRtR7B@zx2c4.com> <20220613135549.GA1714@lst.de> <20220615102757.ugvs6vdxf66nrmyn@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615102757.ugvs6vdxf66nrmyn@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:27:57PM +0200, Pankaj Raghav wrote:
> Hi Christoph,
> On Mon, Jun 13, 2022 at 03:55:49PM +0200, Christoph Hellwig wrote:
> > It all appears as PCIe, but the pci_dev has an is_thunderbolt flag.
> > 
> > Thanks to both of you for the information.  I'd like to wait until the
> > end of the week or so if we can hear something from Samsung, and if we
> > don't we'll have to quirk based on the model number.
> Our FW team has started looking into the issue. They said they will try
> to come up with a solution before 5.20. If not, we can add this quirk
> based on the FW ver. and a proper solution can be added by 5.21.

I don't think we can wait for 5.20 - the "offending" commit is in
5.19-rc and -stable.  So I'll plan to prepare a patch based on the model
number for now, still hoping we can come up with something better
eventually.
