Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF1CC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 15:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiCYPI2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359497AbiCYPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:07:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62DD95F3;
        Fri, 25 Mar 2022 08:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41919B828FB;
        Fri, 25 Mar 2022 15:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBECC340E9;
        Fri, 25 Mar 2022 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648220728;
        bh=TqXe9YFq23t1/gzrasVd1FhOgppT1K15PivWNvtui84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btyqAdj/mvr/d7vcov3wjm5yCt8fv3QSl10lVMWG0BRChHDqU4P3dEIpfoRDiM8b4
         eE/e/X66kP4DtBHLB2da+nF8UBDc717i79fVTBuUnrsK18yghWjXilbLPCjZa62mRa
         naGxGhNN0IPTuXqQC2JoE61l5dd5OMelnPqC+aXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 09/14] netfilter: nf_tables: initialize registers in nft_do_chain()
Date:   Fri, 25 Mar 2022 16:04:37 +0100
Message-Id: <20220325150415.972515117@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325150415.694544076@linuxfoundation.org>
References: <20220325150415.694544076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 4c905f6740a365464e91467aa50916555b28213d upstream.

Initialize registers to avoid stack leak into userspace.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -127,7 +127,7 @@ nft_do_chain(struct nft_pktinfo *pkt, vo
 	const struct net *net = pkt->net;
 	const struct nft_rule *rule;
 	const struct nft_expr *expr, *last;
-	struct nft_regs regs;
+	struct nft_regs regs = {};
 	unsigned int stackptr = 0;
 	struct nft_jumpstack jumpstack[NFT_JUMP_STACK_SIZE];
 	struct nft_stats *stats;


