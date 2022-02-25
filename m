Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAFDC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 11:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiBYLUq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiBYLUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:20:45 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155921DF19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:20:11 -0800 (PST)
X-QQ-mid: bizesmtp74t1645787977tb99bvk4
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 25 Feb 2022 19:19:31 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000000A0000000
X-QQ-FEAT: JRmPfD6HWhwtEx95bUE3TkDE0Zl0T/p5bw+l9Du6N8AbfR6XjS0YDNEzACYAx
        IjtVDQf6ogeyNJNbXUefxDlGFp79P85xICFE3BGBqXvxNhTOhwZ7OBVIF5R5745EUA81A90
        wdr6B/k31D97kERdVqHlr6COgAOzp0lSQmIFIXQWVjqFrNaLRsYVzx5nx/31HA3MuOCmqOp
        oCkW7IIAilf12fRNwDuFT7UCYiZEnsed1W1QB9tJFgbSEXhM1WW77Q81BeXvqmbGrXvG3MP
        xA9AZxoZ+Nt/54JB3VZkqSiP+1gpGIV2SgYgNFeshXA43FvbgjIwatMnaJBkEd6cJ+vhsH1
        TuKAVs/hqP4yWB2otd3RenxbL6N8ELgQ9PgymW2SdsrfK4rsJA=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] sound/mips: Use platform_get_irq() to get the interrupt
Date:   Fri, 25 Feb 2022 19:19:29 +0800
Message-Id: <20220225111929.17194-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypassed the hierarchical setup and messed up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/mips/snd-n64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/mips/snd-n64.c b/sound/mips/snd-n64.c
index 463a6fe589eb..bff6d85b8fe2 100644
--- a/sound/mips/snd-n64.c
+++ b/sound/mips/snd-n64.c
@@ -289,8 +289,7 @@ static int __init n64audio_probe(struct platform_device *pdev)
 	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct n64audio *priv;
-	struct resource *res;
-	int err;
+	int err, irq;
 
 	err = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			   SNDRV_DEFAULT_STR1,
@@ -337,12 +336,12 @@ static int __init n64audio_probe(struct platform_device *pdev)
 	strcpy(card->shortname, "N64 Audio");
 	strcpy(card->longname, "N64 Audio");
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		err = -EINVAL;
 		goto fail_dma_alloc;
 	}
-	if (devm_request_irq(&pdev->dev, res->start, n64audio_isr,
+	if (devm_request_irq(&pdev->dev, irq, n64audio_isr,
 				IRQF_SHARED, "N64 Audio", priv)) {
 		err = -EBUSY;
 		goto fail_dma_alloc;
-- 
2.20.1



