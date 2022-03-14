Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7BCC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiCNMNF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbiCNMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:10:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F72DAAE;
        Mon, 14 Mar 2022 05:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52A64B80DF3;
        Mon, 14 Mar 2022 12:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8BDC340E9;
        Mon, 14 Mar 2022 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647259753;
        bh=xJ+KYWSxLIKSGGFBEs/vHnUXou4aY8bd6GyVJYnNmZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UhzY/vnZ6AgnanGtRV3BwxZ4Fv6bJFMoeYeHBVDy0Tgmdg6L2J2wqldz5JWSTdl7e
         O5LM1D42quguC2OYfJEtNO4btHoZkkjecwAzTJPcU1ltTkv7VYECQiXjbruJKaHS1y
         j+q6wESRfKJo+6yApwsux1F3KYCfBOYMbj05eyrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammad Kabat <mohammadkab@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 040/110] net/mlx5: Fix size field in bufferx_reg struct
Date:   Mon, 14 Mar 2022 12:53:42 +0100
Message-Id: <20220314112744.157043431@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112743.029192918@linuxfoundation.org>
References: <20220314112743.029192918@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohammad Kabat <mohammadkab@nvidia.com>

[ Upstream commit ac77998b7ac3044f0509b097da9637184598980d ]

According to HW spec the field "size" should be 16 bits
in bufferx register.

Fixes: e281682bf294 ("net/mlx5_core: HW data structs/types definitions cleanup")
Signed-off-by: Mohammad Kabat <mohammadkab@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mlx5/mlx5_ifc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 25d775764a5a..fdf4589ab4d4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -9508,8 +9508,8 @@ struct mlx5_ifc_bufferx_reg_bits {
 	u8         reserved_at_0[0x6];
 	u8         lossy[0x1];
 	u8         epsb[0x1];
-	u8         reserved_at_8[0xc];
-	u8         size[0xc];
+	u8         reserved_at_8[0x8];
+	u8         size[0x10];
 
 	u8         xoff_threshold[0x10];
 	u8         xon_threshold[0x10];
-- 
2.34.1



