Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B485C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 04:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiCMEdo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 23:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMEdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 23:33:42 -0500
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54537117C92
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 20:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dGqDy
        QgzdiFLcvH5r9tsctHC3rcl0R9x0Jzu2tfLUi4=; b=Ay3cT00V1gR4Bvew1GQU7
        9INDkJIkzw9Smz6pD2GEmSJp/1N4yNvukh8goE82sVrQ24bTx6AL5pFUqvaUJhFz
        G2s77YCq8J36gSdO48Z6zGHjdvcVwPIddJ1KYpY17+4TA4d3Q9UQPd2ZHxlGkO9M
        WLcF1iOXqQgVdR9GuHyFXg=
Received: from localhost.localdomain (unknown [120.204.79.168])
        by smtp11 (Coremail) with SMTP id D8CowAB3XHjPaC1ifqf0BA--.16206S4;
        Sun, 13 Mar 2022 11:46:02 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, sensor1010@163.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/dd.c : Remove the initial value of the global variable
Date:   Sat, 12 Mar 2022 19:45:16 -0800
Message-Id: <20220313034516.5729-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAB3XHjPaC1ifqf0BA--.16206S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWUZF45ur47Kw4UCFyrtFb_yoWxKFX_Ca
        nrWFZrXryYgr4kCF15Aw13Zr9Fga1fZr4vyw4ftrya9ay7J3W5K3WDuFy5Aw4rWr90qFZF
        yr4Yqr1Uur1DCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRN1v3DUUUUU==
X-Originating-IP: [120.204.79.168]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBohrCq1aEDBcAyQAAsR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variable driver_deferred_probe_enable has
a default value of false and does not need to be
initialized to false

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f47cab21430f..7fcd895d49be 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -152,7 +152,7 @@ void driver_deferred_probe_del(struct device *dev)
 	mutex_unlock(&deferred_probe_mutex);
 }
 
-static bool driver_deferred_probe_enable = false;
+static bool driver_deferred_probe_enable;
 /**
  * driver_deferred_probe_trigger() - Kick off re-probing deferred devices
  *
-- 
2.25.1

