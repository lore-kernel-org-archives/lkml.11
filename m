Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C017C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 15:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiGHPix (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiGHPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:38:52 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4D2DD4;
        Fri,  8 Jul 2022 08:38:46 -0700 (PDT)
X-QQ-mid: bizesmtp91t1657294703tdv0nwre
Received: from localhost.localdomain ( [182.148.15.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 08 Jul 2022 23:38:16 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: PYFsjleCe+BqPiWpYzOtOXKK3fAjeSTKObevPu5Uz7VO1wgNSj7NEczaiUiqy
        alryCR9NYUzPKfWqv+kodb6vEp12i/gZ7eTmZ6urJAXkLe3FWeqPk7Ky14QmLHHDImuY0gX
        cDmeay/9k1vdad/fhDSH3AEkqUhIDJZf/Fb8EScsnX1Io2rGGkcNZHXVFPVjv5d3/vTVFRD
        fTUj631MADJBXgXj2l9yAXwrq7qSxle017UG53u4qqkhOzZgSdvPpXnhl0jD5m/h3yTpLRq
        CcTwowZj2Eyzb1Ltqum+lGMvzVyxfQjNnik5cxzM0P/AbcrfqtGOyYxrNaQ5dlwbqp0Fs8X
        FrbsO411Rx1eNhMaIFC7/4GuswMu07waUGx1AMEEjrVbKg8GYkYEV/IutvekQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     kevin.curtis@farsite.co.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] net/wan: fix repeated words in comments
Date:   Fri,  8 Jul 2022 23:38:10 +0800
Message-Id: <20220708153810.8387-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/wan/farsync.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/farsync.h b/drivers/net/wan/farsync.h
index 5f43568a9715..f904a824b366 100644
--- a/drivers/net/wan/farsync.h
+++ b/drivers/net/wan/farsync.h
@@ -44,7 +44,7 @@
  *      package and is a simplified number for normal user reference.
  *      Individual files are tracked by the version control system and may
  *      have individual versions (or IDs) that move much faster than the
- *      the release version as individual updates are tracked.
+ *      release version as individual updates are tracked.
  */
 #define FST_USER_VERSION        "1.04"
 
-- 
2.36.1

