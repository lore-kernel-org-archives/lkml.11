Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B7C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jul 2022 10:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiGWKND (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jul 2022 06:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbiGWKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:12:43 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DF3AD2C31;
        Sat, 23 Jul 2022 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wM/Zg
        eEXEMc6sruVtkovWHuCByrjUkw3xuMCX7v3yss=; b=jkZjnVugzhSTujONx6O3N
        HnOg1JCy6HNrRztipMFB5cUHCDJpOspJut8zeGWoqcOOAUEgtXW8mAQcLYOd6WWZ
        DZOEbuDwDcnSMRNRPkcE9GrIQT8YyZ96OquD0wT+75ukSj5UWZHhib1CYTFvvxSt
        uOiX/ZAJoxT12UkSSrvOn0=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp14 (Coremail) with SMTP id EsCowADHB9T8xttiEWurOg--.13020S2;
        Sat, 23 Jul 2022 18:01:35 +0800 (CST)
From:   williamsukatube@163.com
To:     tglx@linutronix.de, maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, fancer.lancer@gmail.com,
        William Dean <williamsukatube@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH v2] irqchip: mips-gic: check the return value of ioremap() in gic_of_init()
Date:   Sat, 23 Jul 2022 18:01:28 +0800
Message-Id: <20220723100128.2964304-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADHB9T8xttiEWurOg--.13020S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry5tr13GF1rZrWruFy3Arb_yoWfuFbE93
        WqgFZ3AFW0vF18GFW7WFW7XFyUJwn7uFn5urWkta4fXrWfuw4xGr9xuwn8Xa4rXF1Iyr98
        CFZ5ZryIyF17AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Jrc3UUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiUQlHg2DEOr2dEAABsz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@163.com>

The function ioremap() in gic_of_init() can fail, so
its return value should be checked.

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@163.com>
---
v2: delete fixes tag and correct SoB tag

 drivers/irqchip/irq-mips-gic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36267dd..a1f6d955794a 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -734,6 +734,10 @@ static int __init gic_of_init(struct device_node *node,
 	}
 
 	mips_gic_base = ioremap(gic_base, gic_len);
+	if (!mips_gic_base) {
+		pr_err("Failed to ioremap gic_base\n");
+		return -ENOMEM;
+	}
 
 	gicconfig = read_gic_config();
 	gic_shared_intrs = FIELD_GET(GIC_CONFIG_NUMINTERRUPTS, gicconfig);
-- 
2.25.1

