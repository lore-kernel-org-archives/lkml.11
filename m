Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE1C35295
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359248AbiDLJU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357025AbiDLHjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136F52E62;
        Tue, 12 Apr 2022 00:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60AFFB81B55;
        Tue, 12 Apr 2022 07:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB389C385A8;
        Tue, 12 Apr 2022 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747449;
        bh=SNxsj0Sda60OXMqwWwNqNF+nUGirEVBwy2IM3bUSL9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuFYlrz5F9dp1iwyyvqL2Tc2m16NDKjGIQKZFCo0hQde9I3WdQLMdK8GRLjwkauiy
         uxrvxvGiTchspbHxelbsrHM84sI9Ou9t4IOlQH9e1i6sdTFNgY5UJlqLIY3ABxFgFG
         uQR0YDtvmOYFMze//yCpsYyO9k7lxP1leRh7njRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Mikityanskiy <maximmi@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 083/343] net/mlx5e: Disable TX queues before registering the netdev
Date:   Tue, 12 Apr 2022 08:28:21 +0200
Message-Id: <20220412062953.496711938@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Mikityanskiy <maximmi@nvidia.com>

[ Upstream commit d08c6e2a4d0308a7922d7ef3b1b3af45d4096aad ]

Normally, the queues are disabled when the channels are deactivated, and
enabled when the channels are activated. However, on register, the
channels are not active, but the queues are enabled by default. This
change fixes it, preventing mlx5e_xmit from running when the channels
are deactivated in the beginning.

Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3667f5ef5990..169e3524bb1c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5345,6 +5345,7 @@ mlx5e_create_netdev(struct mlx5_core_dev *mdev, const struct mlx5e_profile *prof
 	}
 
 	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
 	dev_net_set(netdev, mlx5_core_net(mdev));
 
 	return netdev;
-- 
2.35.1



