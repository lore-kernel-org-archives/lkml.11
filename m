Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 02:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiBVCY6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:24:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiBVCY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:24:56 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D848A25C50;
        Mon, 21 Feb 2022 18:24:27 -0800 (PST)
X-UUID: 7b9dd0781ea840b78c04494a01077d01-20220222
X-UUID: 7b9dd0781ea840b78c04494a01077d01-20220222
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <lina.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1074011643; Tue, 22 Feb 2022 10:24:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Feb 2022 10:24:21 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Feb 2022 10:24:20 +0800
From:   Lina Wang <lina.wang@mediatek.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lina Wang <lina.wang@mediatek.com>
Subject: Re: [PATCH] xfrm: fix tunnel model fragmentation behavior
Date:   Tue, 22 Feb 2022 10:18:04 +0800
Message-ID: <20220222021803.27965-1-lina.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220221110405.GJ1223722@gauss3.secunet.de>
References: <20220221110405.GJ1223722@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-21 at 12:04 +0100, Steffen Klassert wrote:
> On Mon, Feb 21, 2022 at 01:16:48PM +0800, Lina Wang wrote:
> > in tunnel mode, if outer interface(ipv4) is less, it is easily to
We have two commits in the ipsec tree that address a very similar
> issue. That is:
> 
> commit 6596a0229541270fb8d38d989f91b78838e5e9da
> xfrm: fix MTU regression
> 
> and
> 
> commit a6d95c5a628a09be129f25d5663a7e9db8261f51
> Revert "xfrm: xfrm_state_mtu should return at least 1280 for ipv6"
> 
> Can you please doublecheck that the issue you are fixing still
> exist in the ipsec tree?

Yes, I know the two patches, which didnot help for my scenary. Whatever 
commit a6d95c5a62 exist or not, there still is double fragment issue. From
commit 6596a022's mail thread, owner has met double fragment issue, I am 
not sure if it is the same with mine.

My scenary is very simple, set up ipsec0, create default route, set 
transport mode for ipsec0 and tunnel mode for wlan0.

ip link add ipsec0 type xfrm dev xfrm dev wlan0 if_id xx
ip link set mtu 1400 dev ipsec0
ip link set mtu 1300 dev wlan0

ping6 -s 1300 xx will always reproduce such issue.

Thanks!
