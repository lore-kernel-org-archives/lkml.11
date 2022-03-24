Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7761EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 20:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353343AbiCXUUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiCXUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:20:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E62CE00
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F933B823FC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0264BC340EE;
        Thu, 24 Mar 2022 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648153138;
        bh=hKdgtCLHTKW5JpmSM/klB+b8X9AKmy0zwD7yd9BeetM=;
        h=From:To:Cc:Subject:Date:From;
        b=mRHXFULb62D6vkZGBQQEyu1XEwO2EAv71o4YxM4ZPGP57k7iJ71Aw5Ia6FUHwgkr8
         gt1SYUkdJryPoJEb1FuDbdwER5RhZc+gIa/brjw50YQWOuTRne/vyvX1pQX7CtNPfd
         JLBKcm/ENiTiqUdsdNjmWbl5IBniob3+mHg4EUTB3HQyrQy2p21nRjxN8aYHErRI5D
         Zp3fsyBHVL5Ib8TJPbW0U7s3MW9ElMRlHdBg2GlKv9ZEgweUKFHly8zPSBMBKxDobF
         H/GKz4HpOpNuXm3AgZwaG33Lid8AlMcJGMvqMk/Ncq3r5jjv23UYCRjHrZXyjrtnF5
         whOajX9MEAp0w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: fixed: Remove print on allocation failure
Date:   Thu, 24 Mar 2022 20:18:54 +0000
Message-Id: <20220324201854.3107077-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; h=from:subject; bh=hKdgtCLHTKW5JpmSM/klB+b8X9AKmy0zwD7yd9BeetM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiPNIO0vPQd7rXKyX3s7y09G2mXLATUiSJsQK2VyKR RiTtSVuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYjzSDgAKCRAk1otyXVSH0M6OB/ 4w/ERxxItYoMpTt8nXS4PWBLenO/BaayAEVyPXigaSBdYrA7qY8tutTOmfwExzqrlrmG8mMhPlGK/N AQjT5sClNagzD/DYAjlEZcY3jpGu/cQgaCPfw9WlJ86NOGcH974Wz228cikBmtWu4pnSOpy6xUbuva K54qvx92Osaknz2WIrcgtYVhqHBOzCAtd/7iNbmdnucw4E02HYgwq/eGUCjCqzzTQBzFJ8o8+c0nf6 wW48RrXtzp/ZhlnWgKGSCJAVAIwJsWG6mwl0InlUkrlmiVdgQXqtxtLM95+xB5S06t/KttdPRBoY0Q 12osnUwYej0sj1lN2cOLujeh88Fc56
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OOMs are very verbose, we don't need to print an additional error message
when we fail to allocate.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fixed.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 9159755cde73..57f656857580 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -236,11 +236,8 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 		drvdata->desc.supply_name = devm_kstrdup(&pdev->dev,
 					    config->input_supply,
 					    GFP_KERNEL);
-		if (!drvdata->desc.supply_name) {
-			dev_err(&pdev->dev,
-				"Failed to allocate input supply\n");
+		if (!drvdata->desc.supply_name)
 			return -ENOMEM;
-		}
 	}
 
 	if (config->microvolts)
-- 
2.30.2

