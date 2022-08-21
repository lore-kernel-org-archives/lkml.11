Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985ADC3F6B0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 15:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiHUPUo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUPUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:20:42 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D515915718;
        Sun, 21 Aug 2022 08:20:39 -0700 (PDT)
X-QQ-mid: bizesmtp67t1661095216tvo9v95l
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:20:15 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: QityeSR92A2caRpFjRcMmJVpE6RNh8LppFJhz+NlGpISUIgyuKE9MlW48Y77S
        FpF3nN0qCYalUfZOvbdB64Uc+JCNYeh98vZoQCuXtBQadi4sgXctPpwXj0iCz0EoC6F7eHv
        ZpPhLXspY/ekcdLBqugMNIU5ZqIVGy7rzM3v9QhfYw0ges+D+pjolCmtopWdLRE4J7yuw20
        FsiYDoiB3FwJkapXytQGqikvsTv7xCGqWDq8YgXP0OwcYFxVFw/ModF/aEBx5xV0u7Tc9s1
        ti3M9x5cpAUb5KxUJLp5Za/XRwPhywdzxMjia8SkfsVgvGgTZkqi3mU1L5I2SFrRihjekL8
        /uWleCKKH/vhazVay+ymrMlQbVh2NVZa3G0ze7xUt03C+nCmvF6bAizUjyWRg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] gadget/udc: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:20:09 +0800
Message-Id: <20220821152009.61380-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'tell'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index c593fc383481..176e2b157021 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1737,7 +1737,7 @@ static void handle_ep0 (struct pxa25x_udc *dev)
 				/* hardware automagic preventing STALL... */
 				if (dev->req_config) {
 					/* hardware sometimes neglects to tell
-					 * tell us about config change events,
+					 * us about config change events,
 					 * so later ones may fail...
 					 */
 					WARNING("config change %02x fail %d?\n",
-- 
2.36.1

