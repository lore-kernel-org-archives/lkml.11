Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CCECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiH3PRF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH3PRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:17:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A41F8ED2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:17:00 -0700 (PDT)
X-QQ-mid: bizesmtp88t1661872616tmvl3xwi
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 23:16:55 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: C2zsvWT0ctXYz7t8L+JIevpESiy0KQ35zCmWA7PylJSRha2JlagNaqIdOLEtU
        tVBvTe5OFtrlaO199XUcu4Ju13rleDO3ORmPh3vUFQWiCgHqQB4AlCBG3G5QN5R7c6GueuG
        xOPhBPYisNPrruKaEpXTgz5plOnvb4fv4pjRy8wH7zIshMyq7nwvMt9e0HaggRbXifaL07d
        HYEn+Pok6i0Sunwp2lLlVTtPx5ro6+e/dmXin8YdG1h0hEGY5r3xP7pZPGtZa/Q/zDjBhVw
        xXGud3iKA37NM1pfxb0KQKz+c0x8AQeEb+NR3lraZG07YTgsUQSCWisvCIPtsEmhqNGTsJk
        Zzli2dHSJZo8RJG/RqpNSFA6OFBrxGdv+ZoTscN
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pcmcia: fix repeated words in comments
Date:   Tue, 30 Aug 2022 23:16:48 +0800
Message-Id: <20220830151648.10335-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'really'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/pcmcia/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index ace133b9f7d4..05d18614f6b4 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1304,7 +1304,7 @@ static int pcmcia_bus_early_resume(struct pcmcia_socket *skt)
  * physically present, even if the call to this function returns
  * non-NULL. Furthermore, the device driver most likely is unbound
  * almost immediately, so the timeframe where pcmcia_dev_present
- * returns NULL is probably really really small.
+ * returns NULL is probably really small.
  */
 struct pcmcia_device *pcmcia_dev_present(struct pcmcia_device *_p_dev)
 {
-- 
2.36.1

