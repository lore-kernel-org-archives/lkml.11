Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98170C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 18:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbiEOSHL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiEOSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 14:07:09 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3627FDE
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 11:07:07 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id qIdznd1gjdIhAqIdzn03U9; Sun, 15 May 2022 20:07:05 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 15 May 2022 20:07:05 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        akpm@osdl.org, ron.mercer@qlogic.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net/qla3xxx: Fix a test in ql_reset_work()
Date:   Sun, 15 May 2022 20:07:02 +0200
Message-Id: <80e73e33f390001d9c0140ffa9baddf6466a41a2.1652637337.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bit() tests if one bit is set or not.
Here the logic seems to check of bit QL_RESET_PER_SCSI (i.e. 4) OR bit
QL_RESET_START (i.e. 3) is set.

In fact, it checks if bit 7 (4 | 3 = 7) is set, that is to say
QL_ADAPTER_UP.

This looks harmless, because this bit is likely be set, and when the
ql_reset_work() delayed work is scheduled in ql3xxx_isr() (the only place
that schedule this work), QL_RESET_START or QL_RESET_PER_SCSI is set.

This has been spotted by smatch.

Fixes: 5a4faa873782 ("[PATCH] qla3xxx NIC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative and should certainly be tested by s.o. with the
needed hardware.

Maybe, the whole 'if (test_bit(...)' test should be removed because it is
always true. If it is really the case, this would save 1 level of
indentation.
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index b30589a135c2..70241faaa841 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3614,7 +3614,8 @@ static void ql_reset_work(struct work_struct *work)
 		qdev->mem_map_registers;
 	unsigned long hw_flags;
 
-	if (test_bit((QL_RESET_PER_SCSI | QL_RESET_START), &qdev->flags)) {
+	if (test_bit((QL_RESET_PER_SCSI), &qdev->flags) ||
+	    test_bit((QL_RESET_START), &qdev->flags)) {
 		clear_bit(QL_LINK_MASTER, &qdev->flags);
 
 		/*
-- 
2.34.1

