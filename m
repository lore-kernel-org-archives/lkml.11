Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3131C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbiCGKGu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 05:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiCGJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:47:04 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAAB6A068;
        Mon,  7 Mar 2022 01:42:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V6UNDIr_1646646123;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V6UNDIr_1646646123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 17:42:03 +0800
Message-ID: <1646646065.5940611-2-xuanzhuo@linux.alibaba.com>
Subject: Re: linux-next: build warning after merge of the vhost tree
Date:   Mon, 7 Mar 2022 17:41:05 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220307154011.6d456f28@canb.auug.org.au>
 <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
 <20220307040734-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220307040734-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 04:17:39 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 07, 2022 at 02:46:40PM +0800, Xuan Zhuo wrote:
> > On Mon, 7 Mar 2022 15:40:11 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Hi all,
> > >
> > > After merging the vhost tree, today's linux-next build (arm
> > > multi_v7_defconfig) produced this warning:
> > >
> > > drivers/net/virtio_net.c: In function 'virtnet_rx_vq_reset':
> > > drivers/net/virtio_net.c:1823:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
> > >  1823 |                    "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> > >       |                                                             ~~^
> > >       |                                                               |
> > >       |                                                               long int
> > >       |                                                             %d
> > >  1824 |                    rq - vi->rq, err);
> > >       |                    ~~~~~~~~~~~
> > >       |                       |
> > >       |                       int
> > > drivers/net/virtio_net.c: In function 'virtnet_tx_vq_reset':
> > > drivers/net/virtio_net.c:1873:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
> > >  1873 |                    "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> > >       |                                                             ~~^
> > >       |                                                               |
> > >       |                                                               long int
> > >       |                                                             %d
> > >  1874 |                    sq - vi->sq, err);
> > >       |                    ~~~~~~~~~~~
> > >       |                       |
> > >       |                       int
> > >
> > > Introduced by commit
> > >
> > >   920ee0c540a2 ("virtio_net: support rx/tx queue reset")
> > >
> >
> >
> > Can you help me test this patch? I don't have an arm environment around me.
> >
> > Thanks
>
>
> You should at least use
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> to test-build + test on x86.


I reproduced the problem using this method, and verified that this patch fixes
it. I submitted a patch email.

Thanks.

>
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1fa2d632a994..4d629d1ea894 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info *vi,
> >
> >  err:
> >         netdev_err(vi->dev,
> > -                  "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> > +                  "reset rx reset vq fail: rx queue index: %td err: %d\n",
> >                    rq - vi->rq, err);
> >         virtnet_napi_enable(rq->vq, &rq->napi);
> >         return err;
> > @@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info *vi,
> >
> >  err:
> >         netdev_err(vi->dev,
> > -                  "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> > +                  "reset tx reset vq fail: tx queue index: %td err: %d\n",
> >                    sq - vi->sq, err);
> >         virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> >         return err;
> >
> > > --
> > > Cheers,
> > > Stephen Rothwell
> > >
>
