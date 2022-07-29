Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A21C00144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 10:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiG2KyB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiG2Kx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:53:58 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5686898
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:53:57 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id a89so5350480edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Xp9zvBEtNP0sLWBfliMYcm9HXkv6yC+SaOOe7WcEjlA=;
        b=Jkd57X3PfNoC6i+t6yjqqQFwmaUIG1T6efiWJnieeSLwOL4/FxtGn+RA9o3MMEwSyP
         f9e/l/QX9nY68foO+/vxdlypH4PX5tLz4d/wR88gvz85NKD6YegqbFAqdeJ/PMyrDqlE
         XxTXTr2z7wXstC9sGKRmRDqAFpys4KsjtuLib90goBJ4EoHJ7aewvStK0HL63FBrPnoh
         akLWzAKMBeMZN8uTcG3LuY4NM+A/WMpdy1cP/vKq3jKqx8cUIOp+kWB5XFpxznbYOXx8
         7l3LD2alCAm11II8Xs46EIw9S4ujSw7nvWpgohZ7XXR2o75qsMM+Eo9cAuf9Ozd21boF
         P9EQ==
X-Gm-Message-State: AJIora+M3R6n4LTWnxaVq+9Wb72H5h1onKzE3Pj8tFsPCXct91YcklNn
        uP30+aGHWJQiuysC6/FvGiL5uCkJ58NSrA==
X-Google-Smtp-Source: AGRyM1sJog8zoXoYhoRgdRKzX/JyPkg0AG/pecwJreQTpr6foRxqBc+gEleJuDK4vScjCyOeKpGx/g==
X-Received: by 2002:a05:6402:1cc8:b0:437:a61a:5713 with SMTP id ds8-20020a0564021cc800b00437a61a5713mr2998033edb.340.1659092035969;
        Fri, 29 Jul 2022 03:53:55 -0700 (PDT)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id s21-20020aa7cb15000000b0043cfda1368fsm1972031edt.82.2022.07.29.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 03:53:55 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     leit@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: bcm_vk: Remove usage of deprecated functions
Date:   Fri, 29 Jul 2022 03:52:40 -0700
Message-Id: <20220729105240.748241-1-leitao@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_simple_get() and ida_simple_remove() functions are deprecated now.
These functions were replaced by ida_alloc() and ida_free()
respectively. This patch modernize bcm_vk to use the replacement
functions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index a16b99bdaa13..a3a82ebbc699 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1401,7 +1401,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bcm_vk_tty_set_irq_enabled(vk, i);
 	}
 
-	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&bcm_vk_ida, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		dev_err(dev, "unable to get id\n");
@@ -1500,7 +1500,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	misc_device->name = NULL;
 
 err_ida_remove:
-	ida_simple_remove(&bcm_vk_ida, id);
+	ida_free(&bcm_vk_ida, id);
 
 err_irq:
 	for (i = 0; i < vk->num_irqs; i++)
@@ -1573,7 +1573,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	if (misc_device->name) {
 		misc_deregister(misc_device);
 		kfree(misc_device->name);
-		ida_simple_remove(&bcm_vk_ida, vk->devid);
+		ida_free(&bcm_vk_ida, vk->devid);
 	}
 	for (i = 0; i < vk->num_irqs; i++)
 		devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), vk);
-- 
2.30.2

