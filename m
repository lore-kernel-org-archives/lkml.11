Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA796ECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 11:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiH2LH0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiH2LGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F218AE75;
        Mon, 29 Aug 2022 04:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883566119E;
        Mon, 29 Aug 2022 11:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926D8C433D7;
        Mon, 29 Aug 2022 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661771090;
        bh=gwq1OqMwhb/YuVfl7qY3edF58qVgD9W2LIDU7en9DcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBNfYcR8PBs3fMOe/BJsNM2FGNLmSG4htLNx0hGZS0502vEAzSw72NJhV5u/9MiSt
         8xvdwokHm4BZrUwA3JZg0/JVh7i3BDZuUX4cmg8389gka5RQ7WopveyRxQZCoN6m7+
         GCPdZ6KeMJWJSa4Icg5JYhM0bs+mcqoYliC/+l24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 060/136] netfilter: nft_osf: restrict osf to ipv4, ipv6 and inet families
Date:   Mon, 29 Aug 2022 12:58:47 +0200
Message-Id: <20220829105807.084811764@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829105804.609007228@linuxfoundation.org>
References: <20220829105804.609007228@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 5f3b7aae14a706d0d7da9f9e39def52ff5fc3d39 ]

As it was originally intended, restrict extension to supported families.

Fixes: b96af92d6eaf ("netfilter: nf_tables: implement Passive OS fingerprint module in nft_osf")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_osf.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index d82677e83400b..720dc9fba6d4f 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -115,9 +115,21 @@ static int nft_osf_validate(const struct nft_ctx *ctx,
 			    const struct nft_expr *expr,
 			    const struct nft_data **data)
 {
-	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_LOCAL_IN) |
-						    (1 << NF_INET_PRE_ROUTING) |
-						    (1 << NF_INET_FORWARD));
+	unsigned int hooks;
+
+	switch (ctx->family) {
+	case NFPROTO_IPV4:
+	case NFPROTO_IPV6:
+	case NFPROTO_INET:
+		hooks = (1 << NF_INET_LOCAL_IN) |
+			(1 << NF_INET_PRE_ROUTING) |
+			(1 << NF_INET_FORWARD);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return nft_chain_validate_hooks(ctx->chain, hooks);
 }
 
 static struct nft_expr_type nft_osf_type;
-- 
2.35.1



