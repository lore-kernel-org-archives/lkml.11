Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7188FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiCRKkH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiCRKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81828908C;
        Fri, 18 Mar 2022 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qhW3HK/YYf2DupqNUsLRUx6t/3sJl0jAIe5f0C8QuBw=;
  b=CYkjOOXBmr9BnhRVXz3sVJdE6LvIccNtx950Eej36ZGsJ9Ij7GOY8012
   MKTK3gnXl5pJqTwLs7pQGgFTfi+NRYzrh5j+lkW2OxvFM6kUxlfkr+OMh
   rjEVx9wrGgDpczWIjujwnlpvz+VbYX+F4Q/ypl1NzmIpFJtsnXehOT+pG
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935675"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:40 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: brcmstb: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:29 +0100
Message-Id: <20220318103729.157574-34-Julia.Lawall@inria.fr>
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
 arch/arm/mach-bcm/platsmp-brcmstb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index 4555f21e7077..9b457714a41c 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -59,7 +59,7 @@ static u32 hif_cont_reg;
 /*
  * We must quiesce a dying CPU before it can be killed by the boot CPU. Because
  * one or more cache may be disabled, we must flush to ensure coherency. We
- * cannot use traditionl completion structures or spinlocks as they rely on
+ * cannot use traditional completion structures or spinlocks as they rely on
  * coherency.
  */
 static DEFINE_PER_CPU_ALIGNED(int, per_cpu_sw_state);

