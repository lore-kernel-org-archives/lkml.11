Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB067C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 06:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348831AbiDSGdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348816AbiDSGdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:33:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE6140C8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:30:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 203so4073454pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tiP99sT3eivRImBxBttVns7fKVfvM+7VWk7Xkm8d/Rw=;
        b=ZtVX+m95lQjHGrRnXQfh090rMU59ANuqm5nT8eHMhvP5vPSXSbetkMeaLlOwMfuvSb
         1h3NdUR2wz4bi+XK8fKtWebbsnKQ9cR6C6qAQe2Gnz1liqYppMm7LGcGx4EVlObf900A
         cjrscspd5NR2l+qKtzBpRN2rpCwFYg61eT13M2kT3FfXCOpXjfPqJW3SEwevoxXVGMTw
         4zQ1hzvN6z0gr2toNKr5xItR2ENhpP/f76rvUu1bY6J7uVFVypnONBQO0wWSbJhjsQU/
         gY2vawpihsCXJCd/5R7a+qj1TPMLloTK5lDxKs7JCdA2e2CzNqAuCoyTIB7ZHWR/GyIk
         IipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tiP99sT3eivRImBxBttVns7fKVfvM+7VWk7Xkm8d/Rw=;
        b=fnN8ipEkVOo9YM20e3pyAZUuA9AU10YvvxjK2bvSe6Zk1C7QaAn87XW2BHp2QnDF4G
         qENW+y9BqqbqRXtHzNCpa+eOwRHYuQkBcs2Wi5pGVao6JFexnBFdsIeUsMIkQaTcJCN0
         aipQ5DhesaCMowof8f/EYhA3A1qbH7+BoMuzjJPfFDEwU2Ax8GIPWMua+pHJnTB9us+A
         2MbkJRxATwEXGGjL4noApYMm1ol0dgnczNk2DVbep9IY3HB7i0Tnejlj3TP/LT2hjciP
         9+gI9dXD5BG2JZcCBB3tgLebtKnR2MslMHqXQFYm3735YM6eixRBawGU2xo9rmc1aXFV
         RK6g==
X-Gm-Message-State: AOAM531AZa1wZlfzAzVUlWOYhLw7cZWCdWydTu4ucQiKawJ3ycpy1RX5
        PUQJpZHaSoODFLt8xnh5Bi0=
X-Google-Smtp-Source: ABdhPJyWzz4Dxl+xfPD7iNOmYT2csQOBC7cpLRA8Y4pexR9L+P/XSr3JUJtQ4t8tU26HYRlucWuEIA==
X-Received: by 2002:a63:ff4b:0:b0:3aa:3083:5131 with SMTP id s11-20020a63ff4b000000b003aa30835131mr2263943pgk.148.1650349824058;
        Mon, 18 Apr 2022 23:30:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:288:7001:2708:69a5:4ce1:831d:b544])
        by smtp.gmail.com with ESMTPSA id bu7-20020a056a00410700b0050a4ccc6138sm11428188pfb.139.2022.04.18.23.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 23:30:23 -0700 (PDT)
From:   Jui-Tse Huang <juitse.huang@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH] scheduler/pelt: fix comment typo
Date:   Tue, 19 Apr 2022 14:30:05 +0800
Message-Id: <20220419063005.15098-1-juitse.huang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A typo in the comment of the function __update_load_avg_blocked_se() is
fixed.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
---
 kernel/sched/pelt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 0f310768260c..ec918a57bc3f 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -283,7 +283,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *   load_sum := runnable
  *   load_avg = se_weight(se) * load_sum
  *
- * cfq_rq:
+ * cfs_rq:
  *
  *   runnable_sum = \Sum se->avg.runnable_sum
  *   runnable_avg = \Sum se->avg.runnable_avg
-- 
2.25.1

