Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FEFC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbiFGRne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347894AbiFGRbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:31:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5D11CA11;
        Tue,  7 Jun 2022 10:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E5EACE23D0;
        Tue,  7 Jun 2022 17:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59409C385A5;
        Tue,  7 Jun 2022 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654622919;
        bh=oDouO6mdzAYWxTehzPqDRU0dUj+dYy6VSS2XFOUZUd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4maBtHIs1mmVQJImZV5T1KmfrET9mSq+tARX5xEwbI0ZTuzvXrs22jibmfoD0rvl
         QuK6A+raUXpB2BL/5z1LUd9UhoDYBkhTqu1uAueKPfhjVXoMR89Roxz/CmWS+Jlwwj
         4LnWkNc30UCHDTWUzpGEUybmVQwRP39/tgelljCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cai Huoqing <caihuoqing@baidu.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 229/452] media: staging: media: rkvdec: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue,  7 Jun 2022 19:01:26 +0200
Message-Id: <20220607164915.386816447@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164908.521895282@linuxfoundation.org>
References: <20220607164908.521895282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cai Huoqing <caihuoqing@baidu.com>

[ Upstream commit 5a3683d60e56f4faa9552d3efafd87ef106dd393 ]

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkvdec/rkvdec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index a7788e7a9542..e384ea8d7280 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1000,7 +1000,6 @@ static const char * const rkvdec_clk_names[] = {
 static int rkvdec_probe(struct platform_device *pdev)
 {
 	struct rkvdec_dev *rkvdec;
-	struct resource *res;
 	unsigned int i;
 	int ret, irq;
 
@@ -1032,8 +1031,7 @@ static int rkvdec_probe(struct platform_device *pdev)
 	 */
 	clk_set_rate(rkvdec->clocks[0].clk, 500 * 1000 * 1000);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rkvdec->regs = devm_ioremap_resource(&pdev->dev, res);
+	rkvdec->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rkvdec->regs))
 		return PTR_ERR(rkvdec->regs);
 
-- 
2.35.1



