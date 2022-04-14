Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610C1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 10:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiDNKTO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiDNKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EEF6EC43;
        Thu, 14 Apr 2022 03:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C04D61E6D;
        Thu, 14 Apr 2022 10:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AEAC385A8;
        Thu, 14 Apr 2022 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931400;
        bh=k5IGeL3/e80yqo6jzrVq7sF7AFRVxWGY/Q3M40TAa3k=;
        h=From:To:Cc:Subject:Date:From;
        b=t/ZgTAm9DkbG8QpOHlqconyMLVjbS/CTb2CySNonxa9GxAZ94lGb0K6rVTDEBy1Mt
         tl2c6OkM4uU/G8i25MsGbeKvWxceAMEfjxWSBXsELMvFvmiyhn4LYCzW0zFCqVGTbu
         HT6E+GR52xWC5bVXiAoJwrseyLrovkw2U6+B4RFWuLi9hgPkjeY/yEUB2MCAXjpvHW
         c4/1HVM0coZsO/WmjCqvLG5JxH197e35lOCo9aI14gF8stLh4L9Tb7MO6VLb+tq46q
         bxOkzH7pI4xGsok7sthgQEaaX9jY6OFBMuK6MAhg6HBTgSSYHokjDGMwmHX8phOcVU
         Rv+9O1XwJUanQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] arm64: dts: qcom: sm8450: Add QUP and DMA nodes
Date:   Thu, 14 Apr 2022 15:46:23 +0530
Message-Id: <20220414101630.1189052-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the gpi_dma nodes followed by the i2c and spi nodes for the
three qups found in the SM8450 SoC.

While at it, iommus was missing for qup0/qup1, so fix that up too.

Lastly enable the spi and i2c nodes found on the QRD board.

Vinod Koul (7):
  arm64: dts: qcom: sm8450: Add gpi_dma nodes
  arm64: dts: qcom: sm8450: Fix missing iommus for qup
  arm64: dts: qcom: sm8450: Add qup nodes for qup0
  arm64: dts: qcom: sm8450: Add qup nodes for qup1
  arm64: dts: qcom: sm8450: Add qup nodes for qup2
  arm64: dts: qcom: sm8450: Fix missing iommus for qup1
  arm64: dts: qcom: sm8450-qrd: Enable spi and i2c nodes

 arch/arm64/boot/dts/qcom/sm8450-qrd.dts |   24 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 1240 +++++++++++++++++++++++
 2 files changed, 1264 insertions(+)

-- 
2.34.1

