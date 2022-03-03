Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC8BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 02:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiCCCDB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 21:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiCCCC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:02:56 -0500
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C882DAA0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:02:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V64nQbZ_1646272927;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V64nQbZ_1646272927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 10:02:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] misc: rtsx: clean up one inconsistent indenting
Date:   Thu,  3 Mar 2022 10:02:06 +0800
Message-Id: <20220303020206.98911-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/misc/cardreader/rts5228.c:494 rts5228_extra_init_hw() warn:
inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/misc/cardreader/rts5228.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index af581f4f74d1..cfebad51d1d8 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -491,7 +491,7 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 
 	if (pcr->rtd3_en) {
 		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x01);
-	rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
+		rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
 				FORCE_PM_CONTROL | FORCE_PM_VALUE,
 				FORCE_PM_CONTROL | FORCE_PM_VALUE);
 	} else {
-- 
2.20.1.7.g153144c

