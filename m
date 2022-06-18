Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2F0C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jun 2022 02:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiFRCPo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 22:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFRCPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:15:42 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E2845996C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GaBYA
        qUZfaZqwpCH9HuLpyPa7Yo/yQcbvMzk6zEWXEM=; b=f7ebZe5JF+AhwjrlFlvQl
        J45ItqjwKDgUxb4OymtPXTEv0OHhcjQxD+VNfAZHp36YUJumG+FcfitvK3bceaSD
        y8pjrkyrbyYg+NNGBE9Tbtjk6COBPOpdF7FICJmx0fL+hdp0e/377s+9wMDbBRZG
        /Uafv5dXJhR5XKaCpHu4+8=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgCXG5g2Na1iy9GOFw--.45770S2;
        Sat, 18 Jun 2022 10:15:18 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-mvebu: Fix refcount leak bug in pm.c
Date:   Sat, 18 Jun 2022 10:15:17 +0800
Message-Id: <20220618021517.4056054-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgCXG5g2Na1iy9GOFw--.45770S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fWry3Gry7Cr4UZr15XFb_yoWDuFg_CF
        1xX34fXrn3JF129rsxZ3W5Ww13tw1Fg3WxZFy0vasak3yYqF43Cr1qvF1vvr9xZrnxKr43
        GrZrCrya9w1jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjFksPUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhYkF18RPUQn0AAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mvebu_internal_reg_base(), of_find_node_by_name() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/arm/mach-mvebu/pm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index c487be61d6d8..d00e43241dfa 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -91,6 +91,7 @@ static phys_addr_t mvebu_internal_reg_base(void)
 {
 	struct device_node *np;
 	__be32 in_addr[2];
+	phys_addr_t addr;
 
 	np = of_find_node_by_name(NULL, "internal-regs");
 	BUG_ON(!np);
@@ -103,7 +104,11 @@ static phys_addr_t mvebu_internal_reg_base(void)
 	in_addr[0] = cpu_to_be32(0xf0010000);
 	in_addr[1] = 0x0;
 
-	return of_translate_address(np, in_addr);
+	addr = of_translate_address(np, in_addr);
+
+	of_node_put(np);
+
+	return addr;
 }
 
 static void mvebu_pm_store_armadaxp_bootinfo(u32 *store_addr)
-- 
2.25.1

