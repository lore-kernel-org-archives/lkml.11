Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC9AC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 11:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiCALTa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 06:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiCALTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:19:25 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A152182A;
        Tue,  1 Mar 2022 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646133524;
  x=1677669524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s61KVeR7IDgK90cr+Lg4UokrX121rEYlyy0u8g7wFe0=;
  b=IqB95zmekdpeN63GhfjXFphBgcG4g4wbLrBBAHdCCVha5TT3hyoygHtB
   4GeMlvipv/T/IsXUqiH1W3kmJbca1pMkL9Qr6r5wwgvjYuaQgr00evH9j
   J1RG8QWtqiiqYNHTGrz9L53utlofPQ72tG4f/p56sV/ZahUUz9sn+FU2a
   ggqASZCmJ91GXTkbgPNeoDiVQ8h5zE3PYmnE06nJBCxCYwlGhXnmcB9Oa
   1ILwKMxUrw6uPZxCnfTxOmpH1UjQfu54MO3PfSNOnkwh9lD9Fl+Wk35Cc
   KABmjZC6GlVxm7XVYi0ATCzVjQeHxnKdjyuKdMp+vaSe84XxEiGvYnhTU
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 2/3] regulator: virtual: warn against production use
Date:   Tue, 1 Mar 2022 12:18:30 +0100
Message-ID: <20220301111831.3742383-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
References: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is only meant for debugging and testing.  Currently, it's
not possible to use it without patching the kernel since it requires
platform data, but we'll be adding devicetree support, so add a loud
warning to make it clear that it's still only meant for debugging and
testing.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/virtual.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/virtual.c b/drivers/regulator/virtual.c
index 50d2e9caaa71..9e0abbee1df5 100644
--- a/drivers/regulator/virtual.c
+++ b/drivers/regulator/virtual.c
@@ -285,8 +285,21 @@ static int regulator_virtual_probe(struct platform_device *pdev)
 {
 	char *reg_id = dev_get_platdata(&pdev->dev);
 	struct virtual_consumer_data *drvdata;
+	static bool warned;
 	int ret;
 
+	if (!warned) {
+		warned = true;
+		pr_warn("**********************************************************\n");
+		pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+		pr_warn("**                                                      **\n");
+		pr_warn("** regulator-virtual-consumer is only for testing and   **\n");
+		pr_warn("** debugging.  Do not use it in a production kernel.    **\n");
+		pr_warn("**                                                      **\n");
+		pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+		pr_warn("**********************************************************\n");
+	}
+
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct virtual_consumer_data),
 			       GFP_KERNEL);
 	if (drvdata == NULL)
-- 
2.34.1

