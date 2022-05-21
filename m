Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB435C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347573AbiEULRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354653AbiEULMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:39 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728A230546;
        Sat, 21 May 2022 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9RL4RlPTEKbV9sQnCe6LlO35i9cdmtMMaUC8SWNqNEQ=;
  b=YGkfYHte2F4FesySxJVnPHUxPskKjiUhS2N/qGNCyyKUzdXjH2cmubzZ
   xDVQMMpk+sICWv50hfH/+e/creszfjC9o9LFzpfJcaQ1JmjMf83I2u4Ij
   z3+WpKIARmuN+k9b8CnlXmNhD0SU9SsgUzlUNc+4rU1PUG5US94SWoxu+
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727944"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:00 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     kernel-janitors@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cirrus: cs89x0: fix typo in comment
Date:   Sat, 21 May 2022 13:10:57 +0200
Message-Id: <20220521111145.81697-47-Julia.Lawall@inria.fr>
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
 drivers/net/ethernet/cirrus/cs89x0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index 4a97aa8e1387..06a0c00af99c 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -985,7 +985,7 @@ net_open(struct net_device *dev)
 		if (result == DETECTED_NONE) {
 			pr_warn("%s: 10Base-5 (AUI) has no cable\n", dev->name);
 			if (lp->auto_neg_cnf & IMM_BIT) /* check "ignore missing media" bit */
-				result = DETECTED_AUI; /* Yes! I don't care if I see a carrrier */
+				result = DETECTED_AUI; /* Yes! I don't care if I see a carrier */
 		}
 		break;
 	case A_CNF_MEDIA_10B_2:

