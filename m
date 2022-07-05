Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C977CCA47C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiGEUXH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiGEUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:23:06 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7515720
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:23:04 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8p4XoztESgoLG8p4XoHrFO; Tue, 05 Jul 2022 22:23:03 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 05 Jul 2022 22:23:03 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH] bnxt: Use the bitmap API to allocate bitmaps
Date:   Tue,  5 Jul 2022 22:22:59 +0200
Message-Id: <d508f3adf7e2804f4d3793271b82b196a2ccb940.1657052562.git.christophe.jaillet@wanadoo.fr>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 11d35da61921..c74b2e4250ad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4477,7 +4477,7 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool irq_reinit)
 		}
 	}
 	if (irq_reinit) {
-		kfree(bp->ntp_fltr_bmap);
+		bitmap_free(bp->ntp_fltr_bmap);
 		bp->ntp_fltr_bmap = NULL;
 	}
 	bp->ntp_fltr_count = 0;
@@ -4496,9 +4496,7 @@ static int bnxt_alloc_ntp_fltrs(struct bnxt *bp)
 		INIT_HLIST_HEAD(&bp->ntp_fltr_hash_tbl[i]);
 
 	bp->ntp_fltr_count = 0;
-	bp->ntp_fltr_bmap = kcalloc(BITS_TO_LONGS(BNXT_NTP_FLTR_MAX_FLTR),
-				    sizeof(long),
-				    GFP_KERNEL);
+	bp->ntp_fltr_bmap = bitmap_zalloc(BNXT_NTP_FLTR_MAX_FLTR, GFP_KERNEL);
 
 	if (!bp->ntp_fltr_bmap)
 		rc = -ENOMEM;
-- 
2.34.1

