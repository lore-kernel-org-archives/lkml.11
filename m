Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35103C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 06:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbiBUGxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 01:53:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbiBUGxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:53:47 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC281A80F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:53:16 -0800 (PST)
X-QQ-mid: bizesmtp91t1645426383tlv9vqzu
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 21 Feb 2022 14:52:57 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: F3yR32iATbjj7oknWwocQWvrWJQ/++TZLjZjZrro89gwslj3b4bSD2HEVPWWv
        efJExNfnMljAiMtMREEOpI9DVbZ8Q4NiyZh5eWOkhPQpqx307loPGTrudGkFEPdUC8xYVXC
        o4BPRc7dc6DiZfleNRUWtRqn4uqXL4XSeJWNqWKPNsVvhxyZU3IRLj8MAbFintEyWLus7Bw
        ZqzSopZlXHnW7ciRrmK5IXOJI/ck6sJTgnm02X8T8VP48abCs5ivrFuklBwRJpTckRoJsVN
        BvA2JnNRRP19zUglCjgizWuAx3Xwi7OwUdx7yUNu521nCt05a6hk79DCRDu7JHlHF2QT5Tn
        X4POTvDxzIK2BwgTiwyssqd/7xIVtw57DRwKm5hnNaIEtA6rfM=
X-QQ-GoodBg: 1
From:   tangmeng <tangmeng@uniontech.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] mm/damon: remove unnecessary CONFIG_DAMON option
Date:   Mon, 21 Feb 2022 14:52:55 +0800
Message-Id: <20220221065255.19991-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mm/Makefile has:
obj-$(CONFIG_DAMON) += damon/

So that we don't need 'obj-$(CONFIG_DAMON) :=' in mm/damon/Makefile,
delete it from mm/demon/Makefile.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 mm/damon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 03931472991a..aebbf6c14c51 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_DAMON)		:= core.o
+obj-y				:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
-- 
2.20.1



