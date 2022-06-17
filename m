Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F0C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381813AbiFQK4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 06:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380407AbiFQK4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:56:33 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C21426B7D0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9Mrui
        S4DmngTVu9k6eC0bPm1cFgp62PM9Aty8aRo8wM=; b=ODBz4vpaP/4oMEwhnVHbU
        /ICbKoOcKbr8MTujPb5gWPc/V8BXMgr6lhqTkw7zHbLZvisyIYxGnL+7X+jRrxTh
        a7gikhoU7o84/uAoP6zUz6jpHbFktq+QHOfPj8vdUynSzrarDPkIF4DXECxZLzpX
        +bqX0wsvvX0/WR1DJqpVqM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBH3oq9XaxiPoxsFw--.38055S2;
        Fri, 17 Jun 2022 18:55:57 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     dinguyen@kernel.org, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-socfpga: Fix refcount leak bug in platsmp
Date:   Fri, 17 Jun 2022 18:55:56 +0800
Message-Id: <20220617105556.4041305-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBH3oq9XaxiPoxsFw--.38055S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKry3tFyUtrb_yoW3WFg_JF
        n3tay7Wr1rZF4vg3yUCa13Wrs7A3s5Cwn3Xa4vvrn0yw4YvF13CrsFyas2q3yUJr4a9FWx
        Jan7Kr4Y939IvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUIztUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7R0jF1pEAN9-6AAAsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In socfpga_smp_prepare_cpus(), of_find_compatible_node() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-socfpga/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 201191cf68f3..349e6c54518e 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -78,6 +78,7 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	socfpga_scu_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 	if (!socfpga_scu_base_addr)
 		return;
 	scu_enable(socfpga_scu_base_addr);
-- 
2.25.1

