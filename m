Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 03:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbiDAD2v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 23:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiDAD2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:28:48 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79C2224767
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:26:57 -0700 (PDT)
X-UUID: 438f6c0acb9049eeaaae242dc69b407f-20220401
X-UUID: 438f6c0acb9049eeaaae242dc69b407f-20220401
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 936776392; Fri, 01 Apr 2022 11:25:55 +0800
X-ns-mid: postfix-624670F9-8008223520
Received: from localhost.localdomain (unknown [172.30.60.63])
        by cs2c.com.cn (NSMail) with ESMTPSA id BC6DC384867B;
        Fri,  1 Apr 2022 03:26:49 +0000 (UTC)
From:   Enze Li <lienze@kylinos.cn>
To:     phil@philpotter.co.uk, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] cdrom: remove unused variable
Date:   Fri,  1 Apr 2022 11:26:23 +0800
Message-Id: <20220401032623.293666-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang static analyzer reports the following warning,

File: drivers/cdrom/cdrom.c
Warning: line 1380, column 7
	 Although the value stored to 'status' is used in enclosing
	 expression, the value is never actually read from 'status'

Remove the unused variable to eliminate the warning.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 drivers/cdrom/cdrom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 7bd10d63ddbe..2dc9da683a13 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1365,7 +1365,6 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
  */
 int cdrom_number_of_slots(struct cdrom_device_info *cdi) 
 {
-	int status;
 	int nslots = 1;
 	struct cdrom_changer_info *info;
 
@@ -1377,7 +1376,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	if (!info)
 		return -ENOMEM;
 
-	if ((status = cdrom_read_mech_status(cdi, info)) == 0)
+	if (cdrom_read_mech_status(cdi, info) == 0)
 		nslots = info->hdr.nslots;
 
 	kfree(info);
-- 
2.25.1

