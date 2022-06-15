Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375E8C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 12:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiFOMoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348482AbiFOMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:44:16 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECB0E3A181;
        Wed, 15 Jun 2022 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eZeXQ
        LI0Qb9U+a8CP0CcBum5Wq7iRv3hWHUItekcgbM=; b=NU5wJtOPhFlFxXuCu6c2W
        yZKYSv3repoQQPCo/npAdRpUfNFCSKjPuKsGjY2mjWIi9fTebn21pb9rKj5Nbhvl
        xVy72B/SrHvVXG/10MQ9mkEEq7YEbBwNhxTOZM138pvsRn+Xu9OERLFRgWp6+2Sm
        ELwfEZOPezc0QfwuLx1p58=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowADXb5EU1KliUUGKDQ--.43652S2;
        Wed, 15 Jun 2022 20:44:04 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: mips: pic32: pic32mzda: Add missing of_node_put() in time.c
Date:   Wed, 15 Jun 2022 20:44:02 +0800
Message-Id: <20220615124402.3966099-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADXb5EU1KliUUGKDQ--.43652S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW3GryrZw4rGw4UXw4xJFb_yoW3JFb_Kr
        n7Za1UZr43XFn8CrWI9w13J345Zw15Wr1S9rs2qF17Ar1Yy3sxWF4DJa4vkw129ayjyrW3
        KrZxZryrAwsFyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_YFAtUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgUhF1-HZTacLQAAsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pic32_xlate_core_timer_irq(), of_find_matching_node() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/mips/pic32/pic32mzda/time.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
index 7174e9abbb1b..c5b5343ca03c 100644
--- a/arch/mips/pic32/pic32mzda/time.c
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -32,6 +32,9 @@ static unsigned int pic32_xlate_core_timer_irq(void)
 		goto default_map;
 
 	irq = irq_of_parse_and_map(node, 0);
+	
+	of_node_put(node);
+	
 	if (!irq)
 		goto default_map;
 
-- 
2.25.1

