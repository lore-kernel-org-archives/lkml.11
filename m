Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48FC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 02:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348987AbiFPCRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 22:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiFPCRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:17:48 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0C55CE0A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uWTZo
        puv+eTmb8blBVa+w52hbjLTmbkv4BKsZVzXeGM=; b=ndATkmlvr2C4uQgvYT29N
        72BcB8fSLAndJz2F7IqfxWLnT42VJO71XCyxIvUt09lbk6CQz6UQuHdJHLClzy3z
        YGd/iLAveFcigZ4qDsgGZqu3f7l2N6+NPaHYzJYeWMr/X7m7HItgn9LYl8PjNh2N
        nNAvBdgmydbl+kICkrifr4=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgDX_sqrkqpijNhiEw--.21997S2;
        Thu, 16 Jun 2022 10:17:22 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux@armlinux.org.uk, heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] arm: mach-rockchip: (pm) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 10:17:13 +0800
Message-Id: <20220616021713.3973472-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgDX_sqrkqpijNhiEw--.21997S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDZw1xWr4DZFWrXw1UJrb_yoWkGrcEgw
        4fWwnrXr4fGw4fXa4q93y3GwsrA3ykGr1fua10vF95tF1Dtr1UGFs5t34aya4UWFy29rW7
        GrnFvrnIkw1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuHq73UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BIiF1pEDuqFXAAAsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rockchip_suspend_init(), of_find_matching_node_and_match() will
return a node pointer with refcount incremented. We should use
of_node_put() in fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: (1) use real name for Sob (2) use goto-label patch style
 v1: add of_node_put() for each return

 arch/arm/mach-rockchip/pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index 87389d9456b9..bb46ac4f65d4 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -311,7 +311,7 @@ void __init rockchip_suspend_init(void)
 					     &match);
 	if (!match) {
 		pr_err("Failed to find PMU node\n");
-		return;
+		goto out_put;
 	}
 	pm_data = (struct rockchip_pm_data *) match->data;
 
@@ -320,9 +320,13 @@ void __init rockchip_suspend_init(void)
 
 		if (ret) {
 			pr_err("%s: matches init error %d\n", __func__, ret);
-			return;
+			goto out_put;
 		}
 	}
 
 	suspend_set_ops(pm_data->ops);
+	
+out_put:
+	of_node_put(np);
+	
 }
-- 
2.25.1

