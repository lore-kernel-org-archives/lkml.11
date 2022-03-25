Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 02:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358491AbiCYDAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 23:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358663AbiCYC7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:59:40 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E3261B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:58:02 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 25 Mar
 2022 10:57:55 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 25 Mar
 2022 10:57:54 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <haren@us.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH V2] lib: 842: Fix pointer dereferenced before checking
Date:   Fri, 25 Mar 2022 10:57:53 +0800
Message-ID: <1648177073-20298-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer t is dereferencing comp_ops[c] before c is being
 bound checked. Fix this by assigning comp_ops[c] to t only if
c is safy, otherwise just NULL.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: fix two places that dereferenced before checking
 lib/842/842_compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4..0b47e8b 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -222,7 +222,7 @@ static int add_bits(struct sw842_param *p, u64 d, u8 n)
 static int add_template(struct sw842_param *p, u8 c)
 {
 	int ret, i, b = 0;
-	u8 *t = comp_ops[c];
+	u8 *t = c < OPS_MAX ? comp_ops[c] : NULL;
 	bool inv = false;
 
 	if (c >= OPS_MAX)
@@ -379,7 +379,7 @@ static int add_end_template(struct sw842_param *p)
 
 static bool check_template(struct sw842_param *p, u8 c)
 {
-	u8 *t = comp_ops[c];
+	u8 *t = c < OPS_MAX ? comp_ops[c] : NULL;
 	int i, match, b = 0;
 
 	if (c >= OPS_MAX)
-- 
2.7.4

