Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4DCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiCRKkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiCRKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66572DC017;
        Fri, 18 Mar 2022 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nlWcpuDMGndfcf60xo4QgJDKfAjIVOd+7i+P3kE7ioY=;
  b=pQ1G7xkQMhqAxkk16dNCBi4uroD33D3NVEVGnh00yPScoeWxCHMWU13+
   Uoq/Df3tiN8GqVqrYJA51WfMAsxwUtoZxYhmaStmRvkc2DNhSC+2qX69l
   cQ6k+33C8M8vz3LGZe6el52z2Fb6bLPSy/YLacMlNImmzW5iA5UndHG54
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935666"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:39 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Will Deacon <will@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hw_breakpoint: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:23 +0100
Message-Id: <20220318103729.157574-28-Julia.Lawall@inria.fr>
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
 arch/arm64/kernel/hw_breakpoint.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 712e97c03e54..cd868084e724 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -701,7 +701,7 @@ NOKPROBE_SYMBOL(breakpoint_handler);
  * addresses. There is no straight-forward way, short of disassembling the
  * offending instruction, to map that address back to the watchpoint. This
  * function computes the distance of the memory access from the watchpoint as a
- * heuristic for the likelyhood that a given access triggered the watchpoint.
+ * heuristic for the likelihood that a given access triggered the watchpoint.
  *
  * See Section D2.10.5 "Determining the memory location that caused a Watchpoint
  * exception" of ARMv8 Architecture Reference Manual for details.

