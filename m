Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8900EC4321E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbiEJO0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244470AbiEJNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E42A0A41;
        Tue, 10 May 2022 06:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03003615C8;
        Tue, 10 May 2022 13:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DD3C385C2;
        Tue, 10 May 2022 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652189905;
        bh=CZCbhfw3omaRJXhOwD3hj63Q4L75/COhbyLBzDbWWxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vhNqLmQfBiWaFOb9RqbcWklPP3VhLdgl5Azskqu0HLK/FMVk7Y5dIcW+k4eohsQUg
         bEgBn6RxbhT+AdSUV2hhHRDKa3tMdRljiJwQiw4+o9jKu11XLVwaMhnF3lW0re85dI
         req+GoI5Rr0vIverNEey2YUNY6e2vLBu5OUrhUMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@nvidia.com>,
        Maor Dickman <maord@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.17 066/140] net/mlx5e: Dont match double-vlan packets if cvlan is not set
Date:   Tue, 10 May 2022 15:07:36 +0200
Message-Id: <20220510130743.507125417@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510130741.600270947@linuxfoundation.org>
References: <20220510130741.600270947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlad Buslov <vladbu@nvidia.com>

commit ada09af92e621ab500dd80a16d1d0299a18a1180 upstream.

Currently, match VLAN rule also matches packets that have multiple VLAN
headers. This behavior is similar to buggy flower classifier behavior that
has recently been fixed. Fix the issue by matching on
outer_second_cvlan_tag with value 0 which will cause the HW to verify the
packet doesn't contain second vlan header.

Fixes: 699e96ddf47f ("net/mlx5e: Support offloading tc double vlan headers match")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Maor Dickman <maord@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2355,6 +2355,17 @@ static int __parse_cls_flower(struct mlx
 				 match.key->vlan_priority);
 
 			*match_level = MLX5_MATCH_L2;
+
+			if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CVLAN) &&
+			    match.mask->vlan_eth_type &&
+			    MLX5_CAP_FLOWTABLE_TYPE(priv->mdev,
+						    ft_field_support.outer_second_vid,
+						    fs_type)) {
+				MLX5_SET(fte_match_set_misc, misc_c,
+					 outer_second_cvlan_tag, 1);
+				spec->match_criteria_enable |=
+					MLX5_MATCH_MISC_PARAMETERS;
+			}
 		}
 	} else if (*match_level != MLX5_MATCH_NONE) {
 		/* cvlan_tag enabled in match criteria and


