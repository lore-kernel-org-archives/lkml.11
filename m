Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FFFC32772
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 15:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiHUPGU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiHUPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:06:18 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54E22520;
        Sun, 21 Aug 2022 08:06:15 -0700 (PDT)
X-QQ-mid: bizesmtp66t1661094372t953kfsl
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:06:10 +0800 (CST)
X-QQ-SSF: 0100000000200010B000B00A0000000
X-QQ-FEAT: rtp58PZ8kKibsJ2r1Mtoatw0Jl9p7QjFauFONfhGKZcUfOjFhOVMTyVaXyaM8
        dGuh+WyTNK//zM0KdGZvaQrDumoouUGhf01nYK9XXNo/5GzUhq/B5kvWIJCJOxGthkbhWTY
        08VFm4fYrcaPcaAq1sHyR1bULM+4+ZyffCS5vXOiD6ueVg7jpqG+4K2wZOvFbSXjIpb1bCq
        d+zZwqJ1B8KkVTW8MxR1PwY1+deNsGZzDQE25xmPonNLUimjpBBnWkfdsWchocjejEjrw3u
        UUYMm1GAppSGrHZv73GA7WQQ4HRe7q8yNPI1sMDd/aYLCB+CYzO3DA69j8wABPrh8QDv7fB
        RTzyuLEKLK5I3g4uGnS1JUyeqa5w96O8LNNcaJi
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mips/sgi-ip22: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:06:04 +0800
Message-Id: <20220821150604.52687-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/parisc/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 7df140545b22..78c354af2820 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -16,7 +16,7 @@
  *      fail to reach their PLT stub if we only create one big stub array for
  *      all sections at the beginning of the core or init section.
  *      Instead we now insert individual PLT stub entries directly in front of
- *      of the code sections where the stubs are actually called.
+ *      the code sections where the stubs are actually called.
  *      This reduces the distance between the PCREL location and the stub entry
  *      so that the relocations can be fulfilled.
  *      While calculating the final layout of the kernel module in memory, the
-- 
2.36.1

