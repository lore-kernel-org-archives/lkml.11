Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591AEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 15:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiBVPLT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiBVPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:11:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FDB10EC54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:10:46 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 898D9FF810;
        Tue, 22 Feb 2022 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645542645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOzUysK3jq7AptlFGEUXnbGP4YiZSWMiMjPJXH0yfpY=;
        b=KoqrDVr6S5OlXWjEh9c4iYJKN8olSySo1900gjM5a4ZLYyl6bswEjGjPjdRduSC94LCTO5
        kj2rP9rEZ4nYnOwyqg10Fb1H74hEgYfy4E3V73F6j35Q0cSdz88m0kdOxtzB1kTan/mjXw
        17Q9zmwPbQLPOQFB+CmydJ/NQy0CsVigvKTaoB5Wb0YAhre5bN9NyRtEpSKk6IKygezoxK
        +whlrdy29Xm7kZjgkZwugh/wIV0UlY55jBFvvV5ybxVzVL4cOmYr7XU05ZhNsEzCOuSCQF
        WGagLCDdZDvqrh0wlILMqm5AbS4ItvD/njce9TQMRQX3+3vwLOlF7DIGgmG0Ew==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 4/4] ARM: at91: pm: fix defines to select *_pm_init functions
Date:   Tue, 22 Feb 2022 16:08:46 +0100
Message-Id: <20220222150846.255307-5-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222150846.255307-1-clement.leger@bootlin.com>
References: <20220222150846.255307-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These defines actually don't depend on CONFIG_PM but CONFIG_ATMEL_PM.
In the same time, add a "or" with CONFIG_ATMEL_SECURE_PM since it can
also provides these functions.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/mach-at91/generic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c3960a8b3eb..279ab7e0cdca 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -8,7 +8,7 @@
 #ifndef _AT91_GENERIC_H
 #define _AT91_GENERIC_H
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_ATMEL_PM) || defined(CONFIG_ATMEL_SECURE_PM)
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9_pm_init(void);
 extern void __init sam9x60_pm_init(void);
-- 
2.34.1

