Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiCBIoP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiCBIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:44:12 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ADDF3B55F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:43:29 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowADnLscqLh9iU9AFAg--.5230S2;
        Wed, 02 Mar 2022 16:43:22 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     codrin.ciubotariu@microchip.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] misc: atmel-ssc: Handle error for clk_prepare_enable
Date:   Wed,  2 Mar 2022 16:43:19 +0800
Message-Id: <20220302084319.96435-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnLscqLh9iU9AFAg--.5230S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4DZw4kXw47Kw43KF1DAwb_yoWkWrg_Ca
        18ursrWr4Ykrs3Kw1UGr13uryDur4qqFyrXr1Iqay3tryDAw17urWDZrs8Ary7uw40yry3
        G3Wqq3ySkrWagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUeHUDDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failure of the clk_prepare_enable(),
it should be better to check it and return error if fails.

Fixes: eb1f2930609b ("Driver for the Atmel on-chip SSC on AT32AP and AT91")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/misc/atmel-ssc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index d6cd5537126c..c76ca234af4b 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -192,6 +192,7 @@ static int ssc_probe(struct platform_device *pdev)
 	struct resource *regs;
 	struct ssc_device *ssc;
 	const struct atmel_ssc_platform_data *plat_dat;
+	int ret;
 
 	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
 	if (!ssc) {
@@ -226,7 +227,10 @@ static int ssc_probe(struct platform_device *pdev)
 	}
 
 	/* disable all interrupts */
-	clk_prepare_enable(ssc->clk);
+	ret = clk_prepare_enable(ssc->clk);
+	if (ret)
+		return ret;
+
 	ssc_writel(ssc->regs, IDR, -1);
 	ssc_readl(ssc->regs, SR);
 	clk_disable_unprepare(ssc->clk);
-- 
2.25.1

