Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFA3C43219
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 19:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381669AbiDTTL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351381AbiDTTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:11:53 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7582424AE;
        Wed, 20 Apr 2022 12:09:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650481740; bh=2rmj+wmfZSnjCFeUKvJuxbNQ7c6I46bc3UeTdcboskE=;
        h=From:To:Cc:Subject:Date;
        b=RSDpgvPqCblpwwaRVu/YhZuUCEyMK8iiba3QK6gsPmzlt2Eff37ZbVbBBOZxtLi+b
         A5rjlWW4qc1XSaCA80+sto9kb+rPIdMMByj8kcc/T16xfFGM3HhDLZyY1YFrGjybOs
         rX8snslgAm8y8DWb2MR2CFGb0GN2wCyTogwtyw0Q=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH v3 0/2] Apple ADMAC driver
Date:   Wed, 20 Apr 2022 21:07:53 +0200
Message-Id: <20220420190755.76617-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is v3 of driver for Audio DMA Controller on recent Apple SoCs.

Changes since v3:
(link: https://lore.kernel.org/dmaengine/20220411222204.96860-1-povik+lin@cutebit.org/ )
 - in binding, make 'interrupts' fixed length and add a comment
 - do not use devm allocation on descriptors
 - use platform_get_irq_optional to not log errors in the course of looking for
   an usable interrupt
 - make channel no. unsigned

Changes since v1:
(link: https://lore.kernel.org/dmaengine/20220330164458.93055-1-povik+lin@cutebit.org/ )
 - in binding, drop 'apple,internal-irq-destination' in favor of
   prepending entries to 'interrupts'
 - drop admac_peek/poke helpers
 - use special versions of dev_err/WARN_ON where desirable, fix %pad
   formatter invocation
 - bring implementation of terminate_all up to dmaengine spec, add
   device_synchronize
 - minor fixes (comments, formatting)

Thanks,
Martin

Martin Povišer (2):
  dt-bindings: dma: Add Apple ADMAC
  dmaengine: apple-admac: Add Apple ADMAC driver

 .../devicetree/bindings/dma/apple,admac.yaml  |  75 ++
 MAINTAINERS                                   |   2 +
 drivers/dma/Kconfig                           |   8 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/apple-admac.c                     | 818 ++++++++++++++++++
 5 files changed, 904 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
 create mode 100644 drivers/dma/apple-admac.c

-- 
2.33.0
