Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B91C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 00:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbiDAAQj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 20:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAAQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:16:37 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51A1E3FD;
        Thu, 31 Mar 2022 17:14:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V8krukA_1648772084;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V8krukA_1648772084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Apr 2022 08:14:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, dave.hansen@linux.intel.com, pbonzini@redhat.com,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] KVM: x86/xen: Remove duplicated include in xen.c
Date:   Fri,  1 Apr 2022 08:14:42 +0800
Message-Id: <20220401001442.100637-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./arch/x86/kvm/xen.c: lapic.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/kvm/xen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 7e7c8a5bff52..6e408cabd077 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -10,7 +10,6 @@
 #include "xen.h"
 #include "lapic.h"
 #include "hyperv.h"
-#include "lapic.h"
 
 #include <linux/eventfd.h>
 #include <linux/kvm_host.h>
-- 
2.20.1.7.g153144c

