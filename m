Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 11:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbiF1Lfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiF1Lfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:35:45 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AF632050;
        Tue, 28 Jun 2022 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1656416144;
  x=1687952144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a2olrKI9dv74tiDxlIp0R9yvFP+Oc1Key6NJAoQ/KUY=;
  b=BTZIdJfQ0HVm/G3oxUsem30HH0di9jR67bceuMKKEB8F9kB8h2W9ZujE
   3SPzb1X6UB/0RFsQ1KX2R3Q2VHFsx0YFUcU7tdCHKtPpnc1cTE8QQWuSo
   H0lDJEkwJsLPmUwsN5mdbZ9Yn6M49r8JZsVBDdcDAB45Sy+K3r/Eh+XIh
   BXqMnyhbE6aKSIZ24l25nV8s1F4ANf7jVFaAjFd+mi2YG8T4JlCGMBujK
   gASeXevZx1RIvZ9PyDcBiNgXfytqyl8PhCpwLOCsEZeR5hi9XfXh7BhgT
   KLNtxCUNsv3tTwJaHx8kupukrXodAyv9xvg+xpnXrvMr0IbinK3j5HLQc
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] of: reserved-memory: Print allocation/reservation failures as error
Date:   Tue, 28 Jun 2022 13:35:40 +0200
Message-ID: <20220628113540.2790835-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the allocation/reservation of reserved-memory fails, it is normally
an error, so print it as an error so that it doesn't get hidden from the
console due to the loglevel.  Also make the allocation failure include
the size just like the reservation failure.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/of/fdt.c             | 4 ++--
 drivers/of/of_reserved_mem.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..4610729d2297 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -532,8 +532,8 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 				kmemleak_alloc_phys(base, size, 0, 0);
 		}
 		else
-			pr_info("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
-				uname, &base, (unsigned long)(size / SZ_1M));
+			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
+			       uname, &base, (unsigned long)(size / SZ_1M));
 
 		len -= t_len;
 		if (first) {
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 75caa6f5d36f..65f3b02a0e4e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -156,7 +156,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 	}
 
 	if (base == 0) {
-		pr_info("failed to allocate memory for node '%s'\n", uname);
+		pr_err("failed to allocate memory for node '%s': size %lu MiB\n",
+		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
 

base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
2.34.1

