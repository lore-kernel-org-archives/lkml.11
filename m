Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B302EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 12:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiFQMop (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:44:43 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25C472A240
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2fJZ2
        0a6VvhGRdgHv4scyCqtsTzEA9f9VqrQ80NiF8M=; b=nw3fyBBebzHI46Cw6FFa/
        f4OTZFxBJqPxPtarYgmG6lQSYx+JAVslGA+oHQFVXYWaSqrTzN1qUDWONUwSzeC1
        MOJs8yKPKzlNQV7jYYDoOlSXqyJBfgDNeklyGhn885ucJcZCmlyD1+mOrmJttiqE
        eFBE4kI4lP517IgVAsxoR0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowAAH0DAwd6xi83EpEw--.31664S2;
        Fri, 17 Jun 2022 20:44:32 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com
Cc:     windhl@126.com, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: kernel: Fix refcount leak bug in time.c
Date:   Fri, 17 Jun 2022 20:44:32 +0800
Message-Id: <20220617124432.4049006-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowAAH0DAwd6xi83EpEw--.31664S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKryfGry8Krg_yoW3GFb_G3
        Z7X34kCF4Yvws0vr9F9a1fWF1jv3sruF48Jw1vvF4xGw4UXr15Gw1DJr4Ykw15uFWrKrW7
        AFZ5JrnIyF9rujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUsYFtUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hEjF1uwMOUZZgAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In calibrate_ccount(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/xtensa/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index e8ceb1528608..16b8a6273772 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -154,6 +154,7 @@ static void __init calibrate_ccount(void)
 	cpu = of_find_compatible_node(NULL, NULL, "cdns,xtensa-cpu");
 	if (cpu) {
 		clk = of_clk_get(cpu, 0);
+		of_node_put(cpu);
 		if (!IS_ERR(clk)) {
 			ccount_freq = clk_get_rate(clk);
 			return;
-- 
2.25.1

