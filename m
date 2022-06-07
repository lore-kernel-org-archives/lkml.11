Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6BECCA49B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 18:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352288AbiFGSZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351040AbiFGSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F9F14E966;
        Tue,  7 Jun 2022 10:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B60614BC;
        Tue,  7 Jun 2022 17:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C87C385A5;
        Tue,  7 Jun 2022 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654623832;
        bh=63KEk9VLTggDHYa7uCWhw1ThCahBRf68liu0x9+Y4Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rush1UlLmlcnFStVdwaZM+9wh0vYIPvm8lomTvOhL0f1zoBi6DvhU50rLMYjSfCb1
         YwO5O7GO0NgO40FGRoTwnQVogI0cB62NpISr9GAoWaGAeosr+QBeCCBmDLmVZcj7bQ
         MO/KvKLfYCZzkvrgZ2+iM6tnqr/lfveyz+ZoaSHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        eberhard.stoll@kontron.de, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 108/667] spi: stm32-qspi: Fix wait_cmd timeout in APM mode
Date:   Tue,  7 Jun 2022 18:56:13 +0200
Message-Id: <20220607164938.062005587@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164934.766888869@linuxfoundation.org>
References: <20220607164934.766888869@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

[ Upstream commit d83d89ea68b4726700fa87b22db075e4217e691c ]

In APM mode, TCF and TEF flags are not set. To avoid timeout in
stm32_qspi_wait_cmd(), don't check if TCF/TEF are set.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reported-by: eberhard.stoll@kontron.de
Link: https://lore.kernel.org/r/20220511074644.558874-2-patrice.chotard@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index ffdc55f87e82..dd38cb8ffbc2 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -308,7 +308,8 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 	if (!op->data.nbytes)
 		goto wait_nobusy;
 
-	if (readl_relaxed(qspi->io_base + QSPI_SR) & SR_TCF)
+	if ((readl_relaxed(qspi->io_base + QSPI_SR) & SR_TCF) ||
+	    qspi->fmode == CCR_FMODE_APM)
 		goto out;
 
 	reinit_completion(&qspi->data_completion);
-- 
2.35.1



