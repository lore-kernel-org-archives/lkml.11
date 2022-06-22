Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5EFC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 16:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376302AbiFVQGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359412AbiFVQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:05:45 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13771340F8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:05:23 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655913918tvmgs68c
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 00:05:12 +0800 (CST)
X-QQ-SSF: 01000000000000B0C000000A0000000
X-QQ-FEAT: HNxLNQvIe76+hcMYMvaXk26UGWx+SAJB64xM5wT4wR8jPje9QKZ0664emjZNu
        d60Whm576CtGRC0d5FsMSwwxsgPt0wKfEq3Vq9R6pJ906zshVI/+AUzFHQlm7ycW5vM0iXV
        8w7NhWW2h+q28Am6kY8aNtjs4kOUjGiAb6smZzjb1jWtfH9L1fctAsrG9udlVW40ObczWbE
        kUHMllYtephnWoLf6s+88VhLygcP8CtzKry6+j0pn8nkNlNpK5vE8mOXqSbs0oZ5PbUpqVo
        2Oimr10CwYdAO3Qhx80fUQOnwDbUgYqtncWBHRWBrRyr8zbIgrwABIYS0=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] mtd: rawnand: sm_common: drop unexpected word 'is' in the comments
Date:   Thu, 23 Jun 2022 00:05:11 +0800
Message-Id: <20220622160511.11679-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'is' in the comments that need to be dropped

file: drivers/mtd/nand/raw/sm_common.c
line: 55

/* NOTE: This layout is is not compatabable with SmartMedia, */

changed to:

/* NOTE: This layout is not compatabable with SmartMedia, */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mtd/nand/raw/sm_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index ba24cb36d0b9..b2b42dd1a2de 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -52,7 +52,7 @@ static const struct mtd_ooblayout_ops oob_sm_ops = {
 	.free = oob_sm_ooblayout_free,
 };
 
-/* NOTE: This layout is is not compatabable with SmartMedia, */
+/* NOTE: This layout is not compatabable with SmartMedia, */
 /* because the 256 byte devices have page depenent oob layout */
 /* However it does preserve the bad block markers */
 /* If you use smftl, it will bypass this and work correctly */
-- 
2.17.1

