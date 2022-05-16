Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9DDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 12:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbiEPMtT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242553AbiEPMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:51 -0400
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 05:48:47 PDT
Received: from cvk-fw2.cvk.de (cvk-fw2.cvk.de [194.39.189.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E1393F2;
        Mon, 16 May 2022 05:48:47 -0700 (PDT)
Received: by cvk-fw2.cvk.de (Postfix, from userid 0)
        id 4L1zMQ5drlz4wKQ; Mon, 16 May 2022 14:38:58 +0200 (CEST)
From:   Thomas Bartschies <thomas.bartschies@cvk.de>
Subject: [Patch] net: af_key: check encryption module availability consistency
Message-Id: <4L1zMQ5drlz4wKQ@cvk-fw2.cvk.de>
Date:   Mon, 16 May 2022 14:38:58 +0200 (CEST)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the recent introduction supporting the SM3 and SM4 hash algos for IPsec, the kernel 
produces invalid pfkey acquire messages, when these encryption modules are disabled. This 
happens because the availability of the algos wasn't checked in all necessary functions. 
This patch adds these checks.

Signed-off-by: Thomas Bartschies <thomas.bartschies@cvk.de>

diff -uprN a/net/key/af_key.c b/net/key/af_key.c
--- a/net/key/af_key.c	2022-05-09 09:16:33.000000000 +0200
+++ b/net/key/af_key.c	2022-05-13 13:51:58.286250337 +0200
@@ -2898,7 +2898,7 @@ static int count_ah_combs(const struct x
 			break;
 		if (!aalg->pfkey_supported)
 			continue;
-		if (aalg_tmpl_set(t, aalg))
+		if (aalg_tmpl_set(t, aalg) && aalg->available)
 			sz += sizeof(struct sadb_comb);
 	}
 	return sz + sizeof(struct sadb_prop);
@@ -2916,7 +2916,7 @@ static int count_esp_combs(const struct
 		if (!ealg->pfkey_supported)
 			continue;
 
-		if (!(ealg_tmpl_set(t, ealg)))
+		if (!(ealg_tmpl_set(t, ealg) && ealg->available))
 			continue;
 
 		for (k = 1; ; k++) {
@@ -2927,7 +2927,7 @@ static int count_esp_combs(const struct
 			if (!aalg->pfkey_supported)
 				continue;
 
-			if (aalg_tmpl_set(t, aalg))
+			if (aalg_tmpl_set(t, aalg) && aalg->available)
 				sz += sizeof(struct sadb_comb);
 		}
 	}
