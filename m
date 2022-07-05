Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108DCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 19:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiGETeR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiGETeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:34:14 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE29413D06
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:34:13 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8oJGowQqjsiIK8oJGosnsD; Tue, 05 Jul 2022 21:34:12 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 05 Jul 2022 21:34:12 +0200
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
Subject: [PATCH] sfc/siena: Use the bitmap API to allocate bitmaps
Date:   Tue,  5 Jul 2022 21:34:08 +0200
Message-Id: <717ba530215f4d7ce9fedcc73d98dba1f70d7f71.1657049636.git.christophe.jaillet@wanadoo.fr>
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
 drivers/net/ethernet/sfc/siena/farch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/farch.c b/drivers/net/ethernet/sfc/siena/farch.c
index cce23803c652..89ccd65c978b 100644
--- a/drivers/net/ethernet/sfc/siena/farch.c
+++ b/drivers/net/ethernet/sfc/siena/farch.c
@@ -2778,7 +2778,7 @@ void efx_farch_filter_table_remove(struct efx_nic *efx)
 	enum efx_farch_filter_table_id table_id;
 
 	for (table_id = 0; table_id < EFX_FARCH_FILTER_TABLE_COUNT; table_id++) {
-		kfree(state->table[table_id].used_bitmap);
+		bitmap_free(state->table[table_id].used_bitmap);
 		vfree(state->table[table_id].spec);
 	}
 	kfree(state);
@@ -2822,9 +2822,7 @@ int efx_farch_filter_table_probe(struct efx_nic *efx)
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

