Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D55C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 22:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiDLWZM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiDLWZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 18:25:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03158195D8B;
        Tue, 12 Apr 2022 14:11:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1709C13D5;
        Tue, 12 Apr 2022 14:04:22 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E22863F70D;
        Tue, 12 Apr 2022 14:04:21 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, pbrobinson@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] net: bcmgenet: Revert "Use stronger register read/writes to assure ordering"
Date:   Tue, 12 Apr 2022 16:04:20 -0500
Message-Id: <20220412210420.1129430-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out after digging deeper into this bug, that it was being
triggered by GCC12 failing to call the bcmgenet_enable_dma()
routine. Given that a gcc12 fix has been merged [1] and the genet
driver now works properly when built with gcc12, this commit should
be reverted.

[1]
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105160
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=aabb9a261ef060cf24fd626713f1d7d9df81aa57

Fixes: 8d3ea3d402db ("net: bcmgenet: "Use stronger register read/writes to assure ordering")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 2dd79af9411b..9a41145dadfc 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -76,7 +76,7 @@ static inline void bcmgenet_writel(u32 value, void __iomem *offset)
 	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		__raw_writel(value, offset);
 	else
-		writel(value, offset);
+		writel_relaxed(value, offset);
 }
 
 static inline u32 bcmgenet_readl(void __iomem *offset)
@@ -84,7 +84,7 @@ static inline u32 bcmgenet_readl(void __iomem *offset)
 	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
 		return __raw_readl(offset);
 	else
-		return readl(offset);
+		return readl_relaxed(offset);
 }
 
 static inline void dmadesc_set_length_status(struct bcmgenet_priv *priv,
-- 
2.34.1

