Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FFCCA47B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 09:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiGKJfd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 05:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiGKJeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:34:14 -0400
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8967B366;
        Mon, 11 Jul 2022 02:18:17 -0700 (PDT)
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
        by mx07-0057a101.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B7hBTb008991;
        Mon, 11 Jul 2022 11:17:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=12052020;
 bh=7Ds/3Nw74YKoBFgdlvZDEEeXInxctCEea0014hDr0xY=;
 b=U6Kay+LZRTCmoLFlyB1yvFLzlVTGFYhzNuAojEkvvruGQrQ+KxfnWh8mUkFvrle8Nz1R
 mNTx2YWoPzkBio/SdStExXwrnPZpULx4A+vXtKz2gXTF73dsPe0Bd9nxtQTGS5PWTQ4a
 8mebtmthUI7wtNxo7PhFUVqsKW6nQ2HzdS7SfSB+Os35LvxstQJQIGoVJiDOmsM7LCvd
 hkkIoq5PvpptD9a+iT0w9tXz5gIY0pdNjQe3H4GGOFFD/AWemwiN5EQA2hNFKxLDBSZh
 p+3TU3Jpe4N5+1glFlZv90hf/zkN3cy9gFnGEUzbWmlermxPqd/Y4P1opHD0XvYleTv6 2g== 
Received: from mail.beijerelectronics.com ([195.67.87.131])
        by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 3h6wp61x82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 11:17:44 +0200
Received: from Orpheus.nch.westermo.com (172.29.100.2) by
 EX01GLOBAL.beijerelectronics.com (10.101.10.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Mon, 11 Jul 2022 11:17:42 +0200
From:   Matthias May <matthias.may@westermo.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <yoshfuji@linux-ipv6.org>,
        <dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Matthias May <matthias.may@westermo.com>
Subject: [PATCH 3/4 net-next] ip6_gre: use actual protocol to select xmit
Date:   Mon, 11 Jul 2022 11:17:21 +0200
Message-ID: <20220711091722.14485-4-matthias.may@westermo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711091722.14485-1-matthias.may@westermo.com>
References: <20220711091722.14485-1-matthias.may@westermo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.29.100.2]
X-ClientProxiedBy: wsevst-s0023.westermo.com (192.168.130.120) To
 EX01GLOBAL.beijerelectronics.com (10.101.10.25)
X-Proofpoint-ORIG-GUID: 1JTHKFW03YbrKZpkkecMxeYMU_T80i8q
X-Proofpoint-GUID: 1JTHKFW03YbrKZpkkecMxeYMU_T80i8q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the payload is a VLAN encapsulated IPv6/IPv6 frame, we can
skip the 802.1q/802.1ad ethertypes and jump to the actual protocol.
This way we treat IPv4/IPv6 frames as IP instead of as "other".

Signed-off-by: Matthias May <matthias.may@westermo.com>
---
 net/ipv6/ip6_gre.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 5fe0db88bea8..cd0202016da0 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -916,6 +916,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct net_device_stats *stats = &t->dev->stats;
+	__be16 payload_protocol;
 	int ret;
 
 	if (!pskb_inet_may_pull(skb))
@@ -924,7 +925,8 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
 		goto tx_err;
 
-	switch (skb->protocol) {
+	payload_protocol = skb_protocol(skb, true);
+	switch (payload_protocol) {
 	case htons(ETH_P_IP):
 		ret = ip6gre_xmit_ipv4(skb, dev);
 		break;
-- 
2.35.1

