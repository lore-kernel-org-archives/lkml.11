Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEF3C04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 01:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiG1BKk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 21:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG1BKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:10:35 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFC11168;
        Wed, 27 Jul 2022 18:10:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VKd5t0Z_1658970629;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VKd5t0Z_1658970629)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 09:10:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     borisp@nvidia.com
Cc:     john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] tls: rx: Fix unsigned comparison with less than zero
Date:   Thu, 28 Jul 2022 09:10:25 +0800
Message-Id: <20220728011025.10865-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to tls_rx_msg_size() is int, it can be
a negative error code, however this is being assigned to an
unsigned long variable 'sz', so making 'sz' an int.

Eliminate the following coccicheck warning:
./net/tls/tls_strp.c:211:6-8: WARNING: Unsigned expression compared with zero: sz < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 net/tls/tls_strp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index b945288c312e..193e328294be 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -187,7 +187,8 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 			   unsigned int offset, size_t in_len)
 {
 	struct tls_strparser *strp = (struct tls_strparser *)desc->arg.data;
-	size_t sz, len, chunk;
+	int sz;
+	size_t len, chunk;
 	struct sk_buff *skb;
 	skb_frag_t *frag;
 
-- 
2.20.1.7.g153144c

