Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1519C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 17:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiHWRhh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHWRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:37:00 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0D8816A9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:20:41 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B03DF2007F;
        Tue, 23 Aug 2022 17:20:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1661268038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EFtFu5utQxl/cbAQO+lEXnvl78vZetgkEfJeBBZqMJA=;
        b=ztgcNeWbwutbuVNPd2GAZJVvaYGjfTr0xNxzy9GSbhy9zwzm4legDGRx8/01fxRwCPyncY
        DD6T8GKDEQoW3gGb6mdtXaqPgWtON2waFSaBUKVsx0bTAvo8x4kNKz2l7eVxwpKRpI9rZ8
        D+bsPLkzm9zOK/kqryfe2R6nbx1M0O8=
From:   David Heidelberg <david@ixit.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove EXPERIMENTAL flag for zswap
Date:   Tue, 23 Aug 2022 17:20:33 +0200
Message-Id: <20220823152033.66682-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zswap has been with us since 2013, and it's widely used in many products.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 mm/Kconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 96cd3ae25c6f..ceec438c0741 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -23,7 +23,7 @@ menuconfig SWAP
 	  in your computer.  If unsure say Y.
 
 config ZSWAP
-	bool "Compressed cache for swap pages (EXPERIMENTAL)"
+	bool "Compressed cache for swap pages"
 	depends on SWAP
 	select FRONTSWAP
 	select CRYPTO
@@ -36,12 +36,6 @@ config ZSWAP
 	  in the case where decompressing from RAM is faster than swap device
 	  reads, can also improve workload performance.
 
-	  This is marked experimental because it is a new feature (as of
-	  v3.11) that interacts heavily with memory reclaim.  While these
-	  interactions don't cause any known issues on simple memory setups,
-	  they have not be fully explored on the large set of potential
-	  configurations and workloads that exist.
-
 config ZSWAP_DEFAULT_ON
 	bool "Enable the compressed cache for swap pages by default"
 	depends on ZSWAP
-- 
2.35.1

