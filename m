Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E146DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Feb 2022 20:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbiBSUnT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Feb 2022 15:43:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbiBSUnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 15:43:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1101126
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 12:42:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f3so20055755wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 12:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MVIzOhhFVrqb+O9seRvzRjJKrnabh0ef9RGnj5egx0=;
        b=FSMy4/X+PUJEJ5uJN/rbAJeO95uFWHk7GhnIuk7030vhManD7qR9govmr251xgrmJZ
         xuM4QRG1/Uug+n1gJNfiZCMk9pVPOzF/JsmLVUafk3vt0e8XG8yimt/JoxYCyagVYO+A
         Z0yBoHl0J9lJLCXBsCOzzY6/XNtG9hLtsCnlffo8UnxTsRWV9UWxp4lLcP2m48jmec3M
         mFZU3GzyNOIybwDt0DfSGkN1eBKQU+Fa1fgqkVotgg/64epxWYXmVSr63ERZ1iL6mbih
         sZtKWYE5YCnCCvQdax2YBmJP7aDinxkQTK255zdxq7SRfJYrBG/3js1iR7knzmK8MUUL
         4BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MVIzOhhFVrqb+O9seRvzRjJKrnabh0ef9RGnj5egx0=;
        b=MkL7zpUYjDoTQdhpgP4uODPQd7exh0MMXF65RCf+5M97kVI0uHBpI60uWp/sKWEOzH
         NiLs6ZXU8Hfv9jaBNHjBsFfZ1b/QjLVicb2AMiYNCTPAdSM9ImtGw3d2ikb1xx/nKmNF
         3C05RDM+c/ZTe9KnUcEhrhngsL4rCiKowBf5Swgl6U9Mw8b7RHjBEXKY4/oLlZmr2/RJ
         IkTtQ4BeKi9Uuf/VQ9fVio4kfuPlG2I5r174gWH2hs16agLJ+P17bkUKSIDUWGhTmTUM
         8YodIRoP++XWd3aOQKUrVGoUHZDO65X5K7FyT5xOzBg6sys2hDT3UAZJ6LN+vyKzUL+0
         2YuQ==
X-Gm-Message-State: AOAM530oNRxFKpoRcUwewkTQYO1Xyx5nEzu1XDBZcKQ3MlDGoUdQBguA
        2I9nB8zJtoaQZ1/9H/89UjXgIm++Fv3PUBXppFRy0A==
X-Google-Smtp-Source: ABdhPJxILi9Tt//8KbB3NV1mBM8IWHXhxEWndhw60+nglzTtj7OeYIf/qMv+2HKB3zBG/Bu/DrGdmA==
X-Received: by 2002:adf:bc14:0:b0:1e2:b035:9c46 with SMTP id s20-20020adfbc14000000b001e2b0359c46mr10272297wrg.386.1645303376052;
        Sat, 19 Feb 2022 12:42:56 -0800 (PST)
Received: from localhost.localdomain ([217.61.0.106])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c464400b0037c19c2d16esm3023387wmo.43.2022.02.19.12.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 12:42:55 -0800 (PST)
From:   Hans Weber <hwe.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Weber <hwe.kernel@gmail.com>
Subject: [PATCH] only call the c function set_bios_mode if the value CONFIG_X86_64 is set.
Date:   Sat, 19 Feb 2022 21:42:45 +0100
Message-Id: <20220219204245.106718-1-hwe.kernel@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hans Weber <hwe.kernel@gmail.com>
---
 arch/x86/boot/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..e4df8ff1e228 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -102,14 +102,12 @@ static void query_ist(void)
  */
 static void set_bios_mode(void)
 {
-#ifdef CONFIG_X86_64
 	struct biosregs ireg;
 
 	initregs(&ireg);
 	ireg.ax = 0xec00;
 	ireg.bx = 2;
 	intcall(0x15, &ireg, NULL);
-#endif
 }
 
 static void init_heap(void)
@@ -152,7 +150,9 @@ void main(void)
 	}
 
 	/* Tell the BIOS what CPU mode we intend to run in. */
+#ifdef CONFIG_X86_64
 	set_bios_mode();
+#endif
 
 	/* Detect memory layout */
 	detect_memory();
-- 
2.30.2

