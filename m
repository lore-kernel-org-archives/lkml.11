Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6DC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 01:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357534AbiCYBgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357429AbiCYBgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:36:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BFA41305
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:34:37 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KPl4c6b3dz1GDBj
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:34:24 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 09:34:35 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 09:34:35 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] irq: print depth in __enable_irq WARNING
Date:   Fri, 25 Mar 2022 09:33:59 +0800
Message-ID: <20220325013359.2691092-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since case 0 and 1 of desc->depth may print same warning messages as follows,
according to the messages, we do not know in which case the warning is generated.
This patch prints extra desc->depth in the warning messages to distinguish
these cases.
This patch just does warning message changes，no functional changes.

[20220314100142]------------[ cut here ]------------
[20220314100142]WARNING: CPU: 1 PID: 10332 at kernel/irq/manage.c:723 __enable_irq+0x58/0xa4
[20220314100142]Unbalanced enable for IRQ 38
......

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c03f71d5ec10..83bb9d9ee71a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -769,12 +769,12 @@ void disable_nmi_nosync(unsigned int irq)
 void __enable_irq(struct irq_desc *desc)
 {
 	switch (desc->depth) {
 	case 0:
  err_out:
-		WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n",
-		     irq_desc_get_irq(desc));
+		WARN(1, KERN_WARNING "depth %u: Unbalanced enable for IRQ %d\n",
+		     desc->depth, irq_desc_get_irq(desc));
 		break;
 	case 1: {
 		if (desc->istate & IRQS_SUSPENDED)
 			goto err_out;
 		/* Prevent probing on this irq: */
-- 
2.35.1

