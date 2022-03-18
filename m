Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8CBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiCRKjG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiCRKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:38:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18C2D8121;
        Fri, 18 Mar 2022 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3JVYTpZ2S+jPM8aku+6zMmH5pu/hPftoGDQ9F+um17w=;
  b=En+N9Hx9lTWX+XtGUc70HCD0z0A6SiL1rF7KDG3bHgmUzIW1Z9yDsYrH
   gxCJECVTQw6u4uiyXkJ4GewzRWchuv4FE1khmMtEiEzaVBuXj/9opALdK
   99nZ1QcJVYqeGL6lw9T6BbPKPxTqntmnL/KNPm9zeFwOLz2S1veWvG1Jk
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935628"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:35 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Brian Cain <bcain@codeaurora.org>
Cc:     kernel-janitors@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Hexagon: fix typos in comments
Date:   Fri, 18 Mar 2022 11:36:57 +0100
Message-Id: <20220318103729.157574-2-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/hexagon/kernel/module.c |    2 +-
 arch/hexagon/mm/vm_tlb.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/module.c b/arch/hexagon/kernel/module.c
index cb3bf19b0640..62ab39027360 100644
--- a/arch/hexagon/kernel/module.c
+++ b/arch/hexagon/kernel/module.c
@@ -43,7 +43,7 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			found = i+1;
 	}
 
-	/* At this time, we don't support modules comiled with -shared */
+	/* At this time, we don't support modules compiled with -shared */
 	if (found) {
 		printk(KERN_WARNING
 			"Module '%s' contains unexpected .plt/.got sections.\n",
diff --git a/arch/hexagon/mm/vm_tlb.c b/arch/hexagon/mm/vm_tlb.c
index 53482f2a9ff9..5b6673353120 100644
--- a/arch/hexagon/mm/vm_tlb.c
+++ b/arch/hexagon/mm/vm_tlb.c
@@ -46,7 +46,7 @@ void flush_tlb_one(unsigned long vaddr)
  */
 void tlb_flush_all(void)
 {
-	/*  should probably use that fixaddr end or whateve label  */
+	/*  should probably use that fixaddr end or whatever label  */
 	__vmclrmap(0, 0xffff0000);
 }
 

