Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiCRKjz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53382D9D7A;
        Fri, 18 Mar 2022 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cOg0/yz9gNz4OL5jX783k2UdjqKg9bi+XotEdQWLGrs=;
  b=aJej4WslBhT3QT4MVgfICkvLyrZ9sVsOqZTuboq/39kjlecFa0Wbo+XR
   eNyZVSc+/9vSE2a6fGm4xEgscr2uHK1Ta/FnXmiOUl4a/Wf2AtQTcpZv7
   OcgFumufUbNxFGL2R75/yxXZ/h/UJFZl9SKOO0j8V8HUHy5wAnFyDH579
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935643"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:37 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     kernel-janitors@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: mioa701: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:06 +0100
Message-Id: <20220318103729.157574-11-Julia.Lawall@inria.fr>
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
 arch/arm/mach-pxa/mioa701.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index a79f296e81e0..70934b237721 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -428,7 +428,7 @@ static struct platform_device docg3 = {
  *   - disables interrupts
  *   - initialize SDRAM (self refresh RAM into active RAM)
  *   - initialize GPIOs (depends on value at 0xa020b020)
- *   - initialize coprossessors
+ *   - initialize coprocessors
  *   - if edge detect on PWR_SCL(GPIO3), then proceed to cold start
  *   - or if value at 0xa020b000 not equal to 0x0f0f0f0f, proceed to cold start
  *   - else do a resume, ie. jump to addr 0xa0100000

