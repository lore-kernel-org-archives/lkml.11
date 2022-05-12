Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A017C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 06:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350140AbiELGJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 02:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350110AbiELGJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:09:20 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EDC104C83;
        Wed, 11 May 2022 23:09:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VCzTSH7_1652335746;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCzTSH7_1652335746)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 14:09:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     wellslutw@gmail.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, p.zabel@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] net: ethernet: Use swap() instead of open coding it
Date:   Thu, 12 May 2022 14:09:05 +0800
Message-Id: <20220512060905.33744-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the following coccicheck warning:

./drivers/net/ethernet/sunplus/spl2sw_driver.c:217:27-28: WARNING
opportunity for swap().

./drivers/net/ethernet/sunplus/spl2sw_driver.c:222:27-28: WARNING
opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Delete useless comments.

 drivers/net/ethernet/sunplus/spl2sw_driver.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 8320fa833d3e..1cb7076f946d 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -204,28 +204,16 @@ static const struct net_device_ops netdev_ops = {
 
 static void spl2sw_check_mac_vendor_id_and_convert(u8 *mac_addr)
 {
-	u8 tmp;
-
 	/* Byte order of MAC address of some samples are reversed.
 	 * Check vendor id and convert byte order if it is wrong.
 	 * OUI of Sunplus: fc:4b:bc
 	 */
 	if (mac_addr[5] == 0xfc && mac_addr[4] == 0x4b && mac_addr[3] == 0xbc &&
 	    (mac_addr[0] != 0xfc || mac_addr[1] != 0x4b || mac_addr[2] != 0xbc)) {
-		/* Swap mac_addr[0] and mac_addr[5] */
-		tmp = mac_addr[0];
-		mac_addr[0] = mac_addr[5];
-		mac_addr[5] = tmp;
-
-		/* Swap mac_addr[1] and mac_addr[4] */
-		tmp = mac_addr[1];
-		mac_addr[1] = mac_addr[4];
-		mac_addr[4] = tmp;
-
-		/* Swap mac_addr[2] and mac_addr[3] */
-		tmp = mac_addr[2];
-		mac_addr[2] = mac_addr[3];
-		mac_addr[3] = tmp;
+
+		swap(mac_addr[0], mac_addr[5]);
+		swap(mac_addr[1], mac_addr[4]);
+		swap(mac_addr[2], mac_addr[3]);
 	}
 }
 
-- 
2.20.1.7.g153144c

