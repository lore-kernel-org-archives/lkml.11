Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5BAC49EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355282AbiHWKX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353440AbiHWKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67237F088;
        Tue, 23 Aug 2022 01:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83AA7614E7;
        Tue, 23 Aug 2022 08:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84157C433D6;
        Tue, 23 Aug 2022 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661245005;
        bh=XpSNX1f32Q6TMFam1wAor2QPc0RbNk2vlmC0HXRK4HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyAYj4fR39pmAuInkNtnIeIZwrkwR+1z2qlq2m0dKDyo7pdzISZQmipq4qo544PU7
         JQQc5sDn+hNF44zV8TdNMhNFr/icmqdmDJje29F/FYRA0XmIlPKKe8D5GwoIXmXAiX
         KI2EOhG6ZSxgqSCBd1sUqwIezsAFDO9Go38pEEMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 187/244] habanalabs/gaudi: mask constant value before cast
Date:   Tue, 23 Aug 2022 10:25:46 +0200
Message-Id: <20220823080105.602580987@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080059.091088642@linuxfoundation.org>
References: <20220823080059.091088642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <ogabbay@kernel.org>

[ Upstream commit e3f49437a2e0221a387ecd192d742ae1434e1e3a ]

This fixes a sparse warning of
"cast truncates bits from constant value"

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 801acab048eb..8132200dca67 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3318,19 +3318,19 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 	u32 nic_qm_err_cfg, irq_handler_offset;
 	u32 q_off;
 
-	mtr_base_en_lo = lower_32_bits(CFG_BASE +
+	mtr_base_en_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 			mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
 	mtr_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	so_base_en_lo = lower_32_bits(CFG_BASE +
+	so_base_en_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
 	so_base_en_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0);
-	mtr_base_ws_lo = lower_32_bits(CFG_BASE +
+	mtr_base_ws_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
 	mtr_base_ws_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
-	so_base_ws_lo = lower_32_bits(CFG_BASE +
+	so_base_ws_lo = lower_32_bits((CFG_BASE & U32_MAX) +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
 	so_base_ws_hi = upper_32_bits(CFG_BASE +
 				mmSYNC_MNGR_W_S_SYNC_MNGR_OBJS_SOB_OBJ_0);
-- 
2.35.1



