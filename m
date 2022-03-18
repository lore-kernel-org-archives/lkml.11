Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiCRKkB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D82DA6A6;
        Fri, 18 Mar 2022 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/k7i9EcEOpe/CsOaDnDywuABwzScPZz0NXGzOia6jy4=;
  b=M+tXTGUfGHCa29DjrzMa9meGkXuSzx+FxuJIuOdwSiKjc+lqVWnqeFhS
   DQ3aXSXx7adxpfOMUxirub5iqVkY7uRuFCMWKly56NjraSSJVO2JHv0B3
   7W9ZqBb6hnNttvFApMjeRHQ7A0gNptaz2HZVCiZwt6SJlv+Ir3Pe2P/uS
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935646"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:37 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Guo Ren <guoren@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] csky: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:09 +0100
Message-Id: <20220318103729.157574-14-Julia.Lawall@inria.fr>
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
 arch/csky/kernel/module.c         |    2 +-
 arch/csky/kernel/probes/uprobes.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index 6cd82d69c655..f11b3e573344 100644
--- a/arch/csky/kernel/module.c
+++ b/arch/csky/kernel/module.c
@@ -68,7 +68,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 			*location = rel[i].r_addend + sym->st_value;
 			break;
 		case R_CSKY_PC32:
-			/* Add the value, subtract its postition */
+			/* Add the value, subtract its position */
 			*location = rel[i].r_addend + sym->st_value
 							- (uint32_t)location;
 			break;
diff --git a/arch/csky/kernel/probes/uprobes.c b/arch/csky/kernel/probes/uprobes.c
index 1a9e0961b2b5..2d31a12e46cf 100644
--- a/arch/csky/kernel/probes/uprobes.c
+++ b/arch/csky/kernel/probes/uprobes.c
@@ -102,7 +102,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	struct uprobe_task *utask = current->utask;
 
 	/*
-	 * Task has received a fatal signal, so reset back to probbed
+	 * Task has received a fatal signal, so reset back to probed
 	 * address.
 	 */
 	instruction_pointer_set(regs, utask->vaddr);

