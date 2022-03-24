Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 01:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbiCXCBF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 22:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiCXCBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:01:03 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A73B90FDB;
        Wed, 23 Mar 2022 18:59:31 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 24 Mar
 2022 09:59:30 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 24 Mar
 2022 09:59:29 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <rth@twiddle.net>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <ebiederm@xmission.com>
CC:     <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] alpha: Fix warning comparing pointer to 0
Date:   Thu, 24 Mar 2022 09:59:27 +0800
Message-ID: <1648087167-27982-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/alpha/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index ec20c10..47e5c68 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -190,7 +190,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 
  no_context:
 	/* Are we prepared to handle this fault as an exception?  */
-	if ((fixup = search_exception_tables(regs->pc)) != 0) {
+	if ((fixup = search_exception_tables(regs->pc)) != NULL) {
 		unsigned long newpc;
 		newpc = fixup_exception(dpf_reg, fixup, regs->pc);
 		regs->pc = newpc;
-- 
2.7.4

