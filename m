Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 09:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiF2JKU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiF2JKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:10:18 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACBD7F5A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:10:17 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6BBEC1E80D11;
        Wed, 29 Jun 2022 17:09:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uiA1u6y_nFCQ; Wed, 29 Jun 2022 17:09:02 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 2FBE21E80CDC;
        Wed, 29 Jun 2022 17:09:02 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     kai.heng.feng@canonical.com, christophe.jaillet@wanadoo.fr,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] misc: Fix a typo
Date:   Wed, 29 Jun 2022 17:10:11 +0800
Message-Id: <20220629091011.36187-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'timout' to 'timeout'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 2a2619e3c72c..c42dd837bd4c 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -131,7 +131,7 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
 
 	rtsx_disable_aspm(pcr);
 
-	/* Fixes DMA transfer timout issue after disabling ASPM on RTS5260 */
+	/* Fixes DMA transfer timeout issue after disabling ASPM on RTS5260 */
 	msleep(1);
 
 	if (option->ltr_enabled)
-- 
2.34.1

