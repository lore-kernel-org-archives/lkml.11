Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CCC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 01:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiCJBgn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCJBgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:36:40 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D861275DD;
        Wed,  9 Mar 2022 17:35:37 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id x193so4576698oix.0;
        Wed, 09 Mar 2022 17:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UzCHhypSkLJprIXAcMJhvJcBDOhuIsnr/TqtkFrZpo=;
        b=nkcUU9jyuCDHQcemk/fY/d43WDO/fHwlrT+cP6IRSRRb4DKWNgXiboc20XR3KQz/gi
         e3VFutzD4cXdP0gsr08k9WBoSYypSnmza2Sug0I514ajVr25o9Wpvv2Jdw3gCQqGnClB
         DHau/mE1PFJDFGMo3ILi9KxD9QXOBZKTSAgytQgu4GTZGqjG7+L8s1+wsfioy+QM6963
         C1PtwjioFqng4jIQ7KvZ3+TqZvL+wF7K4jKA6C7zbE3dfv2/7dxDxhMVevL/VTqLtAql
         JN6EvoQnIwYZ3h9rpsL7EbXYXWfCGePJGyCCeRd+oeBOkCS5c6UvbWQFR24eLpqqam5I
         Ruww==
X-Gm-Message-State: AOAM532s0XDgwJphMxORsp1pfP/MmVla3YYvn/B6Uapo/8I7WHKBR/EV
        YW3I2Td9yrKIslWjrnwH/oxLyZ+g+w==
X-Google-Smtp-Source: ABdhPJzXxezvZ337NuQsQzgroJveKS/fHqg0+gFbTkvhk/uJ9k69i1LpQrABuKsRN0em6jlNQ/6aSg==
X-Received: by 2002:a05:6808:114d:b0:2d9:c932:d713 with SMTP id u13-20020a056808114d00b002d9c932d713mr7802966oiu.210.1646876136599;
        Wed, 09 Mar 2022 17:35:36 -0800 (PST)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id ds3-20020a0568705b0300b000d9c70e5275sm1627152oab.54.2022.03.09.17.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:35:35 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: virtio,mmio: Allow setting devices 'dma-coherent'
Date:   Wed,  9 Mar 2022 19:35:27 -0600
Message-Id: <20220310013528.549030-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'virtio,mmio' devices are always coherent within a guest. As Arm DTs
are default non-coherent, the 'dma-coherent' property needs to be set on
the virtio device to mark them as such. This aligns with the QEMU 'virt'
machine DTB.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/virtio/mmio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index 4b7a0273181c..10c22b5bd16a 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -20,6 +20,8 @@ properties:
   reg:
     maxItems: 1
 
+  dma-coherent: true
+
   interrupts:
     maxItems: 1
 
-- 
2.32.0

