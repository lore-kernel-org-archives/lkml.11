Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC25C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 17:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbiGNRnl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiGNRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:43:37 -0400
Received: from syslogsrv (unknown [217.20.186.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBC93B3;
        Thu, 14 Jul 2022 10:43:34 -0700 (PDT)
Received: from fg200.ow.s ([172.20.254.44] helo=plvision.eu)
        by syslogsrv with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <maksym.glubokiy@plvision.eu>)
        id 1oC2rw-000EeH-Pl; Thu, 14 Jul 2022 20:43:21 +0300
Date:   Thu, 14 Jul 2022 20:43:15 +0300
From:   Maksym Glubokiy <maksym.glubokiy@plvision.eu>
To:     Joe Perches <joe@perches.com>
Cc:     Taras Chornyi <tchornyi@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: prestera: acl: fix code formatting
Message-ID: <20220714174315.GA2381860@plvision.eu>
References: <20220714161704.2370010-1-maksym.glubokiy@plvision.eu>
 <3bd7e3d14c63a50d869ab10fcba4fd93d17745c0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd7e3d14c63a50d869ab10fcba4fd93d17745c0.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:27:52AM -0700, Joe Perches wrote:
> On Thu, 2022-07-14 at 19:17 +0300, Maksym Glubokiy wrote:
> > Make the code look better.
> > 
> > Signed-off-by: Maksym Glubokiy <maksym.glubokiy@plvision.eu>
> > ---
> >  .../net/ethernet/marvell/prestera/prestera_flower.c    | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
> []
> > @@ -1,5 +1,5 @@
> >  // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> > -/* Copyright (c) 2020 Marvell International Ltd. All rights reserved */
> > +/* Copyright (c) 2020-2022 Marvell International Ltd. All rights reserved */
> 
> What gives you the right to extend Marvell's copyright?
> 
> In general, don't change copyright for whitespace changes
> and unless you are the copyright owner.
> 
Ack. I'll remove the change to the copyright in v2.
