Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C00C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 09:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiFWJhY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 05:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiFWJhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:37:23 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CC2D4705E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:37:22 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E06C31E80D14;
        Thu, 23 Jun 2022 17:37:02 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CGLm8S3ZuZgU; Thu, 23 Jun 2022 17:37:00 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.33])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 01ED21E80C85;
        Thu, 23 Jun 2022 17:36:59 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] gfs2: Fix spelling mistake
Date:   Thu, 23 Jun 2022 17:37:16 +0800
Message-Id: <20220623093716.13338-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'accomodate' to 'accommodate'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 fs/gfs2/lock_dlm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 2559a79cf14b..6ce369b096d4 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1058,7 +1058,7 @@ static int control_first_done(struct gfs2_sbd *sdp)
 
 /*
  * Expand static jid arrays if necessary (by increments of RECOVER_SIZE_INC)
- * to accomodate the largest slot number.  (NB dlm slot numbers start at 1,
+ * to accommodate the largest slot number.  (NB dlm slot numbers start at 1,
  * gfs2 jids start at 0, so jid = slot - 1)
  */
 
-- 
2.25.1

