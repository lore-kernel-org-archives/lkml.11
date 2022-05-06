Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03FCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 10:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391044AbiEFKqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiEFKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:46:05 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CD0165402
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=I+BA0
        Fo8Tt53eRixUoHaMVecXiumQenJeYSFmr5u8eA=; b=Z5i3QmAWrjiK6GolasOGS
        eqwzgDDSpnhp7uSYthJ2hk+qoAzhk9zPJtXKRfwh0Es0k1BazNt3BvIzxhvhUeZU
        vQt0ZxeG++5gPPHhtjnUNKixgRFqSS/CKihpoz+EPbF90DZOoRbQ4luAegIemBEs
        3P+BhoFrFpWymJsKfsxybY=
Received: from localhost.localdomain (unknown [120.204.77.149])
        by smtp9 (Coremail) with SMTP id DcCowABnJuNN+3RiBRE6BQ--.2127S4;
        Fri, 06 May 2022 18:41:52 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        prudo@redhat.com
Cc:     akpm@linux-foundation.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, lizhe <sensor1010@163.com>
Subject: [PATCH v5] kernel/crash_core.c : remove redundant check of ck_cmdline
Date:   Fri,  6 May 2022 03:41:16 -0700
Message-Id: <20220506104116.259323-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABnJuNN+3RiBRE6BQ--.2127S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1kJry8Jr1fZr1xGw18AFb_yoWxCFg_Ww
        48Krn2qFyUAw1j9r1xZayfWrWYkr40va9a9a43trWava4DJr1rG34rtrn0yrnrA3s7Ar17
        Crs3J3ZrtrWYgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMc_T7UUUUU==
X-Originating-IP: [120.204.77.149]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiWBH4q1uHyRtwCgAAsu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of get_last_crashkernel(), the judgement of ck_cmdline is
obviously unnecessary and causes redundance, let's clean it up.

Signed-off-by: lizhe <sensor1010@163.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Philipp Rudo <prudo@redhat.com>
---
 kernel/crash_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 256cf6db573c..c232f01a2c54 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
 		p = strstr(p+1, name);
 	}
 
-	if (!ck_cmdline)
-		return NULL;
-
 	return ck_cmdline;
 }
 
-- 
2.25.1

