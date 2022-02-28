Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB55C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiB1RzJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiB1RwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:52:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF292D35;
        Mon, 28 Feb 2022 09:39:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEFBDB815A2;
        Mon, 28 Feb 2022 17:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F04C340F0;
        Mon, 28 Feb 2022 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646069978;
        bh=5uVrlQkD28VUujlNYgjjOG/6mkVMyfRz4XGWA7/Oy5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWfrQSENCMyAlMvTOp576VKCX3Vs+XFHx4tYah4X3LxeWv+Zf6uRhOo/9TvHkTzEH
         gzkFVEIX54dvCc/oOzfEctc69ysnBmwmW/w3VOm1YK8uoDzPASv1kn+DZkYu+4TXce
         Xn5ZK/74/fpnR6xdeuwpzuuQNVPZYgQ6we8GHA/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Levkovich <lariel@nvidia.com>,
        Maor Dickman <maord@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.15 080/139] net/mlx5: Fix wrong limitation of metadata match on ecpf
Date:   Mon, 28 Feb 2022 18:24:14 +0100
Message-Id: <20220228172356.114111140@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172347.614588246@linuxfoundation.org>
References: <20220228172347.614588246@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ariel Levkovich <lariel@nvidia.com>

commit 07666c75ad17d7389b18ac0235c8cf41e1504ea8 upstream.

Match metadata support check returns false for ecpf device.
However, this support does exist for ecpf and therefore this
limitation should be removed to allow feature such as stacked
devices and internal port offloaded to be supported.

Fixes: 92ab1eb392c6 ("net/mlx5: E-Switch, Enable vport metadata matching if firmware supports it")
Signed-off-by: Ariel Levkovich <lariel@nvidia.com>
Reviewed-by: Maor Dickman <maord@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2784,10 +2784,6 @@ bool mlx5_esw_vport_match_metadata_suppo
 	if (!MLX5_CAP_ESW_FLOWTABLE(esw->dev, flow_source))
 		return false;
 
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev) ||
-	    mlx5_ecpf_vport_exists(esw->dev))
-		return false;
-
 	return true;
 }
 


