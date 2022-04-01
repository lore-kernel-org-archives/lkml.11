Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 03:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiDAD3l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 23:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiDAD3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:29:38 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C2B25EC8C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:27:49 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 1 Apr
 2022 11:27:49 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 1 Apr
 2022 11:27:46 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Corey Minyard <minyard@acm.org>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipmi: ssif: potential NULL dereference in msg_done_handler()
Date:   Fri, 1 Apr 2022 11:27:45 +0800
Message-ID: <1648783665-19237-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msg could be null without checking null and return, but still dereference
msg->rsp[2] and will lead to a null pointer trigger.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index f199cc1..9383de3 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -814,7 +814,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		break;
 
 	case SSIF_GETTING_EVENTS:
-		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
+		if ((result < 0) || (len < 3) || (msg && (msg->rsp[2] != 0))) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
 
-- 
2.7.4

