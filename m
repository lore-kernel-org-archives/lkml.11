Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9850C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355059AbiFUUzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355429AbiFUUyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:54:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D6E31220;
        Tue, 21 Jun 2022 13:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D219B81B01;
        Tue, 21 Jun 2022 20:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9005AC341C6;
        Tue, 21 Jun 2022 20:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844572;
        bh=M5ZujuZ0mG33Rr/sqbkSj4dYDw6RrPY7vPQnXkZ/t0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPa791RObR0m2Id7TZcbBR4FA5rm2XgXrB+4luWsYt85e/1tiJC1N4RdQDWtEs0fb
         F0pQwAqs+zu7z9WlvhV6mayoCWDl+04QZVxAra0bRHS6pA2LHBGN2+AMHQoD3HaI1V
         S0XHG1ThAkIWiFbzfRO4wjK8Ih08/ht7cqoRfZNDl2zc3EueXhkgsCcJebtCOC0MOO
         1XGX+3ElrEpMOG3n6uF4G7zC+gz+cCj9g7OFiH7ffJ8MrVLORTep8KCgID0BW/l+w8
         MdI64wUjoIY6JTyMyccYnBb90IOAyFOamMjuz5BAQL9Bl3l2Bc1vatHBOUHVBWTLmr
         e2z92Hv+YNn9w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tglx@linutronix.de, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 02/22] irqchip/uniphier-aidet: Add compatible string for NX1 SoC
Date:   Tue, 21 Jun 2022 16:49:08 -0400
Message-Id: <20220621204928.249907-2-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit e3f056a7aafabe4ac3ad4b7465ba821b44a7e639 ]

Add the compatible string to support UniPhier NX1 SoC, which has the same
kinds of controls as the other UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1653023822-19229-3-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-uniphier-aidet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index 89121b39be26..716b1bb88bf2 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -237,6 +237,7 @@ static const struct of_device_id uniphier_aidet_match[] = {
 	{ .compatible = "socionext,uniphier-ld11-aidet" },
 	{ .compatible = "socionext,uniphier-ld20-aidet" },
 	{ .compatible = "socionext,uniphier-pxs3-aidet" },
+	{ .compatible = "socionext,uniphier-nx1-aidet" },
 	{ /* sentinel */ }
 };
 
-- 
2.35.1

