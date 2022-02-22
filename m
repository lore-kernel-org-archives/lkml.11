Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 04:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiBVEYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 23:24:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBVEYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 23:24:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9657B560;
        Mon, 21 Feb 2022 20:24:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F0E3B81853;
        Tue, 22 Feb 2022 04:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DECC340E8;
        Tue, 22 Feb 2022 04:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645503858;
        bh=X77b75LIJSjrtE9IDXHIFr3LdPn8w2wR61bWYm4ZfrU=;
        h=From:To:Cc:Subject:Date:From;
        b=gzBP4769njn+Pzk6b072GuNWkzLa5eFVt9/GDvoPlbtk1WiU8NIWD02Ih/BJkC07l
         Dm69i5Gz0yxaq5cJLX9ZhLIzExQo6KbKb5tdfHq3c/3zhx44O8+AnRUulFz3D8y9pW
         4fV5czb0i/IJk187E0qX/Ai4j2L61ckDC3iQEx6pEgkgoiZMRpGwgQlDZUqJrzudFf
         Iwsv4pz5vHTuzeaDzje8VCzMwIiwAMTCr7QfK+6ZEx3HlkxeJlR0EOBZwI+27gLONW
         rGTUpJQXkxmgWwDterchbc1w9C32xJPDH4EfCsN3AUMKnZcHts7U4xk9kvHm5Hn4g+
         6ipRsb2Fyx5gQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm GPI DMA Driver
Date:   Tue, 22 Feb 2022 09:54:09 +0530
Message-Id: <20220222042409.1185564-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm GPI DMA Driver is used for DMA transfers for Serial engines
like Geni I2C and SPI.

Enable this dma driver

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..d73913f082d7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -948,6 +948,7 @@ CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
+CONFIG_QCOM_GPI_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
 CONFIG_RCAR_DMAC=y
-- 
2.34.1

