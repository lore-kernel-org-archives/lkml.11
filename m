Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB34C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 06:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiBYGQm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiBYGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:16:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE61C6EF3;
        Thu, 24 Feb 2022 22:16:06 -0800 (PST)
X-UUID: 0d2856bb4180414badd3a37ee335b04f-20220225
X-UUID: 0d2856bb4180414badd3a37ee335b04f-20220225
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <lena.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 809528167; Fri, 25 Feb 2022 14:15:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 25 Feb 2022 14:15:19 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Feb 2022 14:15:19 +0800
From:   Lena Wang <lena.wang@mediatek.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lena.wang@mediatek.com>,
        <hao.lin@mediatek.com>
Subject: [PATCH] net:fix up skbs delta_truesize in UDP GRO frag_list
Date:   Fri, 25 Feb 2022 14:09:13 +0800
Message-ID: <1645769353-7171-2-git-send-email-lena.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645769353-7171-1-git-send-email-lena.wang@mediatek.com>
References: <1645769353-7171-1-git-send-email-lena.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lena wang <lena.wang@mediatek.com>

The truesize for a UDP GRO packet is added by main skb and skbs in main
skb's frag_list:
skb_gro_receive_list
        p->truesize += skb->truesize;

When uncloning skb, it will call pskb_expand_head and trusesize for
frag_list skbs may increase. This can occur when allocators uses
__netdev_alloc_skb and not jump into __alloc_skb. This flow does not
use ksize(len) to calculate truesize while pskb_expand_head uses.
skb_segment_list
err = skb_unclone(nskb, GFP_ATOMIC);
pskb_expand_head
        if (!skb->sk || skb->destructor == sock_edemux)
                skb->truesize += size - osize;

If we uses increased truesize adding as delta_truesize, it will be
larger than before and even larger than previous total truesize value
if skbs in frag_list are abundant. The main skb truesize will become
smaller and even a minus value or a huge value for an unsigned int
parameter. Then the following memory check will drop this abnormal skb.

To avoid this error we should use the original truesize to segment the
main skb.

Signed-off-by: lena wang <lena.wang@mediatek.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9d0388be..8b7356c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3876,6 +3876,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		list_skb = list_skb->next;
 
 		err = 0;
+		delta_truesize += nskb->truesize;
 		if (skb_shared(nskb)) {
 			tmp = skb_clone(nskb, GFP_ATOMIC);
 			if (tmp) {
@@ -3900,7 +3901,6 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		tail = nskb;
 
 		delta_len += nskb->len;
-		delta_truesize += nskb->truesize;
 
 		skb_push(nskb, -skb_network_offset(nskb) + offset);
 
-- 
1.9.1

