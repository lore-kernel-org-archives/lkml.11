Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB3C4707A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 18:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiB1SHz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiB1SDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:03:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE5B1A94;
        Mon, 28 Feb 2022 09:47:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA636090B;
        Mon, 28 Feb 2022 17:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2E2C340E7;
        Mon, 28 Feb 2022 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646070393;
        bh=/qOcK68W8HfNhLzrkb3f4fmvbBeVDcxcPV7W7EcBejw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3KiHZSRG90iv79diy8R1FCzmrFwF1PnwnfPP5SfyT88LvAa03I2HJDjGKO/8J8r+
         +JBUYScSzuIp7QkqJUYeGRdkV+3QzdpD3JPfSk5uzu0fuOlf00bvjkVJn1F3/bUtz5
         4Rj9QN6mcl7a1BTuu5NyqUNYG6aPMoWbTpYqtmik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5.16 091/164] net/mlx5: Fix possible deadlock on rule deletion
Date:   Mon, 28 Feb 2022 18:24:13 +0100
Message-Id: <20220228172408.084994170@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172359.567256961@linuxfoundation.org>
References: <20220228172359.567256961@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

commit b645e57debca846f51b3209907546ea857ddd3f5 upstream.

Add missing call to up_write_ref_node() which releases the semaphore
in case the FTE doesn't have destinations, such in drop rule case.

Fixes: 465e7baab6d9 ("net/mlx5: Fix deletion of duplicate rules")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2073,6 +2073,8 @@ void mlx5_del_flow_rules(struct mlx5_flo
 		fte->node.del_hw_func = NULL;
 		up_write_ref_node(&fte->node, false);
 		tree_put_node(&fte->node, false);
+	} else {
+		up_write_ref_node(&fte->node, false);
 	}
 	kfree(handle);
 }


