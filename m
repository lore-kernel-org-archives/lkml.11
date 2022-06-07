Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B28C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 15:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbiFGPx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344442AbiFGPwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:47 -0400
Received: from smtp.ruc.edu.cn (m177126.mail.qiye.163.com [123.58.177.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E976248
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:52:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp.ruc.edu.cn (Hmail) with ESMTPSA id 9F862800A3;
        Tue,  7 Jun 2022 23:52:38 +0800 (CST)
From:   Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] spi: fix use after free in of_spi_notify
Date:   Tue,  7 Jun 2022 23:52:33 +0800
Message-Id: <20220607155233.27235-1-xiaohuizhang@ruc.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJLThlWSUxJShlPT09CTU
        5JVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6Nhw5FT00FxccMzcTDTwN
        MVEwCQFVSlVKTU5PTUpMSk5CT05PVTMWGhIXVQMSGhQTDhIBExoVHDsJDhhVHh8OVRgVRVlXWRIL
        WUFZSUtJVUpKSVVKSkhVSUpJWVdZCAFZQUpOT0I3Bg++
X-HM-Tid: 0a813ede34902c20kusn9f862800a3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't use "ctlr->dev" after it has been freed.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b9e2c7e7c580..dadfcdc6c38f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4198,14 +4198,15 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		}
 
 		spi = of_register_spi_device(ctlr, rd->dn);
-		put_device(&ctlr->dev);
 
 		if (IS_ERR(spi)) {
 			pr_err("%s: failed to create for '%pOF'\n",
 					__func__, rd->dn);
+			put_device(&ctlr->dev);
 			of_node_clear_flag(rd->dn, OF_POPULATED);
 			return notifier_from_errno(PTR_ERR(spi));
 		}
+		put_device(&ctlr->dev);
 		break;
 
 	case OF_RECONFIG_CHANGE_REMOVE:
-- 
2.17.1

