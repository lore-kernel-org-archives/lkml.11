Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB4C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 09:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiFWJ7Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiFWJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:59:20 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24592496B5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:59:10 -0700 (PDT)
X-QQ-mid: bizesmtp91t1655978228tqb17klu
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 17:57:03 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: NTY7odTD9S9nCPdv+3vL0Gg+1KjSGIxoPdpjh7t49ebhhJ/8X5zrfgheFucMM
        YIKm4tFSbTqZx2eVWhTj5pKBB9tbWruizozlMjj7HvKiBSm5q1VcZF5bwqFQAsSt5EOO429
        Glhwp7jaTuxSg2Dr1DpxZPtZZsf89OsHuItivqv0cS3ZNSdjieE6IaZDv7NDYydofv+U1uV
        rq3MFsXquO05s4EpYxQ6uwj8+GxP9LM0+b6Yg2hEKEHY790ZELH2JrHorUkgclHVjqDfZi+
        Difawq9PrmCdYkVr8WOhq5Zs6MvGn4L+LfU3YvNB5diTwg0i8T9KHte/01zWYlYACt/vUrH
        J/kjEjdPxTxt4CGNuKZl9Idrkc0bbJE1ThoS/eo
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     ruscur@russell.cc, oohall@gmail.com, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] powerpc/eeh: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 17:57:01 +0800
Message-Id: <20220623095701.22931-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - arch/powerpc/kernel/eeh_driver.c
line - 753

* presence state. This might happen for for PCIe slots if the PE containing

changed to:

* presence state. This might happen for PCIe slots if the PE containing

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 260273e56431..f279295179bd 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -750,7 +750,7 @@ static void eeh_pe_cleanup(struct eeh_pe *pe)
  * @pdev: pci_dev to check
  *
  * This function may return a false positive if we can't determine the slot's
- * presence state. This might happen for for PCIe slots if the PE containing
+ * presence state. This might happen for PCIe slots if the PE containing
  * the upstream bridge is also frozen, or the bridge is part of the same PE
  * as the device.
  *
-- 
2.17.1

