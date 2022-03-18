Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiCRKk7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiCRKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7A2DC01A;
        Fri, 18 Mar 2022 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6EQm2/4/ejHjEKl9eCvFpbJ02DhoRGWYj06oVh2qQ7A=;
  b=CGgV1xTSrfX9Qh19D0jsRXYn58+p4SENpBE1ruFHwI00oCci4muJCL82
   VG9vtIKGiZ3b/iBPHDVqJneUFi2KoPA2ur9AOk7N3zAYlAJlE3oY8/G5Z
   VSpfiVirS9Gu15IwoYyQUP0yEVcOO26n2/wnvQq+mwk/3OBOHvA7vhhLL
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935667"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:39 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: gemini: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:24 +0100
Message-Id: <20220318103729.157574-29-Julia.Lawall@inria.fr>
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
 arch/arm/mach-gemini/board-dt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-gemini/board-dt.c b/arch/arm/mach-gemini/board-dt.c
index de0afcc8d94a..fb9481a06fc6 100644
--- a/arch/arm/mach-gemini/board-dt.c
+++ b/arch/arm/mach-gemini/board-dt.c
@@ -34,7 +34,7 @@ static void gemini_idle(void)
 {
 	/*
 	 * Because of broken hardware we have to enable interrupts or the CPU
-	 * will never wakeup... Acctualy it is not very good to enable
+	 * will never wakeup... Actually it is not very good to enable
 	 * interrupts first since scheduler can miss a tick, but there is
 	 * no other way around this. Platforms that needs it for power saving
 	 * should enable it in init code, since by default it is

