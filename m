Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAABC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiCNMtG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiCNMr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:47:58 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9D3A1B1;
        Mon, 14 Mar 2022 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NDrGo4abYpLAI+P7k95QOThXiOM+RKCCrwYJwOgjGuk=;
  b=JvCBrmkRS2Be5Cq+4L5jGHxiyfvhd38YOxsm258OFYB5zUZ65bOsd/hp
   h4+nZyWbTzEaQ8+FBA3T/JlmL9Mv60Xytjsk2axJsqSqygao4LeNGDOTO
   pZcowuUKbcQDpSUoqv5CtT7wkOjtYhBMSBzx0z9EF3YvVZBIc40C4dguF
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997351"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:54:00 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/30] devres: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:42 +0100
Message-Id: <20220314115354.144023-19-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/base/devres.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index eaa9a5cd1db9..864d0b3f566e 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -692,7 +692,7 @@ EXPORT_SYMBOL_GPL(devres_release_group);
 
 /*
  * Custom devres actions allow inserting a simple function call
- * into the teadown sequence.
+ * into the teardown sequence.
  */
 
 struct action_devres {
@@ -916,7 +916,7 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
 
 	/*
 	 * We can copy the memory contents after releasing the lock as we're
-	 * no longer modyfing the list links.
+	 * no longer modifying the list links.
 	 */
 	memcpy(new_dr->data, old_dr->data,
 	       total_old_size - offsetof(struct devres, data));

