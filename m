Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA56CCA490
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358113AbiFGTvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354299AbiFGSqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:46:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A771121CDF;
        Tue,  7 Jun 2022 11:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46B07B82182;
        Tue,  7 Jun 2022 18:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C6C34119;
        Tue,  7 Jun 2022 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654624836;
        bh=1Zd8eT+4jXDy64Y37w5XfYXv5UqL+hhmiZJkakBpthI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFNlxP7W3m20qLch4UfO5nvXQdSjF6hQbXT8Mnl1SX/XoWUrQA5tP5iJSTpcrXO72
         Aizu3QkPhYt1ntxEgyGn1npk7UGwA9sAwMN0+0gAGMIEF8zJrRJlWd7fdaxLRmgShO
         vtyplA6JV7wtc6vcarmtpI7ozC5S+zCtS4SsDcE5pzhixp5cijs+kdnuaoKI6C4ZdC
         bibnny1A7rX6sVLEnBbar2QifXkgGB14k0k5tfjVlVr+aZg9lksUs2FP3gsnBmN85I
         u5nWDj1HfUfz0VGyZuUdm84AOnJCINjA/SNmAPCpFvWhkDlo9RQLYHqwgivchK14Da
         CY+rnByj1ML2A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhen Ni <nizhen@uniontech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, ok@artecdesign.ee,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 08/34] USB: host: isp116x: check return value after calling platform_get_resource()
Date:   Tue,  7 Jun 2022 13:59:43 -0400
Message-Id: <20220607180011.481266-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607180011.481266-1-sashal@kernel.org>
References: <20220607180011.481266-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Ni <nizhen@uniontech.com>

[ Upstream commit 134a3408c2d3f7e23eb0e4556e0a2d9f36c2614e ]

It will cause null-ptr-deref if platform_get_resource() returns NULL,
we need check the return value.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
Link: https://lore.kernel.org/r/20220302033716.31272-1-nizhen@uniontech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/isp116x-hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
index a87c0b26279e..00a4e12a1f15 100644
--- a/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1541,10 +1541,12 @@ static int isp116x_remove(struct platform_device *pdev)
 
 	iounmap(isp116x->data_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	release_mem_region(res->start, 2);
+	if (res)
+		release_mem_region(res->start, 2);
 	iounmap(isp116x->addr_reg);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, 2);
+	if (res)
+		release_mem_region(res->start, 2);
 
 	usb_put_hcd(hcd);
 	return 0;
-- 
2.35.1

