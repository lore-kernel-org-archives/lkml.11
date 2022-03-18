Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A105C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiCRKlC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiCRKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308262DB5B6;
        Fri, 18 Mar 2022 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v9EcQBitnjr0Qd2gvKpLLlOpgJnTuOTcBN0LGyO+Pho=;
  b=T565Mm0SyjWVfqpwOTVc9+ULQTmt55bzetBCDr6fNBDZ0ikKAA2dAWM3
   99UXx6N8lf/sNp+A2fTLQ8VomBWnnd4qPjsSkcSRCEMQUpN5rMqMKT/eT
   zlpdmrDa9HHtcn+mjEiPdmYKe1OsXEvMLhrLUOcYz6+peRlkRB3XwFOYA
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935661"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:39 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Daniel Mack <daniel@zonque.org>
Cc:     kernel-janitors@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: tavorevb: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:20 +0100
Message-Id: <20220318103729.157574-25-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arm/mach-pxa/tavorevb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index a15eb3b9484d..39db392c2270 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -252,7 +252,7 @@ static uint16_t panel_init[] = {
 	SMART_DAT(0x40), /* 16/18/19 BPP */
 	SMART_DAT(0x00),
 	SMART_CMD(0x00),
-	SMART_CMD(0x08), /* BP, FP Seting, BP=2H, FP=3H */
+	SMART_CMD(0x08), /* BP, FP Setting, BP=2H, FP=3H */
 	SMART_DAT(0x03),
 	SMART_DAT(0x02),
 	SMART_CMD(0x00),

