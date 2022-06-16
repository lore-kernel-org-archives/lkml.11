Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 04:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358581AbiFPEEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358546AbiFPEEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:04:20 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 130AF424B3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=teE+F
        0bmrMKR1mJWBjATd3JGAZ0qoeCzoswrsTOyPFo=; b=mlT/sTUf0mnr9bnDqLk/Z
        xqkM1SaQ0AzKS2OVR06HxW37gdOCKsiSNtsxE6XIj/e5kpulCblKNXIFTQneFF4b
        VMm2iKE28zbUTGW5wv/pvrH3DaQ1QyibOK9YYPoVMtgoJcU6w6i+JW0ZYA5NBltd
        OgRFUNuN/TSzyAOMNoO/qA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowADXFvanq6piOjydDQ--.65253S2;
        Thu, 16 Jun 2022 12:03:51 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     nm@ti.com, ssantosh@kernel.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] mach-keystone: (pm_domain) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 12:03:48 +0800
Message-Id: <20220616040348.3976883-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowADXFvanq6piOjydDQ--.65253S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUCr15GrW3ZryDJw4DCFg_yoW3CFX_J3
        4xXa13WF1fJFs7WrWkAw43WrsIqw1kWrsFq343Xw4agF4UJw17ZFsrtrsavrW7XrW2krW3
        JayDAr1aywn29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_YFAtUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QkiF1pEANT7YQAAsB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In keystone_pm_runtime_init(), of_find_matching_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: use real name for Sob
 v1: fix missing bug

 arch/arm/mach-keystone/pm_domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 5eea01cbecf0..00c9c0230575 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -44,6 +44,7 @@ int __init keystone_pm_runtime_init(void)
 	if (!np)
 		return 0;
 
+	of_node_put(np);
 	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
 
 	return 0;
-- 
2.25.1

