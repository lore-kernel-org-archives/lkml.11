Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423BDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbiBIEIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiBIDYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:24:22 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13681C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:24:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eoWIYOaZeRs/v2aMKLkHveIxx9A2/s6u9pylLwYovIg=;
        b=OmnJp9CNrdZk/a9TzXx8vCi8716xgp/uNAup98z+s4zNeI6MSCvu3i6HL/4WElm+e0D2Cs
        GKun9bntMjXpsUwydOlhlkJPAT8GMeUm394ER6vCl6/8h1rRh1Xfb+ksKxPtY9Fp8LCAaM
        wTIe6JNRDNrjO16WhE7TX3WtHzvXTsU=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Roy Pledge <Roy.Pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] oc: fsl: dpio: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:23:53 +0800
Message-Id: <20220209032353.37610-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 1d2b27e3ea63..36f0a9b799b1 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -51,7 +51,7 @@ struct dpaa2_io_store {
 
 /* keep a per cpu array of DPIOs for fast access */
 static struct dpaa2_io *dpio_by_cpu[NR_CPUS];
-static struct list_head dpio_list = LIST_HEAD_INIT(dpio_list);
+static LIST_HEAD(dpio_list);
 static DEFINE_SPINLOCK(dpio_list_lock);
 
 static inline struct dpaa2_io *service_select_by_cpu(struct dpaa2_io *d,
-- 
2.25.1

