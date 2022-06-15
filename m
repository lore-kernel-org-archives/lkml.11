Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 09:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbiFOJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiFOJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:13:20 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 771E138DAC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/ZdML
        VHVVBfA118OIj7yELcqrVyR5px2flvl70KNJJA=; b=GuKqFJqlftXaLQmuW9f26
        zRy3oX5u2OiPvgxW2T/AswqaWn5giv+WRJdofXuZ2su7XKBXzr/qgoqMRDWZCn35
        PS1E7zU34XGD+5WjQiS7HkkfcY/3tUrHOBUmF0Z67kbCDNXGsHzrFYfm7J2dz9Z9
        BxYUyvODSRsFNDc/NZix7U=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowACX2_qIoqli66FfDQ--.38808S2;
        Wed, 15 Jun 2022 17:12:42 +0800 (CST)
From:   heliang <windhl@126.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-pxa: Add missing of_node_put in irq.c
Date:   Wed, 15 Jun 2022 17:12:40 +0800
Message-Id: <20220615091240.3961831-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowACX2_qIoqli66FfDQ--.38808S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFyUCr15GrW3Zryfur1kAFb_yoW8JF45p3
        y2934kJr18ur4I9a40yay8Z3yYyF40gF4jkF4ak3W7Jw48AayjqFW8Kr9xZ3Z8GFW8Xa1r
        Ar4rJayxuF95CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE8uckUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AohF1pEDuWEkwAAsC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pxa_dt_irq_init(), of_find_matching_node() will return a node
pointer with refcount incremented. We should use of_node_put in
fail path or when it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mach-pxa/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 96f33ef1d9ea..a81e9ffb77af 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -246,12 +246,14 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 	ret = of_property_read_u32(node, "marvell,intc-nr-irqs",
 				   &pxa_internal_irq_nr);
 	if (ret) {
+		of_node_put(node);
 		pr_err("Not found marvell,intc-nr-irqs property\n");
 		return;
 	}
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret < 0) {
+		of_node_put(node);
 		pr_err("No registers defined for node\n");
 		return;
 	}
@@ -262,10 +264,12 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
 
 	ret = irq_alloc_descs(-1, 0, pxa_internal_irq_nr, 0);
 	if (ret < 0) {
+		of_node_put(node);
 		pr_err("Failed to allocate IRQ numbers\n");
 		return;
 	}
 
 	pxa_init_irq_common(node, pxa_internal_irq_nr, fn);
+	of_node_put(node);
 }
 #endif /* CONFIG_OF */
-- 
2.25.1

