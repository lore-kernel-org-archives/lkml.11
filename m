Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B0DC43334
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jun 2022 07:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiFRH26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jun 2022 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiFRH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 03:28:50 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FAAF27CC9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HY7SL
        91Dp2dwcjkDk2PgKRD2uPG9gAKpA9WqpsRDXao=; b=notICbNhFCVNQJ0z2cl5e
        XW1JCcxFY5dvE2TUNPIPc3h+HJQvvFtf+pSYLmv1lVca0tPxvvl+59QiNqwA81IL
        6e4KMz2g/zyrN60htNL/J0sdx/eHTwGiXT9WnZWtZXBvHBwMdZ75sSARPZu0QpcU
        59sDqQCn+z10Yes2yDW8gA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgCH3HCVfq1iWx2cEw--.30404S2;
        Sat, 18 Jun 2022 15:28:22 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     windhl@126.com, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: Fix refcount leak bug in irq-ls-extirq.c
Date:   Sat, 18 Jun 2022 15:28:20 +0800
Message-Id: <20220618072820.4059291-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgCH3HCVfq1iWx2cEw--.30404S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr15Kr17ZFy3try5CrWxZwb_yoW3Crg_Cr
        4IgFsrJF10vrsxGrsrXr9xXFyqyrykursY9rnavF98Xa48Jw1DGr1Y93y5Gw4kWF4jyFWk
        Cw4qvw18Aw13ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUS1vDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hYkF1uwMOnVyAAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ls_extirq_parse_map(), we need to keep refcount balance in the
'while' loop. For each of_find_node_by_phandle(), we need a paired
of_node_put().

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/irqchip/irq-ls-extirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 853b3972dbe7..82fffa37ee86 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -126,6 +126,7 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 			return -EINVAL;
 		priv->map[hwirq].fwnode = &ipar->fwnode;
 		ret = of_property_read_u32(ipar, "#interrupt-cells", &intsize);
+		of_node_put(ipar);
 		if (ret)
 			return ret;
 
-- 
2.25.1

