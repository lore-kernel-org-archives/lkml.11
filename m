Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21185C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 08:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiDYIX2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiDYIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:23:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B22672
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:20:08 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KmyTB2b9tzCs42;
        Mon, 25 Apr 2022 16:13:50 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 16:18:20 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <linus.walleij@linaro.org>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <wangxiongfeng2@huawei.com>, Peng Wu <wupeng58@huawei.com>
Subject: [PATCH -next] ARM: versatile: Add missing of_node_put in dcscb_init
Date:   Mon, 25 Apr 2022 08:14:16 +0000
Message-ID: <20220425081416.22836-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_find_compatible_node
with refcount incremented. We should use of_node_put() to avoid
the refcount leak.

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 arch/arm/mach-versatile/dcscb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/dcscb.c b/arch/arm/mach-versatile/dcscb.c
index 866270e7f271..d8797350996d 100644
--- a/arch/arm/mach-versatile/dcscb.c
+++ b/arch/arm/mach-versatile/dcscb.c
@@ -144,6 +144,7 @@ static int __init dcscb_init(void)
 	if (!node)
 		return -ENODEV;
 	dcscb_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!dcscb_base)
 		return -EADDRNOTAVAIL;
 	cfg = readl_relaxed(dcscb_base + DCS_CFG_R);
-- 
2.17.1

