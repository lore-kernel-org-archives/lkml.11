Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E3FC54EE9
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 16:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiIBQRt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiIBQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:17:16 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BAD32CC9B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TEjnZ
        6xt2wlLT8EUIt9/RhmVBAzoRToS1Rn3ukjQe90=; b=XmYAQSNxPRIwo3y9TMEkh
        7YS3HEqS7+NAUd5590uGeDowzqSWwRtCbgR5mFyUfUF+zIpVBopglFQ0fcwswmhm
        LtSW5avMuxtUTXmUb2OgaXkzp7PBpoKHQFfQJaRtyI998rSanVyOXN37BX8UkBO5
        2vthxVp47ByIo1ZBD8XfQg=
Received: from ubuntu.localdomain (unknown [183.159.78.175])
        by smtp7 (Coremail) with SMTP id C8CowAA3sgwdKBJj3tXsCw--.41444S4;
        Fri, 02 Sep 2022 23:58:22 +0800 (CST)
From:   Li Qiang <liq3ea@163.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, liq3ea@gmail.com,
        Li Qiang <liq3ea@163.com>
Subject: [PATCH] kprobe: reverse kp->flags when arm_kprobe failed
Date:   Fri,  2 Sep 2022 08:58:20 -0700
Message-Id: <20220902155820.34755-1-liq3ea@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAA3sgwdKBJj3tXsCw--.41444S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF17KF4UWrWkWF4UtFyUtrb_yoW3ZFX_Aa
        4vqrZ09r4YyFsxZr4YyrW5urs2grsa9FWfCFy0qFW5Ka17GrnIgan5uFy5Aa4Fga4DXF9x
        Arn8Zrs0vFyYqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRA0eQ3UUUUU==
X-Originating-IP: [183.159.78.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In aggregate kprobe case, when arm_kprobe failed,
we need set the kp->flags with KPROBE_FLAG_DISABLED again.
If not, the 'kp' kprobe will been considered as enabled
but it actually not enabled.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 kernel/kprobes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 08350e35a..333454df5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2424,8 +2424,11 @@ int enable_kprobe(struct kprobe *kp)
 	if (!kprobes_all_disarmed && kprobe_disabled(p)) {
 		p->flags &= ~KPROBE_FLAG_DISABLED;
 		ret = arm_kprobe(p);
-		if (ret)
+		if (ret) {
 			p->flags |= KPROBE_FLAG_DISABLED;
+			if (p != kp)
+				kp->flags |= KPROBE_FLAG_DISABLED;
+		}
 	}
 out:
 	mutex_unlock(&kprobe_mutex);
-- 
2.25.1

