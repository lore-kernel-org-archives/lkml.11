Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F3C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353947AbiFUQSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353878AbiFUQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:18:09 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D89FDA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:18:04 -0700 (PDT)
X-QQ-mid: bizesmtp74t1655828214t9neerf2
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 00:16:50 +0800 (CST)
X-QQ-SSF: 0100000000700090B000B00A0000000
X-QQ-FEAT: 1XNERxhHvDkK0AjWHJ0zwtOvkZn08vYWoynNbeKVcDoXEOYLDXIw68BY0qvR7
        iWxyLpBDEWJCWm6cOD3B0FwpI+Tob74qjnN0Xthf06O2IDbErXzUXYfPhsP6Fppbrruytzc
        LgggSu434PVk3LdmKhIXYTAJd+3rMh1LvMp9CqnhjZE2Mq379UjL3lz6Y7lHFbBGf9cUFMz
        erOs1aMO1vrIt9v0tmLTwVq9LPFEwkqCrynIy7sBwZlA4yzLk36Up1ILCUCqrBKSHQ7PFgw
        BrsPAXILKZacNND1UY5ohWkK5Ge9puR0XVQuBqlErBr5DFtixmyouc7eo+kFAJ6JbkeFRhf
        Xyr4Hzy
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] optee: Remove duplicate 'of' in two places.
Date:   Wed, 22 Jun 2022 00:16:48 +0800
Message-Id: <20220621161648.20117-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: ./drivers/tee/optee/optee_smc.h
line: 192
 * a2   Size of of SHM
chanegd to
 * a2   Size of SHM

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/tee/optee/optee_smc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index c60896cf71cb..73b5e7760d10 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -189,7 +189,7 @@ struct optee_smc_call_get_os_revision_result {
  * Have config return register usage:
  * a0	OPTEE_SMC_RETURN_OK
  * a1	Physical address of start of SHM
- * a2	Size of of SHM
+ * a2	Size of SHM
  * a3	Cache settings of memory, as defined by the
  *	OPTEE_SMC_SHM_* values above
  * a4-7	Preserved
-- 
2.17.1

