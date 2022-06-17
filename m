Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382094AbiFQMZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381190AbiFQMZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:25:17 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C4BC50B2B;
        Fri, 17 Jun 2022 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lyUeA
        EJPNXOiDGRPkx2gCmqH/ncwjelcptDnC5fq0Dw=; b=UPIY35gB1I0lbcdUmJejP
        fWxL4kIfSRJV7BbE8tezA+Av9wBPxDApMFL6RjFqGTOS3nhSFTMVs2bMiryi3Vb5
        PxbiIdV2bDE1TFQdPG1Lvca6zh+wl6GW+mAqjj3PBS+B0waywesFRJwwHKhp2NB3
        +gkQtHnk6nhioRS+GLXy2o=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgA3XMSicqxiVRR8Ew--.38429S2;
        Fri, 17 Jun 2022 20:25:07 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     john@phrozen.org, tsbogend@alpha.franken.de,
        xkernel.wang@foxmail.com
Cc:     windhl@126.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: lantiq: xway: Fix refcount leak bug in sysctrl
Date:   Fri, 17 Jun 2022 20:25:05 +0800
Message-Id: <20220617122505.4048126-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgA3XMSicqxiVRR8Ew--.38429S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfGr18WFyxAryfuF4DJwb_yoWfCrbEg3
        WxurWDGryfGr48JrW7Zr43CrsxAwn7KrZxJ3Z7Cry09343Za1jqF1aqryDZryruF1Skay3
        ZrsrWrWUZF429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUIztUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgMjF18RPUCyLQAAsV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ltq_soc_init(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/mips/lantiq/xway/sysctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 084f6caba5f2..d444a1b98a72 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -441,6 +441,10 @@ void __init ltq_soc_init(void)
 			of_address_to_resource(np_ebu, 0, &res_ebu))
 		panic("Failed to get core resources");
 
+	of_node_put(np_pmu);
+	of_node_put(np_cgu);
+	of_node_put(np_ebu);
+
 	if (!request_mem_region(res_pmu.start, resource_size(&res_pmu),
 				res_pmu.name) ||
 		!request_mem_region(res_cgu.start, resource_size(&res_cgu),
-- 
2.25.1

