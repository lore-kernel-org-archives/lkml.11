Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbiBUJFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:05:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347563AbiBUJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:01:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D6822512;
        Mon, 21 Feb 2022 00:56:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D5A1B80EB5;
        Mon, 21 Feb 2022 08:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54751C340E9;
        Mon, 21 Feb 2022 08:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433771;
        bh=3hY4r8/3UO+KDlgWBI1PWNsgwmTFyNxZwI7NNxVqog0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQ5L4cuMBd4DkEuor9d66Ysz7ijxThmhtGIS1FQG7E0wzRObtZEZbmpN0OhCB7iSs
         M3Az+DvTVZX/jBn+9NbRZrhQP70dNPbrldwlneuu020YSOY/xAIzj54VP/rQTqOwos
         ANGAKG4YxibrgUB1YPPmKPSvG1H3SsGr0dl39y44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.19 19/58] xfrm: Dont accidentally set RTO_ONLINK in decode_session4()
Date:   Mon, 21 Feb 2022 09:49:12 +0100
Message-Id: <20220221084912.507636200@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084911.895146879@linuxfoundation.org>
References: <20220221084911.895146879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <gnault@redhat.com>

commit 23e7b1bfed61e301853b5e35472820d919498278 upstream.

Similar to commit 94e2238969e8 ("xfrm4: strip ECN bits from tos field"),
clear the ECN bits from iph->tos when setting ->flowi4_tos.
This ensures that the last bit of ->flowi4_tos is cleared, so
ip_route_output_key_hash() isn't going to restrict the scope of the
route lookup.

Use ~INET_ECN_MASK instead of IPTOS_RT_MASK, because we have no reason
to clear the high order bits.

Found by code inspection, compile tested only.

Fixes: 4da3089f2b58 ("[IPSEC]: Use TOS when doing tunnel lookups")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[sudip: manually backport to previous location]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/xfrm4_policy.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -17,6 +17,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/l3mdev.h>
+#include <net/inet_ecn.h>
 
 static struct dst_entry *__xfrm4_dst_lookup(struct net *net, struct flowi4 *fl4,
 					    int tos, int oif,
@@ -126,7 +127,7 @@ _decode_session4(struct sk_buff *skb, st
 	fl4->flowi4_proto = iph->protocol;
 	fl4->daddr = reverse ? iph->saddr : iph->daddr;
 	fl4->saddr = reverse ? iph->daddr : iph->saddr;
-	fl4->flowi4_tos = iph->tos;
+	fl4->flowi4_tos = iph->tos & ~INET_ECN_MASK;
 
 	if (!ip_is_fragment(iph)) {
 		switch (iph->protocol) {


