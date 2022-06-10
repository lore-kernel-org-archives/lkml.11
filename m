Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F45C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 07:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiFJHHG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 03:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbiFJHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:07:03 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEB320C0E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:06:54 -0700 (PDT)
X-QQ-mid: bizesmtp71t1654844757tvi1xobk
Received: from localhost.localdomain ( [117.176.187.14])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 10 Jun 2022 15:05:49 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: Z5wRfCDkVUWi7rEBLCx2CkN/qfZyrYzj+bjF/O0RhcP5BkxiHKDP4TXzLT7Vs
        1fRJ9JpHnoUmkp+FvyM96QapXtM+jJHvzJfVF1VHgAz2tE2T4f+Dzz+jy0EfN2aG26bu6dv
        qcfUOMNYa3cknyHQDzFsC0QP9fqY+CrDx1j0Dk1lQd2ckVvk934U5ndINpDoQOjX83nX0XZ
        DQS1BdY4dYzvhAhTOnZUngYAAcybHgawyCVdLcOBjRTBxhAyfyGVFRzR90TLDIgEWt4Dgng
        1Tx5xKVuIT++eNYjVzValTRnveOE+PREjJU1pJc904RH2oh1lFvx7gjFQmD9k2pUbLD/a9e
        HcD7CF4
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     will@kernel.org
Cc:     catalin.marinas@arm.com, geert+renesas@glider.be,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] arm64/fpsimd:  Fix typo in comment
Date:   Fri, 10 Jun 2022 15:05:43 +0800
Message-Id: <20220610070543.59338-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 819979398127..f1d476fa50a9 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -331,7 +331,7 @@ void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
  *    trapping to the kernel.
  *
  *    When stored, Z0-Z31 (incorporating Vn in bits[127:0] or the
- *    corresponding Zn), P0-P15 and FFR are encoded in in
+ *    corresponding Zn), P0-P15 and FFR are encoded in
  *    task->thread.sve_state, formatted appropriately for vector
  *    length task->thread.sve_vl or, if SVCR.SM is set,
  *    task->thread.sme_vl.
-- 
2.36.1

