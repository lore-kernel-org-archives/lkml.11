Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE7C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355127AbiEULSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354869AbiEULMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:45 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6586152E69;
        Sat, 21 May 2022 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wk99mUaqxnYUEW+NwKnfH1fDCRBwfV2xeiTwVtMOshw=;
  b=LQlSNRFHL8ShKiBVUAAQfEELy6DglLWMyM6yheDVfaH0ETbKfljZ9hYs
   TAdPeiwz+fVl9CqdpFj8GYM7s9IEK3DyHBFlWvVg8NuagIKYvkdUzOxVN
   1XCUM0RxMo1McRIwONzKTjbyw+vResV4ZsU8fdFShX7qulvzHPIxh/SE7
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727973"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:04 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Will Deacon <will@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/arm-cci: fix typo in comment
Date:   Sat, 21 May 2022 13:11:17 +0200
Message-Id: <20220521111145.81697-67-Julia.Lawall@inria.fr>
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
 drivers/perf/arm-cci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 96e09fa40909..16a272c8d4b3 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1139,7 +1139,7 @@ static void cci_pmu_start(struct perf_event *event, int pmu_flags)
 
 	/*
 	 * To handle interrupt latency, we always reprogram the period
-	 * regardlesss of PERF_EF_RELOAD.
+	 * regardless of PERF_EF_RELOAD.
 	 */
 	if (pmu_flags & PERF_EF_RELOAD)
 		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));

