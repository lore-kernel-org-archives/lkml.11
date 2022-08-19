Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C66C32772
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352503AbiHSQXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352249AbiHSQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF91108B04;
        Fri, 19 Aug 2022 08:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C783617B6;
        Fri, 19 Aug 2022 15:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F53C433C1;
        Fri, 19 Aug 2022 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660924750;
        bh=dUu8ueBkoD9WU0J+cgsPNoGbfDPcl41stYx5RPPV8tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMClyR2CXMIh5ggA7/szONT3KGPSPQfim4/tzqoC+JwYcU6FI6Q+rmCFvNEpaCaC5
         /6PFOrPr66y4Hi35QYisuC4oc5C0dNaCmj8I6CDGPHDF0F0mZ40bufRKn144gaA4CO
         r8LaJCyFLmO/BMk5weUn2xc9k+nkFno6t74ISE7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 270/545] mtd: maps: Fix refcount leak in of_flash_probe_versatile
Date:   Fri, 19 Aug 2022 17:40:40 +0200
Message-Id: <20220819153841.412789570@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 33ec82a6d2b119938f26e5c8040ed5d92378eb54 ]

of_find_matching_node_and_match() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20220523140205.48625-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/maps/physmap-versatile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/physmap-versatile.c b/drivers/mtd/maps/physmap-versatile.c
index ad7cd9cfaee0..297a50957356 100644
--- a/drivers/mtd/maps/physmap-versatile.c
+++ b/drivers/mtd/maps/physmap-versatile.c
@@ -207,6 +207,7 @@ int of_flash_probe_versatile(struct platform_device *pdev,
 
 		versatile_flashprot = (enum versatile_flashprot)devid->data;
 		rmap = syscon_node_to_regmap(sysnp);
+		of_node_put(sysnp);
 		if (IS_ERR(rmap))
 			return PTR_ERR(rmap);
 
-- 
2.35.1



