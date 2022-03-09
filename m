Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC5C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 02:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiCICCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 21:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiCICCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:02:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A0DB6D1AC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646791263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JMTE4NG+0qZIipp9NlTc+cagsu8XvKYHjvLHlZFdoUs=;
        b=LoX0QPdGmzaAsY5iv99YFb+/jVZTdP94U/YVJc2kW9Ng96AeXiRZbrv2pwPxnzhGu6eIq8
        80bFxgH8h/+q5jVxhSnSm8AwK6vZJwk3qLWHYETKqZMmxo8wcqpB3nOjD7dqKbPh15gg6t
        qhFsPpPlJpMv507Wgsp/OYXTcqeq8vQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-XAWTscljPKeHIdHO3ibkCw-1; Tue, 08 Mar 2022 21:01:02 -0500
X-MC-Unique: XAWTscljPKeHIdHO3ibkCw-1
Received: by mail-il1-f198.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso452201ili.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 18:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMTE4NG+0qZIipp9NlTc+cagsu8XvKYHjvLHlZFdoUs=;
        b=R3dJTLTtFpZYye8LMLYQVVT0j5xoPym1N23PTgXuWooE4+mF0jONIhTN3DGozeKNPD
         U0hvCXM9/SwC/ErfeEUDRig/qMLhOJDVdJFvzBzV4BPQuoO0mk8WD8mkH2iUThrSJtbU
         x2rEv9nQNVZCvI2IrkKHzBqUvIs5UpU/15fJuneyc9CONV6fDpIyY6hvKdlkP43Nisgr
         AMSkgc+d8gWBV7IVyjygR1xDTNzK2VkQ4TCrSaF7lP2jbxgLKn4pDPFrWHvRENdSHh4r
         NNf7RKulBFG3LBjLuXDcO/pH9QjpSgPmHzuaSceHVZtvn+tlB6NPCVRA26yzlAS+Fbtv
         A+2g==
X-Gm-Message-State: AOAM5332NaGEImEMVXG7MgXSt4r+hW8V5QTYkPlOq54TwESbHJSfY8TB
        DkMNGqcPNxx3ikABq9fQHwGYnTV+v7HjW14PCh6ESxZU9XHGbQ7asZRaWxTnUmlD4TQcVHYv0Dt
        chFdn/dVMW+WOUEXD0USaLmVm
X-Received: by 2002:a5e:930c:0:b0:641:7453:fdb with SMTP id k12-20020a5e930c000000b0064174530fdbmr16773066iom.184.1646791261264;
        Tue, 08 Mar 2022 18:01:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzthKQWc54tByEEnMsfVfDaa+/muodQBg0VJuzwsmDFo+Ss7zzuWIAR5tZRLURo916y5dA4bQ==
X-Received: by 2002:a5e:930c:0:b0:641:7453:fdb with SMTP id k12-20020a5e930c000000b0064174530fdbmr16773054iom.184.1646791261003;
        Tue, 08 Mar 2022 18:01:01 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x2-20020a056602160200b006463c1977f9sm307849iow.22.2022.03.08.18.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 18:01:00 -0800 (PST)
From:   trix@redhat.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: cleanup comments
Date:   Tue,  8 Mar 2022 18:00:56 -0800
Message-Id: <20220309020056.1026106-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx, /* */ for *.h, remove extra space

Replacements
configurarion to configuration
inerrupts to interrupts
chanels to channels

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 33baf1591a490..e9c9bcb1f5c20 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:  GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 // (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
 
 /*
@@ -35,7 +35,7 @@
 /*
  * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
  * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configurarion.
+ * it depends on IP block configuration.
  */
 #define AXI_DMA_BUSWIDTHS		  \
 	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
@@ -1089,10 +1089,10 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 
 	u32 status, i;
 
-	/* Disable DMAC inerrupts. We'll enable them after processing chanels */
+	/* Disable DMAC interrupts. We'll enable them after processing channels */
 	axi_dma_irq_disable(chip);
 
-	/* Poll, clear and process every chanel interrupt status */
+	/* Poll, clear and process every channel interrupt status */
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
 		status = axi_chan_irq_read(chan);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index be69a0b76860d..e9d5eb0fd5948 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:  GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
 
 /*
-- 
2.26.3

