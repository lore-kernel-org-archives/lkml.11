Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51902C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 09:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiGVJab (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiGVJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:29:35 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA761D065A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k5Mp8
        51bIF/nWAX5C4b5qJcncsyh3b9n0PP2u9PIEgg=; b=ie2S81iS18e6VgCNkTaON
        qipf3AZ3panpQrFNmVeIEYhksP1/z+iSs6kmENXrN0T3OnXcFAQRAuzkco6axOg7
        Cim9i0Cc+WjzrL0TOtMfqm9upuWkfqP6BwXctjhUOVodzuMIx+iDlhIdPTfX68Yn
        6/1B5yZzMdExKC/9beEry0=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp12 (Coremail) with SMTP id EMCowAAnNU3+atpiWEPbCw--.45S2;
        Fri, 22 Jul 2022 17:16:54 +0800 (CST)
From:   williamsukatube@163.com
To:     robert.jarzmik@free.fr, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] mtd: check the return value of devm_ioremap() in docg3_probe()
Date:   Fri, 22 Jul 2022 17:16:44 +0800
Message-Id: <20220722091644.2937953-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAAnNU3+atpiWEPbCw--.45S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWrZF15Cr1fuFyUKry8Zrb_yoWkXFc_u3
        yfZr4xtrWktFyFgF13KF1fAryftrn29FWrWwn3tFZ3CrW7ur47urWDuFn0qrWUZr9Y9ry3
        J3s8CrnF9F1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5uOJ5UUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB0AZGg2Esra8OvAAAsu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

The function devm_ioremap() in docg3_probe() can fail, so
its return value should be checked.

Fixes: 82402aeb8c81e ("mtd: docg3: Use devm_*() functions")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/mtd/devices/docg3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 5b0ae5ddad74..27c08f22dec8 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1974,9 +1974,14 @@ static int __init docg3_probe(struct platform_device *pdev)
 		dev_err(dev, "No I/O memory resource defined\n");
 		return ret;
 	}
-	base = devm_ioremap(dev, ress->start, DOC_IOSPACE_SIZE);
 
 	ret = -ENOMEM;
+	base = devm_ioremap(dev, ress->start, DOC_IOSPACE_SIZE);
+	if (!base) {
+		dev_err(dev, "devm_ioremap dev failed\n");
+		return ret;
+	}
+
 	cascade = devm_kcalloc(dev, DOC_MAX_NBFLOORS, sizeof(*cascade),
 			       GFP_KERNEL);
 	if (!cascade)
-- 
2.25.1

