Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 08:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383778AbiEBIuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbiEBIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:50:03 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4565229808;
        Mon,  2 May 2022 01:46:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2428kHAC024176;
        Mon, 2 May 2022 10:46:17 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Moshe Kol <moshe.kol@mail.huji.ac.il>,
        Yossi Gilad <yossi.gilad@mail.huji.ac.il>,
        Amit Klein <aksecurity@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 net 3/7] tcp: resalt the secret every 10 seconds
Date:   Mon,  2 May 2022 10:46:10 +0200
Message-Id: <20220502084614.24123-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220502084614.24123-1-w@1wt.eu>
References: <20220502084614.24123-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

In order to limit the ability for an observer to recognize the source
ports sequence used to contact a set of destinations, we should
periodically shuffle the secret. 10 seconds looks effective enough
without causing particular issues.

Cc: Moshe Kol <moshe.kol@mail.huji.ac.il>
Cc: Yossi Gilad <yossi.gilad@mail.huji.ac.il>
Cc: Amit Klein <aksecurity@gmail.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/secure_seq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index 55aa5cc258e3..5f85e01d4093 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -22,6 +22,8 @@
 static siphash_aligned_key_t net_secret;
 static siphash_aligned_key_t ts_secret;
 
+#define EPHEMERAL_PORT_SHUFFLE_PERIOD (10 * HZ)
+
 static __always_inline void net_secret_init(void)
 {
 	net_get_random_once(&net_secret, sizeof(net_secret));
@@ -100,11 +102,13 @@ u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
 	const struct {
 		struct in6_addr saddr;
 		struct in6_addr daddr;
+		unsigned int timeseed;
 		__be16 dport;
 	} __aligned(SIPHASH_ALIGNMENT) combined = {
 		.saddr = *(struct in6_addr *)saddr,
 		.daddr = *(struct in6_addr *)daddr,
-		.dport = dport
+		.timeseed = jiffies / EPHEMERAL_PORT_SHUFFLE_PERIOD,
+		.dport = dport,
 	};
 	net_secret_init();
 	return siphash(&combined, offsetofend(typeof(combined), dport),
@@ -145,8 +149,10 @@ EXPORT_SYMBOL_GPL(secure_tcp_seq);
 u64 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport)
 {
 	net_secret_init();
-	return siphash_3u32((__force u32)saddr, (__force u32)daddr,
-			    (__force u16)dport, &net_secret);
+	return siphash_4u32((__force u32)saddr, (__force u32)daddr,
+			    (__force u16)dport,
+			    jiffies / EPHEMERAL_PORT_SHUFFLE_PERIOD,
+			    &net_secret);
 }
 EXPORT_SYMBOL_GPL(secure_ipv4_port_ephemeral);
 #endif
-- 
2.17.5

