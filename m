Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD3C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 19:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbiD3TPm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 15:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244466AbiD3TPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:15:03 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC59C51E53;
        Sat, 30 Apr 2022 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KKRMEhm6E9OULXQj/2ozKvf9pBOL41UsvUOuoruylJM=;
  b=EZF+64GmXuX6iNrbjP0cHFLgu9o40cU0g+bimCQFN/pfd8v8YilNzgJH
   mH0OKWXPPpa9fX72KpVHGhBIi6Z7e9C6KhXgIJFuvI4xOZQPn/dQu6EE/
   VRgfbE2CxgvSt5o2q//H5MtFozwhqtmIfBZRji3RgWMsr+K945aWsAnED
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084621"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:11:33 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jonas Bonn <jonas@southpole.se>
Cc:     kernel-janitors@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: fix typos in comments
Date:   Sat, 30 Apr 2022 21:11:22 +0200
Message-Id: <20220430191122.8667-8-Julia.Lawall@inria.fr>
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
 arch/openrisc/mm/tlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 2b6feabf6381..e2f2a3c3bb22 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -128,7 +128,7 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 
 	/* Was seeing bugs with the mm struct passed to us. Scrapped most of
 	   this function. */
-	/* Several architctures do this */
+	/* Several architectures do this */
 	local_flush_tlb_all();
 }
 

