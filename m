Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF78C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354842AbiEULU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354367AbiEULMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:39 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706232B27C;
        Sat, 21 May 2022 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N3RDg1x0n+WbKnIQmUyewjqWSlz3Ckp24b++BGrDZF8=;
  b=mEpdmp9QBpryUwFXcRalpXycTdjluSdOqCWavqcvuK+bAcVMB/dp7yNk
   g8uflwSRXq23Hx0hxKJsW10mBbBbUqbsZ68ILjOeL5NTFIh9Fg/2n9jTt
   btP34bMnLF6mkGa/5j+SbRN2U+WBpVwbs6W/2KH+DG9PxGfDP1XVo6f9r
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727941"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:59 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ctxfi: fix typo in comment
Date:   Sat, 21 May 2022 13:10:54 +0200
Message-Id: <20220521111145.81697-44-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/ctxfi/cthw20k1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 0cea4982ed7d..9edbf5d8c3c7 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -1916,7 +1916,7 @@ static int hw_card_start(struct hw *hw)
 
 	}
 
-	/* Switch to X-Fi mode from UAA mode if neeeded */
+	/* Switch to X-Fi mode from UAA mode if needed */
 	if (hw->model == CTUAA) {
 		err = uaa_to_xfi(pci);
 		if (err)

