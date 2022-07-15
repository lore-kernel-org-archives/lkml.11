Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E208FC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 13:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiGRNpE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiGRNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:45:02 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC81B7A9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:44:56 -0700 (PDT)
X-QQ-mid: bizesmtp78t1658151862t9dksbz6
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:44:20 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: r/cTxDoDoiEZ/G1/U5cU0y7O5MUHcs2LuTI3rLif/Bz9p+J6ShcQ4p22QeLWx
        vBP+kG8gouBG1SdX1rQbF4roAPBzqZ+QcH26WsRBFztM8/apUntOm8PZgRNW2irIwSUNgY1
        2PFKGjhucs5RALQqyp0PTCajdrSsjJ0SW3NYBlfS2ApwB0K2miRZkW5tzH2DLcwd5l+/w3j
        RxGc/Gp9H81a9WxVxFYoDZBpRGPd+0PuxGus486XaHVPvz5NS+3lgTX3+ynGcfbntUEaVRw
        EyQzd9MVnu/aWBiI+fMha1lDSK/O2qEurONwbd7j11V+/LgxdlntfOkOC1KeonHXPDLbAof
        Ry41rUNVS/8XIYfgcqspCmcZRu2cFXL13ttEbA+5iNbr6oJxVfGNQZnWmCtTzGBapZDyxng
        LJdARLBXg7Y=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     geoff@infradead.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] powerpc/ps3: Fix comment typo
Date:   Fri, 15 Jul 2022 13:42:24 +0800
Message-Id: <20220715054224.6583-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `when' is duplicated in line 1069, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/ps3/ps3-lpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index 65512b6cc6fd..200ad8751860 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -1066,7 +1066,7 @@ EXPORT_SYMBOL_GPL(ps3_disable_pm_interrupts);
  *  instance, specified by one of enum ps3_lpm_tb_type.
  * @tb_cache: Optional user supplied buffer to use as the trace buffer cache.
  *  If NULL, the driver will allocate and manage an internal buffer.
- *  Unused when when @tb_type is PS3_LPM_TB_TYPE_NONE.
+ *  Unused when @tb_type is PS3_LPM_TB_TYPE_NONE.
  * @tb_cache_size: The size in bytes of the user supplied @tb_cache buffer.
  *  Unused when @tb_cache is NULL or @tb_type is PS3_LPM_TB_TYPE_NONE.
  */
-- 
2.35.1

