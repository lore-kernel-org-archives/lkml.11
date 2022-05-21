Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5301C43217
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354932AbiEULM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbiEULL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:11:59 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DA2AC6C;
        Sat, 21 May 2022 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JLUxnCmjuZpRDlAPV+Qqm/Wq355s+Yc5EE2zW9B19as=;
  b=fHYikL8uz02hAUW0+KQi3TpWS4tpd35IJOPmOtiHBzL7PNpP7QAs1vcD
   dpq4sd8hvXH7aI7IiKX92tCYe0/iYbJfRXiJIE1Q39Nw7PzogMzrborIy
   d2EzwriPRD4gzQs08wH+jaBN9g5V9WrixD/Ga8i1xnxsgx8NsJuxYY8w2
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727895"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:53 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] w1: w1_therm: fix typo in comment
Date:   Sat, 21 May 2022 13:10:16 +0200
Message-Id: <20220521111145.81697-6-Julia.Lawall@inria.fr>
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
 drivers/w1/slaves/w1_therm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 067692626cf0..d3f8974677f9 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -284,7 +284,7 @@ static int read_powermode(struct w1_slave *sl);
  * trigger_bulk_read() - function to trigger a bulk read on the bus
  * @dev_master: the device master of the bus
  *
- * Send a SKIP ROM follow by a CONVERT T commmand on the bus.
+ * Send a SKIP ROM follow by a CONVERT T command on the bus.
  * It also set the status flag in each slave &struct w1_therm_family_data
  * to signal that a conversion is in progress.
  *

