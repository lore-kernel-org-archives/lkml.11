Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7762C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiCRKl4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492B32DB589;
        Fri, 18 Mar 2022 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XBpfIuyHSANAOhj078uXXqv651OUQX5NbO0vD6Y+EMQ=;
  b=k7Ppgrb6sZjyWWydYo2Cors5WpFXCQYiZ9kO4LVoTjoqrROBUVTRftn/
   upJf5Zf8x+zqWbYvlU03xhDBe5hmRUK3/ymklJSjh9xqu/tlKgIjVsc5l
   wD/KvKgmU2bSLIUW7X7R/BAEMHADQzW6pFjfYDaW7DqOYXc47w3im9fEf
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935648"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:37 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc:     kernel-janitors@vger.kernel.org,
        Antoine Tenart <atenart@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Alpine: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:11 +0100
Message-Id: <20220318103729.157574-16-Julia.Lawall@inria.fr>
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
 arch/arm/mach-alpine/alpine_cpu_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.c b/arch/arm/mach-alpine/alpine_cpu_pm.c
index 13ae8412e9ce..b48da6f12b6c 100644
--- a/arch/arm/mach-alpine/alpine_cpu_pm.c
+++ b/arch/arm/mach-alpine/alpine_cpu_pm.c
@@ -29,7 +29,7 @@ int alpine_cpu_wakeup(unsigned int phys_cpu, uint32_t phys_resume_addr)
 	/*
 	 * Set CPU resume address -
 	 * secure firmware running on boot will jump to this address
-	 * after setting proper CPU mode, and initialiing e.g. secure
+	 * after setting proper CPU mode, and initializing e.g. secure
 	 * regs (the same mode all CPUs are booted to - usually HYP)
 	 */
 	writel(phys_resume_addr,

