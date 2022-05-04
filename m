Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092EDC4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 17:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356107AbiEDRQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 13:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355963AbiEDREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8D4F9FC;
        Wed,  4 May 2022 09:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D700D61505;
        Wed,  4 May 2022 16:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C23C385AA;
        Wed,  4 May 2022 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651683216;
        bh=eidVBpEHpfCZhtqWZN0t3L727DuGTceR+6ii9207lXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzXANxX2pAT6TwfowZT6cSxMMbjhSSKEe4/aPLlo0mAVovp9XMSj2TOotpfoMm8c2
         8D1+qQuX4bqssfI9I4dIEYMDhxT7aD28Ra7RSvRiGIto81bOo4/7Xv49KQCrOP0z2j
         xxR5J7goZ4vqXK+4yO7SGg4RXDfQAd9mpnVs4eFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 081/177] netfilter: nft_set_rbtree: overlap detection with element re-addition after deletion
Date:   Wed,  4 May 2022 18:44:34 +0200
Message-Id: <20220504153100.311608257@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504153053.873100034@linuxfoundation.org>
References: <20220504153053.873100034@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit babc3dc9524f0bcb5a0ec61f3c3639b11508fad6 ]

This patch fixes spurious EEXIST errors.

Extend d2df92e98a34 ("netfilter: nft_set_rbtree: handle element
re-addition after deletion") to deal with elements with same end flags
in the same transation.

Reset the overlap flag as described by 7c84d41416d8 ("netfilter:
nft_set_rbtree: Detect partial overlaps on insertion").

Fixes: 7c84d41416d8 ("netfilter: nft_set_rbtree: Detect partial overlaps on insertion")
Fixes: d2df92e98a34 ("netfilter: nft_set_rbtree: handle element re-addition after deletion")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_rbtree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index d600a566da32..7325bee7d144 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -349,7 +349,11 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 				*ext = &rbe->ext;
 				return -EEXIST;
 			} else {
-				p = &parent->rb_left;
+				overlap = false;
+				if (nft_rbtree_interval_end(rbe))
+					p = &parent->rb_left;
+				else
+					p = &parent->rb_right;
 			}
 		}
 
-- 
2.35.1



