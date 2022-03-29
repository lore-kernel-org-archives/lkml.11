Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A265C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 09:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiC2JNR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiC2JM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:12:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B4065D2B;
        Tue, 29 Mar 2022 02:11:15 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSNxB5vfwzBrbb;
        Tue, 29 Mar 2022 17:07:10 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:11:12 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
        <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2] net: dsa: felix: fix possible NULL pointer dereference
Date:   Tue, 29 Mar 2022 09:08:00 +0000
Message-ID: <20220329090800.130106-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the possible failure of the allocation, kzalloc() may return NULL
pointer.
Therefore, it should be better to check the 'sgi' in order to prevent
the dereference of NULL pointer.

Fixes: 23ae3a7877718 ("net: dsa: felix: add stream gate settings for psfp").
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---

v1->v2:Rewrite fixes tag, delete extra 'q'.

 drivers/net/dsa/ocelot/felix_vsc9959.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 33f0ceae381d..2875b5250856 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1940,6 +1940,10 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
 		case FLOW_ACTION_GATE:
 			size = struct_size(sgi, entries, a->gate.num_entries);
 			sgi = kzalloc(size, GFP_KERNEL);
+			if (!sgi) {
+				ret = -ENOMEM;
+				goto err;
+			}
 			vsc9959_psfp_parse_gate(a, sgi);
 			ret = vsc9959_psfp_sgi_table_add(ocelot, sgi);
 			if (ret) {
-- 
2.17.1

