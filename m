Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD6EC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 14:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbiFOOXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347378AbiFOOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:23:06 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 033F51C904
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=K8J33
        8CcV+Vs6sGN9NqJ7u8qxxibdbG33N46mOqZXQU=; b=AWta8vvARSpdQWXEYRFrn
        7h0LeAVZFoLZnNlHYDMpFdTfKSFPNV9kmgtDVPXnugMBrTStzLX0r8xJZQi3nZy7
        k+teNLUiwDVW+/8Nq/KXsXiIFfNQjjB8mSH/IEg8cyCIUW52JuhEdt5b0yVp9dYb
        VRXL9Z6S3WnfxS0ehHfffs=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowAB3t_b46qliAspwDQ--.46989S2;
        Wed, 15 Jun 2022 22:21:45 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     gregkh@linuxfoundation.org, geert+renesas@glider.be
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] drivers: staging: board: Add missing of_node_put() in board.c
Date:   Wed, 15 Jun 2022 22:21:44 +0800
Message-Id: <20220615142144.3968617-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowAB3t_b46qliAspwDQ--.46989S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4UJFyUGr1UXw1kZw17Awb_yoWxtrg_KF
        1Iqr97Jryqkr1xt3sxAr13XryIvF4xWF4kX3Wxtw4fGF48AF4fGa4qqr9rJa4kGa12vFy7
        C3WkAw4Syr43XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_znQ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgohF1-HZTceNQAAsH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In board_staging_gic_setup_xlate(), of_find_compatible_node() return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/staging/board/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index f980af037345..408448c202a2 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -67,6 +67,8 @@ int __init board_staging_gic_setup_xlate(const char *gic_match,
 	if (!irqc_node)
 		return -ENOENT;
 
+	of_node_put(irqc_node);
+
 	irqc_base = base;
 	return 0;
 }
-- 
2.25.1

