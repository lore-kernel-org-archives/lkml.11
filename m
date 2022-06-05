Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B19C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 12:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbiFEMuQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344005AbiFEMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 08:50:13 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063822B0F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 05:50:06 -0700 (PDT)
X-QQ-mid: bizesmtp80t1654433370trs5hc9h
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 20:49:14 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: aFXyU9/pqzUX0s9LwDXewuLPL3/MKozWclvzhiuQPZBncSgGWjzRki6tk7SWy
        exycqhqI8wG3KtzV/eEA1zqpSUqK6kP8cTlABWsIfLGhGg6rDFB6VcGdKir3liTdldGgqRH
        YAnsN3gW6cVF91Eg0H8LObTfvF00OQHjwCYjbV2V9u7D0tVjFE+CZUM93n+UEk/q0MG4UV7
        B29prfH2jaHY1eS3tDNqXpTI7CRqKL/ZFCX70DuHzDF24DkxufOUVU+6D4r1PTwl9SQoDqL
        TGK51+pM61Wv0uq6csY/HlEdUAw2pPlzYEwmSL3C08m4rv3Al8vxfEH6r9dUT4ZDgw8l1N7
        Okkebijxe/E70iVuT0=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     dhowells@redhat.com
Cc:     marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] afs: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 20:49:12 +0800
Message-Id: <20220605124912.14422-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'consider'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 fs/afs/rotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a840c3588ebb..9da8df27df7e 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -235,7 +235,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 			goto next_server;
 
 		case VMOVED:
-			/* The volume migrated to another server.  We consider
+			/* The volume migrated to another server.  We
 			 * consider all locks and callbacks broken and request
 			 * an update from the VLDB.
 			 *
-- 
2.36.1

