Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F66C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 12:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbiBDMzw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:55:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59352 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiBDMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:55:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D7AA61F469E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643979348;
        bh=C4urODFZw7AtHIaxrvfdBAqahnpDdMVBAE6xBMu5TPc=;
        h=From:To:Cc:Subject:Date:From;
        b=T92LlZOAHSaRjlk14SGlbTbiQ2qznUnnPREWv2O84NkGuo0UIPHDbmW/Pms8SeIpe
         TUBm0sRvrdFxhpg4bb/KYYj80bZqesX99exRjxpf6sXlqDQDQmUF0qujOwJkThvRPr
         hbhuq3dx+bUHfr1BG2Ke71TgX1bHjxq+psEQau5SAMPLkNhCQtLhtnT3sdnTwHhYLu
         NiiZ+kZ29wDFf3+EMUtRkSEqiyCeNKabZ5SDOnpf9B4HhLrqELzhTbMGNkZbUcG0Nc
         +cTq5fJB7eO0TDEB+agYvxF9Kp25HEhIaSL4nMOWfBuzELk7L2iU27tmvqf7vz2t8U
         BQ3T3UfcMOd+A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     krzysztof.kozlowski@canonical.com, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] memory: mtk-smi: Enable sleep ctrl safety function for MT8195
Date:   Fri,  4 Feb 2022 13:55:43 +0100
Message-Id: <20220204125543.1189151-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sleep ctrl function to wait until all the queued commands
are executed before suspending the LARBs, like done for MT8186.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/memory/mtk-smi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index c22acd3ddd10..86a3d34f418e 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -351,7 +351,8 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
-	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG,
+	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
+				      MTK_SMI_FLAG_SLEEP_CTL,
 	.ostd		            = mtk_smi_larb_mt8195_ostd,
 };
 
-- 
2.33.1

