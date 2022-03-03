Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38430C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 18:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiCCSII (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiCCSIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:08:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA51A360B;
        Thu,  3 Mar 2022 10:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12011B82664;
        Thu,  3 Mar 2022 18:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A096C004E1;
        Thu,  3 Mar 2022 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646330832;
        bh=EgcGMOXJyQ3AcaJAUNyt4ttitEYq2EccuguRq8IK5T8=;
        h=From:To:Cc:Subject:Date:From;
        b=MhPrjPEqQT4bYYon471xHSJwpVB2dLoAwjgnYAszMI/yb8szklwtOZE1zxGRrHC6b
         M66ZG4RrXlSfjssBTyPOd9GkrP6P99N1BCcyAHJ2O4z7VbK+zAj/g5HLAvcuPGi5HH
         B2LqpP8Ru7su2swz4XV4Rp1mwkAa7rY4HmSBrTPgk7eFktUSQTaAKcoefSevTez9gD
         jRSj3MCyXBeidqSMD3y3szFYdj6trzZE7punHUobNUdITuvZykBuB0mduF/bWGuSC0
         9fHDHOJszRRlcI1SveaJMmPXoZc6rz33btOOv6JiGlTqjYKekSiY2DRnTSMTRmzWT+
         MDsYztIQVLePw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPpr5-0000q6-7G; Thu, 03 Mar 2022 19:07:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] memory: renesas-rpc-if: fix platform-device leak in error path
Date:   Thu,  3 Mar 2022 19:06:32 +0100
Message-Id: <20220303180632.3194-1-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to free the flash platform device in the event that
registration fails during probe.

Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Cc: stable@vger.kernel.org      # 5.8
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/memory/renesas-rpc-if.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index e4cc64f56019..2e545f473cc6 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -651,6 +651,7 @@ static int rpcif_probe(struct platform_device *pdev)
 	struct platform_device *vdev;
 	struct device_node *flash;
 	const char *name;
+	int ret;
 
 	flash = of_get_next_child(pdev->dev.of_node, NULL);
 	if (!flash) {
@@ -674,7 +675,14 @@ static int rpcif_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	vdev->dev.parent = &pdev->dev;
 	platform_set_drvdata(pdev, vdev);
-	return platform_device_add(vdev);
+
+	ret = platform_device_add(vdev);
+	if (ret) {
+		platform_device_put(vdev);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int rpcif_remove(struct platform_device *pdev)
-- 
2.34.1

