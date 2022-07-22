Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9E5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiGVKl0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGVKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:41:24 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D18B5BA4E6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zBI/F
        Vaj1yrIpwNManpllG4IsLnfSeZv4qel3vo4+8g=; b=cZ+S26KBh5JPui0Fj4Kl9
        +4zQB7ZatRVhii0foVArNgML0UujabraLOVW6ovUIDkbmTSJJjSNIMUjLxWM/ahq
        0LhaXKTn3GhE55YJoRrxUketnek/1RS3TI/S3vqujydHyL8vB66EmPhIrSuAvLRn
        svCfIeaOgsOUiYxjVtS2s8=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp4 (Coremail) with SMTP id HNxpCgC3Couvftpi0d6IQA--.23304S2;
        Fri, 22 Jul 2022 18:40:49 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     amitk@kernel.org, rui.zhang@intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] tools: thermal: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:40:47 +0800
Message-Id: <20220722104047.83312-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgC3Couvftpi0d6IQA--.23304S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFykKF4xZw4DZw1xKw4UArb_yoW3JrX_Jw
        17Jw4xZw1kArWvyrn7Ja43ZryrtanxuF4Yyr17GryDJa4jk3ZrXFykArs8GryYgrsrZ347
        JF4kJry5Xr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtVbyUUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDRFGZFaEKByF1QAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 tools/thermal/tmon/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
index 296f69c00c57..da20088285bd 100644
--- a/tools/thermal/tmon/pid.c
+++ b/tools/thermal/tmon/pid.c
@@ -27,7 +27,7 @@
 
 /**************************************************************************
  * PID (Proportional-Integral-Derivative) controller is commonly used in
- * linear control system, consider the the process.
+ * linear control system, consider the process.
  * G(s) = U(s)/E(s)
  * kp = proportional gain
  * ki = integral gain
-- 
2.25.1

