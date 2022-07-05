Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8FCCA47B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 19:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiGETi3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiGETg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:36:58 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABB1928B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:36:57 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8oLtojYQmeg3p8oLtoGrDv; Tue, 05 Jul 2022 21:36:55 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 05 Jul 2022 21:36:55 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH] sfc: falcon: Use the bitmap API to allocate bitmaps
Date:   Tue,  5 Jul 2022 21:36:51 +0200
Message-Id: <c62c1774e6a34bc64323ce526b385aa87c1ca575.1657049799.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/sfc/falcon/farch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
index 2c91792cec01..c64623c2e80c 100644
--- a/drivers/net/ethernet/sfc/falcon/farch.c
+++ b/drivers/net/ethernet/sfc/falcon/farch.c
@@ -2711,7 +2711,7 @@ void ef4_farch_filter_table_remove(struct ef4_nic *efx)
 	enum ef4_farch_filter_table_id table_id;
 
 	for (table_id = 0; table_id < EF4_FARCH_FILTER_TABLE_COUNT; table_id++) {
-		kfree(state->table[table_id].used_bitmap);
+		bitmap_free(state->table[table_id].used_bitmap);
 		vfree(state->table[table_id].spec);
 	}
 	kfree(state);
@@ -2740,9 +2740,7 @@ int ef4_farch_filter_table_probe(struct ef4_nic *efx)
 		table = &state->table[table_id];
 		if (table->size == 0)
 			continue;
-		table->used_bitmap = kcalloc(BITS_TO_LONGS(table->size),
-					     sizeof(unsigned long),
-					     GFP_KERNEL);
+		table->used_bitmap = bitmap_zalloc(table->size, GFP_KERNEL);
 		if (!table->used_bitmap)
 			goto fail;
 		table->spec = vzalloc(array_size(sizeof(*table->spec),
-- 
2.34.1

